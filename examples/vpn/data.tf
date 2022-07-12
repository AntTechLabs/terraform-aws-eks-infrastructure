data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "${lower(var.env)}-terraform.tfstate"
    key    = "${lower(var.env)}/networking/terraform.tfstate"
    region = var.region
  }
}


