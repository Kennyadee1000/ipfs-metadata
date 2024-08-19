#terraform {
#  backend "s3" {
#    bucket = "bpa-prod-backend-tfstate"
#    profile = "prod"
#    key = "bpa-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpa-prod-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
