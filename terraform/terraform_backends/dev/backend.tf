#terraform {
#  backend "s3" {
#    bucket = "bpa-dev-backend-tfstate"
#    profile = "dev"
#    key = "bpa-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpa-dev-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
