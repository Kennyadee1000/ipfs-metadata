output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "rds_address" {
  value = aws_db_instance.rds_instance.address
}

output "rds_username" {
  value = aws_db_instance.rds_instance.username
}

output "rds_password" {
  value = aws_db_instance.rds_instance.password
}

output "rds_password_location" {
  value = "${var.infra_param_root}/rds/rds_admin_password"
}