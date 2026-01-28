provider "aws" {
  region = var.region
}

module "network" {
  source   = "./modules/network"
  vpc_cidr = "10.0.0.0/16"

  project     = var.project_name
  environment = var.environment

  public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs   = ["10.0.11.0/24", "10.0.12.0/24"]
  management_subnet_cidr = "10.0.50.0/24"
  azs                    = ["us-east-1a", "us-east-1b"]
}


module "security" {
  source            = "./modules/security"
  vpc_id            = module.network.vpc_id
  admin_cidr        = var.admin_cidr
  app_port          = var.app_port
  http_allowed_cidr = var.http_allowed_cidr
}


module "compute" {
  source = "./modules/compute"

  # Networking
  public_subnet_ids    = module.network.public_subnet_ids
  private_subnet_ids   = module.network.private_subnet_ids
  management_subnet_id = module.network.management_subnet_id

  # Security Groups
  web_sg_id     = module.security.web_sg_id
  app_sg_id     = module.security.app_sg_id
  bastion_sg_id = module.security.bastion_sg_id

  # EC2
  ami           = var.ami
  instance_type = var.instance_type_app
  key_name      = var.key_name

  # Meta
  project     = var.project_name
  environment = var.environment
}

