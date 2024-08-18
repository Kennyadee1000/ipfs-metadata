variable "alb_name" {
  description = "The name of the application load balancer."
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets to associate with the ALB."
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID to associate with the ALB."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed."
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