module "network" {
  source = "./modules/network"

  project_name = var.project_name
}

module "security" {
  source = "./modules/security"

  project_name     = var.project_name
  vpc_id           = module.network.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  subnet_id         = module.network.subnet_id
  security_group_id = module.security.security_group_id

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
}