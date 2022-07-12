#==================== bastion/backend.tf =======================
terraform {
  backend "s3" {
    bucket            = "uat-terraform.tfstate"
    key               = "UAT/bastion/terraform.tfstate"
    encrypt           = true
    kms_key_id        = "alias/UAT-terraform-state"
    dynamodb_endpoint = "UAT-terraform-state"
  }
}