#===================== eks_cluster/variables.tf.tf ======================

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

variable "region" {
  description = "The AWS region where the provider will operate."
  type        = string
}