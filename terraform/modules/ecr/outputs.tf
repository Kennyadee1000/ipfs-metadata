output "repository_url" {
  value = aws_ecr_repository.ecs_repo.repository_url
  description="The repository url."
}

output "registry_id" {
  value = aws_ecr_repository.ecs_repo.registry_id
  description="The registry id."
}

output "repository_name" {
  value = aws_ecr_repository.ecs_repo.name
  description="The Repository name."
}