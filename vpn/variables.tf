#=========================== vpn/variables.tf ===============================

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign."
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "Instance size of the VPN."
  type        = string
  default     = "t2.medium"
}

variable "vpn_additional_security_groups" {
  description = "List of additional security groups to attach to the launch template"
  type        = list(string)
  default     = [""]
}

variable "vpn_key_pair" {
  description = "Select the key pair to use to launch the vpn."
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "Root EBS size in GB."
  type        = number
  default     = 8
}

variable "disk_encrypt" {
  description = "Instance EBS encrypt."
  type        = bool
  default     = true
}

variable "vpn_subnets" {
  description = "List of subnets were the Auto Scaling Group will deploy the instnaces."
  type        = list(string)
}



variable "vpc_id" {
  description = "VPC ID were we'll deploy the VPN"
  type        = string
}

variable "vpn_ports" {
  default = [22, 943, 443]
}


