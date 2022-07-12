#==================== bastion/outputs.tf =======================

output "bastion_host_security_group" {
  value = module.bastion.bastion_host_security_group
}

output "bucket_kms_key_alias" {
  value = module.bastion.bucket_kms_key_alias
}

output "bucket_name" {
  value = module.bastion.bucket_name
}

output "elb_ip" {
  value = module.bastion.elb_ip
}

output "bastion_name" {
  value = module.bastion.bastion_name
}
