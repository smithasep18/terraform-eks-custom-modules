module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  cluster_name    = var.cluster_name
}

module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name     = var.cluster_name
  cluster_role_arn = module.iam.cluster_role_arn
  subnet_ids       = module.vpc.private_subnet_ids

  depends_on = [module.iam]
}

module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name        = module.eks.cluster_name
  node_group_role_arn = module.iam.node_group_role_arn
  subnet_ids          = module.vpc.private_subnet_ids

  depends_on = [module.eks]
}