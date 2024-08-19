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