#===================== networking/backend.tf ======================

terraform {
  backend "s3" {
    bucket            = "me-terraform.tfstate"
    key               = "me/network/terraform.tfstate"
    encrypt           = true
    kms_key_id        = "alias/terraform-bucket-key"
    dynamodb_endpoint = "me-terraform-state"
  }
}

resource "aws_kms_key" "terraform_bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/terraform-bucket-key"
  target_key_id = aws_kms_key.terraform_bucket_key.key_id
}