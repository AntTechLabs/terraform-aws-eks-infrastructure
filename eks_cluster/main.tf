#=========================== eks_cluster/main.tf ===============================

module "eks" {
  source = "./modules"

  vpc_id          = var.vpc_id
  cluster_name    = var.eks_name
  cluster_version = var.eks_version
  vpn_cidr        = var.vpn_cidr
  env             = var.env

  subnet_ids = var.subnets

  node_groups = var.node_groups
}