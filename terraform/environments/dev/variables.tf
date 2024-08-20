variable "region" {
  description = "The region to deploy the vpc."
  type        = string
}

variable "environment" {
  description = "The environment to deploy the cluster."
  type        = string
}

variable "vpc_subnet_number" {
  description = "The Class B subnet number for the VPC (replaces X in the CIDR block 10.X.0.0/16)."
  type        = string
}

variable "alb_name" {
  description = "The name of the application load balancer."
  type        = string
}


variable "target_group_port" {
  description = "The port for the target group."
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "The protocol for the target group (HTTP/HTTPS)."
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "The path for the health check endpoint."
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "The protocol for the health check (HTTP/HTTPS)."
  type        = string
  default     = "HTTP"
}

variable "enable_https" {
  description = "Enable HTTPS listener (requires SSL certificate)."
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the HTTPS listener."
  type        = string
  default     = ""
}

variable "ecr_name" {
  description = "The name of the ecr repository."
  type = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "db_name" {
  description = "The name of the db."
  type        = string
}

variable "db_user" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "go_env" {
  description = "The environment where to retrieve the go env vars."
  type        = string
}
