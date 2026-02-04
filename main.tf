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

module "alb" {
  source = "./modules/alb"
  
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
  environment       = var.environment
}