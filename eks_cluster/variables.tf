#=========================== eks_cluster/variables.tf ===============================

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

variable "eks_name" {
  description = "EKS Cluster name."
  type        = string
  default     = "EKS"
}

variable "eks_version" {
  description = "EKS Cluster version."
  type        = string
}

variable "subnets" {
  type = list(string)
}

variable "node_groups" {
  type    = any
  default = {}
}

variable "workers_group_default" {
  type    = any
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "vpn_cidr" {
  type    = list(string)
  default = [""]
}