#====================== bastion/variables.tf =====================

variable "bastion_name" {
  description = "The name of the bastion instance."
  type        = string
}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

variable "region" {
  description = "The AWS region where the provider will operate."
  type        = string
}

