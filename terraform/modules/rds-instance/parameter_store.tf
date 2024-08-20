resource "aws_ssm_parameter" "rds_endpoint" {
  name = "${var.infra_param_root}/rds/endpoint_address"
  description = "RDS endpoint for ${var.environment}-rds"
  type = "String"
  value = aws_db_instance.rds_instance.endpoint
}

resource "aws_ssm_parameter" "rds_address" {
  name = "${var.infra_param_root}/rds/address"
  description = "RDS address for ${var.environment}-rds"
  type = "String"
  value = aws_db_instance.rds_instance.address
}

resource "aws_ssm_parameter" "rds_admin_password" {
  name = "${var.infra_param_root}/rds/rds_admin_password"
  description = "RDS admin password for ${var.environment}-rds"
  type = "SecureString"
  value = aws_db_instance.rds_instance.password
}

resource "aws_ssm_parameter" "rds_admin_username" {
  name = "${var.infra_param_root}/rds/rds_admin_username"
  description = "RDS admin username for ${var.environment}-rds"
  type = "String"
  value = aws_db_instance.rds_instance.username
}