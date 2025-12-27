resource "region" "example" {
  name = var.region_name
}

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}


module "eks" {
  source = "./modules/eks"

  cluster_name = "${var.project_name}-eks"
  subnet_ids   = module.vpc.private_subnet_ids
  
}

