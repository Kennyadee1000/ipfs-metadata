variable "length" {
  description = "The length of the secret."
  type = number
}

variable "environment" {
  description = "The environment to store the secret."
  type = string
}

variable "resource_type" {
  description = "The type of the resources you are setting secret for."
  type = string
}

variable "secret_name" {
  description = "The name to give your secret."
  type = string
}