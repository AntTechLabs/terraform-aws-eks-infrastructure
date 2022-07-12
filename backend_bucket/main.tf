#=========================== S3 Configuration ===============================

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${lower(var.env)}-terraform.tfstate"

  tags = merge(var.tags)
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = var.bucket_versioning ? "Enabled" : "Suspended"
  }
}

#========================== KMS key for S3 =================================
resource "aws_kms_key" "key" {
  enable_key_rotation = var.kms_enable_key_rotation
  tags                = merge(var.tags)
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${replace("${var.env}-terraform-state", ".", "_")}"
  target_key_id = aws_kms_key.key.arn
}


#======================== DynamoDB Table for Backend =======================
resource "aws_dynamodb_table" "terraform_state" {
  name           = "${var.env}-terraform-state"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attribute {
    name = "LockID"
    type = "S"
  }
}