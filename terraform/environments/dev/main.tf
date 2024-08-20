module "vpc" {
  source            = "../../modules/network_stack"
  vpc_subnet_number = var.vpc_subnet_number
  customer          = "block-party"
  environment       = var.environment
  region            = var.region
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "../../modules/load_balancers"
  alb_name          = var.alb_name
  security_group_id = module.security_groups.web_sg_id
  subnet_ids        = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
  vpc_id            = module.vpc.vpc_id
  enable_https      = var.enable_https
}

module "ipfs_repo" {
  source      = "../../modules/ecr"
  ecr_name    = var.ecr_name
  environment = var.environment
  tags        = {
    Name       = "ipfs-metadata-${var.environment}"
    Service    = "ipfs-metadata-${var.environment}"
    Repository = "ipfs-metadata"
  }
}

resource "aws_ecs_cluster" "ipfs_cluster" {
  name = var.cluster_name
}

module "postgres_db" {
  source                   = "../../modules/rds-instance"
  allocated_storage        = 20
  storage_type             = "gp2"
  engine                   = "postgres"
  engine_version           = "16.3"
  environment              = var.environment
  instance_class           = "db.t3.micro"
  username                 = var.db_user
  enable_multi_az          = false
  performance_insight      = true
  enable_delete_protection = false
  public_accessible        = false
  identifier               = "ipfs-rds"
  region                   = var.region
  infra_param_root         = "/configuration/${var.environment}"
  vpc_security_group_ids   = [module.security_groups.database_sg_id]
  subnet_ids               = [module.vpc.private_subnet_a_id, module.vpc.private_subnet_b_id]
  db_name                  = var.db_name
}

module "ipfs_task" {
  source                = "../../modules/ecs_task"
  cluster_name          = aws_ecs_cluster.ipfs_cluster.name
  cluster_id            = aws_ecs_cluster.ipfs_cluster.id
  task_type             = "app"
  task_family           = "ipfs-app-task"
  container_name        = "ipfs-metadata"
  container_image       = "${module.ipfs_repo.repository_url}:latest"
  container_port        = 8080
  container_environment = [
    { name = "POSTGRES_HOST", value = module.postgres_db.rds_address },
    { name = "POSTGRES_PORT", value = "5432" },
    { name = "POSTGRES_USER", value = var.db_user },
    { name = "POSTGRES_DB", value = var.db_name }
  ]
  secrets                    = [{ name = "POSTGRES_PASSWORD", valueFrom = module.postgres_db.rds_password_location }]
  desired_count              = 2
  subnet_ids                 = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
  security_group_id          = module.security_groups.resource_sg_id
  assign_public_ip           = true
  enable_load_balancer       = true
  target_group_arn           = module.alb.target_group_arn
  execution_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]
  service_name = "ipfs-metadata-service"
  environment  = var.environment
  region       = var.region
}