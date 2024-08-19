variable "state_bucket_name" {
  description = "The name of the bucket to use as state bucket."
  default = "bp-dev-backend-tfstate"
}

variable "dynamo_lock_table" {
  description = "The name of the table to use as state lock."
  default = "bp-dev-terraform-locks"
}