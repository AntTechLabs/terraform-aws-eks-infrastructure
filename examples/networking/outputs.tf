#===================== networking/outputs.tf ======================

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

output "public_subnets" {
  description = "The IDs of the Public Subnets."
  value       = module.networking.public_subnets
}

output "private_subnets" {
  description = "The IDs of the Private Subnets."
  value       = module.networking.private_subnets
}

output "public_subnets_cidr" {
  value = module.networking.public_subnets_cidrs
}