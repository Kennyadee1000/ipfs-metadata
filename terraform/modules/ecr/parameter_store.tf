resource "aws_ssm_parameter" "repository_url" {
  name  = "/configuration/${var.environment}/ecr/${var.ecr_name}/repository_url"
  type  = "String"
  value = aws_ecr_repository.ecs_repo.repository_url
}