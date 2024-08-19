module "vpc" {
  source            = "../../modules/network_stack"
  vpc_subnet_number = var.vpc_subnet_number
  customer          = "block-party"
  environment       = var.environment
  region            = var.region
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "../../modules/load_balancers"
  alb_name          = var.alb_name
  security_group_id = module.security_groups.web_sg_id
  subnet_ids        = [module.vpc.public_subnet_a_id]
  vpc_id            = module.vpc.vpc_id
  enable_https      = var.enable_https
}

module "ipfs_repo" {
  source   = "../../modules/ecr"
  ecr_name = var.ecr_name
  tags     = {
    Name       = "ipfs-metadata-${var.environment}"
    Service    = "ipfs-metadata-${var.environment}"
    Repository = "ipfs-metadata"
  }
}

module "database_ecs" {
  source = "../../modules/ecs"
  cluster_id = ""
  cluster_name = ""
  container_image = ""
  container_name = ""
  security_group_id = ""
  service_name = ""
  subnet_ids = []
  task_family = ""
  task_type = ""
}
