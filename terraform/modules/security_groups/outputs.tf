output "web_sg_id" {
  description = "The security group ID of the web facing services."
  value       = aws_security_group.web_sg.id
}

output "resource_sg_id" {
  description = "The security group ID of the internal resources."
  value       = aws_security_group.resource_server_sg.id
}

output "database_sg_id" {
  description = "The security group ID of the database."
  value       = aws_security_group.database_sg.id
}