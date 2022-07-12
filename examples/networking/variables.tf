#========================= netoworking/variables.tf ============================

variable "region" {
  description = "The AWS region where the provider will operate."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}
