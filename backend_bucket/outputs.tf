#====================== backend_bucket/outputs.tf ========================

output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_name" {
  description = "The name of the table."
  value       = aws_dynamodb_table.terraform_state.id
}