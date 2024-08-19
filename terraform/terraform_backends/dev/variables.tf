variable "state_bucket_name" {
  description = "The name of the bucket to use as state bucket."
  default = "bpty-dev-backend-tfstate"
}

variable "dynamo_lock_table" {
  description = "The name of the table to use as state lock."
  default = "bpty-dev-terraform-locks"
}