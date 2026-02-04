module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr     = "10.0.0.0/16"
  environment  = var.environment
  aws_region   = var.aws_region
}

module "security_groups" {
  source = "./modules/security_groups"
  
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}