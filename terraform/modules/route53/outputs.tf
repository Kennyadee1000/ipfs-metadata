output "application_url" {
  value       = "${var.app_name}-${var.environment}.${var.domain_name}"
  description = "This is the url to access the application."
}