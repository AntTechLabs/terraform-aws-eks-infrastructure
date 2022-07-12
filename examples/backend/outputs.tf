#====================== backend/outputs.tf ========================

output "bucket_name" {
  description = "Bucket name"
  value       = module.backend.bucket_name
}

output "dynamodb_name" {
  description = "The name of the table."
  value       = module.backend.dynamodb_name
}