#terraform {
#  backend "s3" {
#    bucket = "bpt-dev-backend-tfstate"
#    profile = "dev"
#    key = "bpt-state-file/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "bpt-dev-terraform-locks"
#    encrypt = true
#    shared_credentials_files = ["~/.aws/credentials"]
#  }
#}
