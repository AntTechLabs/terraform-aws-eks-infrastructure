#===================== s3 Bucket for bastion Public Keys ======================
resource "aws_s3_bucket" "bucket" {
  bucket        = "${lower(var.env)}-${var.bucket_name}"
  force_destroy = var.bucket_force_destroy
  tags          = merge(var.tags)
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.bucket_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "log"
    status = var.enable_logs_s3_sync && var.log_auto_clean ? "Enabled" : "Disabled"

    filter {
      prefix = "logs/"
    }

    expiration {
      days = var.log_expiry_days
    }
  }
}

resource "aws_s3_object" "bucket_public_keys_readme" {
  bucket     = aws_s3_bucket.bucket.id
  key        = "public-keys/README.txt"
  content    = "Upload to here the ssh public keys of the instances you want to control."
  kms_key_id = aws_kms_key.key.arn
}

resource "aws_kms_key" "key" {
  enable_key_rotation = var.kms_enable_key_rotation
  tags                = merge(var.tags)
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${replace("${var.env}-${var.bucket_name}", ".", "_")}"
  target_key_id = aws_kms_key.key.arn
}