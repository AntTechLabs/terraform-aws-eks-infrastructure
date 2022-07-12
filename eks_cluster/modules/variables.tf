#=========================== eks_cluster/modules/variables.tf ===============================

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

variable "node_groups" {
  type    = any
  default = {}
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version."
  type        = string
}

variable "wait_for_cluster_timeout" {
  description = "A timeout (in seconds) to wait for cluster to be available."
  type        = number
  default     = 300
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {}

variable "vpn_cidr" {}