#======================= bastion/variables.tf ===========================
variable "tags" {
  description = "A mapping of tags to assign"
  default     = {}
  type        = map(string)
}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
}

#====================== Bastion host variables ==========================
variable "bastion_ami" {
  type        = string
  description = "The AMI that the Bastion Host will use."
  default     = ""
}

variable "instance_type" {
  description = "Instance size of the bastion"
  default     = "t3.nano"
}

variable "associate_public_ip_address" {
  default = true
}

variable "bastion_additional_security_groups" {
  description = "List of additional security groups to attach to the launch template"
  type        = list(string)
  default     = []
}


variable "region" {}

variable "extra_user_data_content" {
  description = "Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the `psql` command."
  type        = string
  default     = ""
}

variable "enable_logs_s3_sync" {
  description = "Enable cron job to copy logs to S3"
  type        = bool
  default     = true
}

variable "disk_encrypt" {
  description = "Instance EBS encrypt"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Root EBS size in GB"
  type        = number
  default     = 8
}

variable "bastion_name" {
  description = "Bastion Launch template Name, will also be used for the ASG"
  type        = string
  default     = "bastion"
}

variable "autoscaling_subnets" {
  type        = list(string)
  description = "List of subnet were the Auto Scalling Group will deploy the instances"
}

variable "bastion_security_group_id" {
  description = "Custom security group to use"
  default     = ""
}

variable "allow_ssh_commands" {
  description = "Allows the SSH user to execute one-off commands. Pass true to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion."
  type        = bool
  default     = false
}

variable "cidrs" {
  description = "List of CIDRs than can access to the bastion. Default : 0.0.0.0/0"
  type        = list(string)

  default = [
    "0.0.0.0/0",
  ]
}

variable "vpc_id" {
  description = "VPC id were we'll deploy the bastion"
}

variable "public_ssh_port" {
  description = "Set the SSH port to use from desktop to the bastion"
  default     = 22
}

variable "ipv6_cidrs" {
  description = "List of IPv6 CIDRs than can access to the bastion. Default : ::/0"
  type        = list(string)

  default = [
    "::/0",
  ]
}

variable "private_ssh_port" {
  description = "Set the SSH port to use between the bastion and private instance"
  default     = 22
}

variable "bastion_host_key_pair" {
  description = "Select the key pair to use to launch the bastion host"
}

#======================== S3 Bucket variables ==========================
variable "bucket_name" {
  description = "Bucket name were the bastion will store the logs"
  type        = string
}

variable "bucket_force_destroy" {
  default     = true
  description = "The bucket and all objects should be destroyed when using true"
}

variable "bucket_versioning" {
  description = "The bucket and all objects should be destroyed when using true"
  default     = true
}

variable "log_expiry_days" {
  description = "Number of days before logs expiration"
  default     = 90
}

variable "log_auto_clean" {
  description = "Enable or not the lifecycle"
  default     = false
}

variable "kms_enable_key_rotation" {
  description = "Enable key rotation for the KMS key"
  type        = bool
  default     = false
}



#======================= Loadbalancer variables ========================
variable "is_lb_private" {
  description = "If TRUE the load balancer scheme will be \"internal\" else \"internet-facing\""
}

variable "elb_subnets" {
  description = "List of subnet were the ELB will be deployed"
  type        = list(string)
}


#============================ IAM variables =============================
variable "bastion_iam_role_name" {
  description = "IAM role name to create"
  type        = string
  default     = null
}

variable "bastion_iam_permissions_boundary" {
  description = "IAM Role Permissions Boundary to constrain the bastion host role"
  default     = ""
}

variable "bastion_iam_policy_name" {
  description = "IAM policy name to create for granting the instance role access to the bucket"
  default     = "BastionHost"
}