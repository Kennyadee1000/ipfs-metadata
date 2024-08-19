#terraform {
#  backend "s3" {
#    bucket = "bp-prod-backend-tfstate"
#    profile = "prod"
#    key = "bp-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bp-prod-terraform-locks"
#    encrypt = true
#    shared_credentials_file = "~/.aws/credentials"
#  }
#}
