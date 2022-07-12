#========================== vpc.tf/variables =============================

variable "vpc_cidr_block" {
  type = string
}


#======================== subnets.tf/variables ===========================
variable "max_subnets" {
  type = number
}

variable "public_subnets" {
  type = number
}

variable "public_cidrs" {}

variable "private_subnets" {
  type = number
}

variable "private_cidrs" {}

variable "azs" {}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

