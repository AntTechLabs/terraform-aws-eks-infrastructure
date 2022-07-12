#===================== eks_cluster/backends.tf ======================

terraform {
  backend "s3" {
    bucket            = "me-terraform.tfstate"
    key               = "me/eks/terraform.tfstate"
    encrypt           = true
    kms_key_id        = "alias/me-terraform-state"
    dynamodb_endpoint = "me-terraform-state"
  }
}