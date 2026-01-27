provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"

  vpc_cidr = "10.0.0.0/16"
  project  = var.project_name
  env      = var.environment
}

module "security" {
  source = "./modules/security"

  vpc_id         = module.network.vpc_id
  admin_cidr    = var.admin_cidr
  app_port      = var.app_port
  http_cidr     = var.http_allowed_cidr
}

module "compute" {
  source = "./modules/compute"

  vpc_id           = module.network.vpc_id
  public_subnets   = module.network.public_subnets
  private_subnets  = module.network.private_subnets
  management_subnet = module.network.management_subnet

  web_sg     = module.security.web_sg
  app_sg     = module.security.app_sg
  bastion_sg = module.security.bastion_sg

  web_count = var.web_count
  app_count = var.app_count

  web_type     = var.instance_type_web
  app_type     = var.instance_type_app
  bastion_type = var.instance_type_bastion

  key_name = var.key_name

  project = var.project_name
  env     = var.environment
}
