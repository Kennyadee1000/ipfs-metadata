output "alb_arn" {
  description = "The ARN of the application load balancer."
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the application load balancer."
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group."
  value       = aws_lb_target_group.alb_target_group.arn
}