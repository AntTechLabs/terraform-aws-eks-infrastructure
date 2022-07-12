#=========================== eks_cluster/outputs.tf ===============================

output "eks_name" {
  description = "EKS Cluster name."
  value       = module.eks.eks_name
}

output "eks_certificate_authority" {
  description = "Attribute block containing certificate-authority-data for your cluster."
  value       = module.eks.eks_certificate_authority
}

output "eks_endpoint" {
  description = "Endpoint for your Kubernetes API server."
  value       = module.eks.eks_endpoint
}

output "eks_arn" {
  description = "EKS arn."
  value       = module.eks.eks_arn
}