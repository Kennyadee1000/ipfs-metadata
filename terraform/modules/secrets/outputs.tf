output "secret_location" {
  description = "The location of the secret in parameter store."
  value = "/configuration/${var.environment}/${var.resource_type}/${var.secret_name}"
}