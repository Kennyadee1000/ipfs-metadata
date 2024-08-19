#terraform {
#  backend "s3" {
#    bucket = "bpt-prod-backend-tfstate"
#    profile = "prod"
#    key = "bpt-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpt-prod-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
