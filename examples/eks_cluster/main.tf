#===================== EKS Cluster's root module =========================
module "eks_cluster" {
  source = "git::https://tynchtyk642@github.com/tynchtyk642/terraform-aws-modules.git//eks_cluster?ref=main"

  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id
  eks_name    = "test1"
  eks_version = "1.20"
  subnets     = data.terraform_remote_state.networking.outputs.private_subnets
  vpn_cidr    = data.terraform_remote_state.networking.outputs.public_subnets_cidr

  node_groups = {
    first = {
      node_group_name = "test"
      desired_size    = 3
      max_size        = 4
      min_size        = 2

      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]
    },
  }
}
