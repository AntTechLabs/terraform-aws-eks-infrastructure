#===================== eks_cluster/data.tf ======================

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "${lower(var.env)}-terraform.tfstate"
    key    = "${lower(var.env)}/network/terraform.tfstate"
    region = var.region
  }
}

# data "terraform_remote_state" "bastion" {
#   backend = "s3"
#   config = {
#     bucket = "${lower(var.env)}-terraform.tfstate"
#     key    = "${lower(var.env)}/bastion/terraform.tfstate"
#     region = var.region
#   }
# }

# data "aws_instance" "bastion" {
#   filter {
#     name   = "tag:Name"
#     values = ["${data.terraform_remote_state.bastion.outputs.bastion_name}"]
#   }
# }