variable "engine" {
  type = string
}
variable "enable_multi_az" {
  type    = bool
  default = false
}
variable "engine_version" {
  type    = string
  default = "13.13"
  validation {
    condition = contains([
      "13.13",
      "14.13",
      "15.4",
      "16.3",
      "16.4"
    ], var.engine_version)
    error_message = "Version must be within the following values,13.13,14.13,15.4,16.3,16.4."
  }
}

variable "allow_version_upgrade" {
  type    = bool
  default = false
}

variable "public_accessible" {
  type    = bool
  default = false
}

variable "back_up_window" {
  type    = string
  default = "00:10-00:40"
}

variable "retention_period" {
  type    = number
  default = 7
}

variable "maintenance_window" {
  type    = string
  default = "thu:04:20-thu:04:50"
}


variable "instance_class" {
  type = string
}
variable "vpc_security_group_ids" {
  type = list(string)
}

variable "allocated_storage" {
  type    = number
  default = 100
}

variable "storage_type" {
  type = string
}

variable "cloudwatch_log_report" {
  type    = list(string)
  default = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]
}

variable "performance_insight" {
  type    = bool
  default = false
  description = "Instance type must be greater than or equal 1 to enable performance insights."

}

variable "username" {
  type    = string
  default = "admin"
}
variable "identifier" {
  type = string
}

variable "region" {
  type = string
}

variable "infra_param_root" {
  type = string
}

variable "environment" {
  type = string
}


variable "enable_delete_protection" {
  type    = bool
  default = false
}

variable "subnet_ids" {
  type = list(any)
}

variable "db_name" {
  description = "The name of the db."
  type        = string
}