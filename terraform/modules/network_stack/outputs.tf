output "vpc_id" {
  description = "The unique ID of the VPC."
  value       = aws_vpc.base_vpc.id
}