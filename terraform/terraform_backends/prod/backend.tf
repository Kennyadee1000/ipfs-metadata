#terraform {
#  backend "s3" {
#    bucket = "bpty-prod-backend-tfstate"
#    profile = "prod"
#    key = "bpty-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpty-prod-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
