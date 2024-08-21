#terraform {
#  backend "s3" {
#    bucket = "bpty-dev-backend-tfstate"
#    profile = "dev"
#    key = "bpty-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpty-dev-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
