#=========================== networking/variables.tf ===============================

variable "vpc_cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
}

variable "public_sn_count" {
  type = number
}

variable "private_sn_count" {
  type = number
}

variable "max_subnets" {
  type    = number
  default = 20
}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}