resource "aws_ssm_parameter" "secret_store" {
  name  = "/configuration/${var.environment}/${var.resource_type}/${var.secret_name}"
  type  = "SecureString"
  value = random_password.password.result
}