terraform {
  backend "s3" {
    bucket            = "we-terraform.tfstate"
    key               = "we/vpn/terraform.tfstate"
    encrypt           = true
    kms_key_id        = "alias/terraform-bucket-key"
    dynamodb_endpoint = "we-terraform-state"
  }
}