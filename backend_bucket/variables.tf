#====================== backend_bucket/variables.tf ========================

variable "tags" {
  description = "A mapping of tags to assign"
  default     = {}
  type        = map(string)
}

variable "env" {
  description = "Environment name to create resource in."
  type        = string
  default     = ""
}

variable "bucket_versioning" {
  description = "The bucket and all objects should be destroyed when using true"
  default     = true
}

variable "kms_enable_key_rotation" {
  description = "Enable key rotation for the KMS key"
  type        = bool
  default     = false
}

variable "read_capacity" {
  description = "The number of read units for this table."
  type        = number
  default     = 20
}

variable "write_capacity" {
  description = "The number of write units for this table."
  type        = number
  default     = 20
}

variable "hash_key" {
  description = "The name of the hash key in the index; must be defined as an attribute in the resource."
  type        = string
  default     = "LockID"
}