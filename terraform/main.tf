
module "network" {
  source = "./modules/network"

  project_name             = "CloudDevOpsProject"
  enable_nacl_associations = false
}

module "server" {
  source = "./modules/server"

  project_name = "CloudDevOpsProject"
  vpc_id       = module.network.vpc_id
  subnet_id    = module.network.public_subnet_ids[0]
}

module "ecr" {
  source = "./modules/ecr"

  project_name = "CloudDevOpsProject"
}
module "eks" {
  source = "./modules/eks"

  project_name       = "CloudDevOpsProject"
  private_subnet_ids = module.network.private_subnet_ids
}
