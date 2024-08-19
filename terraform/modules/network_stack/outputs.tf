output "vpc_id" {
  description = "The unique ID of the VPC."
  value       = aws_vpc.base_vpc.id
}

output "public_subnet_a_id" {
  description = "The unique ID of the public subnet a."
  value       = aws_subnet.public_subnet_a.id
}

output "private_subnet_a_id" {
  description = "The unique ID of the private subnet a."
  value       = aws_subnet.private_subnet_a.id
}