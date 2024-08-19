module "vpc" {
  source = "../../modules/network_stack"
  vpc_subnet_number = var.vpc_subnet_number
  customer    = "block-party"
  environment = var.environment
  region      = var.region
}