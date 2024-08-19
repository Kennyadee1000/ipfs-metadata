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
  description = "The Class B subnet number for the VPC (replaces X in the CIDR block 10.X.0.0/16)."
  validation {
    condition = var.vpc_subnet_number >= 0 && var.vpc_subnet_number <= 255
    error_message = "Must be a number between 0 and 255."
  }
}