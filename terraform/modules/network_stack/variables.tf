variable "environment" {
  type = string
}

variable "customer" {
  type = string
}

variable "region" {
  type = string

}

variable "vpc_subnet_number" {
  type = number
  default = 0
  description = "Class B of VPC (i.e. to replace X in here: 10.X.0.0/16)."
  validation {
    condition = var.vpc_subnet_number >= 0 && var.vpc_subnet_number <= 255
    error_message = "Must be in the range [0-255]."
  }
}