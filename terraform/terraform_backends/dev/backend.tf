#terraform {
#  backend "s3" {
#    bucket = "bp-dev-backend-tfstate"
#    profile = "dev"
#    key = "bp-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bp-dev-terraform-locks"
#    encrypt = true
#    shared_credentials_file = "~/.aws/credentials"
#  }
#}
