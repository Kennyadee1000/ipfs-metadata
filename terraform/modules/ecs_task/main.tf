# IAM Role for ECS Task Execution
resource "aws_iam_role" "task_execution_role" {
  name = "${var.cluster_name}-${var.task_type}TaskExecutionRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = var.execution_role_policy_arns
}

resource "aws_cloudwatch_log_group" "ecs_log" {
  name              = "/ecs/${var.task_type}-td-${var.environment}"
  retention_in_days = 3

}
# ECS Task Definition
resource "aws_ecs_task_definition" "task" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      logConfiguration : {
        logDriver = "awslogs",
        options   = {
          "awslogs-group"         = "/ecs/${var.task_type}-td-${var.environment}",
          "awslogs-region"        = var.region,
          "awslogs-stream-prefix" = "ecs"
        }
      },
      healthCheck = var.health_url != "" ? {

        retries = 3,
        command = [
          "CMD-SHELL",
          "curl -f ${var.health_url} || exit 1"
        ],
        timeout     = 5,
        interval    = 30,
        startPeriod = 30
      } : null,
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      environment = var.container_environment
      secrets     = var.secrets
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.enable_load_balancer ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }
}