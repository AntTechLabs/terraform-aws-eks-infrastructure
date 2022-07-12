#========================= backend/variables.tf ============================

variable "region" {
  description = "The AWS region where the provider will operate."
  type        = string
  default     = "us-east-1"
}