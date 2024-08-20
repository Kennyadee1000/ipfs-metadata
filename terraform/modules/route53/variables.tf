variable "app_name" {
  type        = string
  description = "The app name of the resource deployed."
}

variable "environment" {
  type        = string
  description = "The environment where resource is deployed."
}

variable "load_balance_dns_name" {
  type        = string
  description = "The dns name of the load balancer."
}

variable "load_balance_zone_id" {
  type        = string
  description = "The zone id of the load balancer."
}

variable "domain_name" {
  type        = string
  description = "The domain name to host the application."
}

variable "enable_https" {
  description = "Enable HTTPS (requires SSL certificate)."
  type        = bool
  default     = false
}