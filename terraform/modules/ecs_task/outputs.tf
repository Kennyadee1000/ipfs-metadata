output "task_definition_arn" {
  description = "The ARN of the ECS task definition."
  value       = aws_ecs_task_definition.task.arn
}

output "service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.service.name
}