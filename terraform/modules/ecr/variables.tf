variable "tags" {
  type = map(string)
}
variable "ecr_name" {
  type = string
}

variable "environment" {
  description = "The environment of the repository."
  type = string
}