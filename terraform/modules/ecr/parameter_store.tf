resource "aws_ssm_parameter" "repository_url" {
  name  = "/configuration/${var.environment}/ecr/${var.ecr_name}/repository_url"
  type  = "String"
  value = aws_ecr_repository.ecs_repo.repository_url
}

resource "aws_ssm_parameter" "repository_name" {
  name  = "/configuration/${var.environment}/ecr/repository_name"
  type  = "String"
  value = aws_ecr_repository.ecs_repo.name
}