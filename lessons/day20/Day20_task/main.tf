

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


module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name    = module.eks.cluster_name
  node_group_name = "${var.project_name}-nodegroup"
  subnet_ids      = module.vpc.private_subnet_ids
}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}


resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd29a31"]
}



