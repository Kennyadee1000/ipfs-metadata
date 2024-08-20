output "alb_dns_name" {
  description = "The DNS name of the application load balancer."
  value       = module.alb.alb_dns_name
}

output "site_address" {
  description = "The site to access the application."
  value       = "ipfs-${var.environment}.${var.domain_name}"
}