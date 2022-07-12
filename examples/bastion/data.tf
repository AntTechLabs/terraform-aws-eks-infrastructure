#==================== bastion/data.tf ==========================

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "${lower(var.env)}-terraform.tfstate"
    key    = "${upper(var.env)}/networking/terraform.tfstate"
    region = var.region
  }
}