#====================== bastion/outputs.tf ==========================

output "bastion_host_security_group" {
  value = aws_security_group.bastion_host_security_group[*].id
}

output "bucket_kms_key_alias" {
  value = aws_kms_alias.alias.name
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "elb_ip" {
  value = aws_lb.bastion_lb.dns_name
}

output "bastion_name" {
  value = aws_autoscaling_group.bastion_auto_scaling_group.name_prefix
}

output "bastion_public_ip" {
  value = data.aws_instance.bastion.public_ip
}

output "bastion_public_dns" {
  value = data.aws_instance.bastion.public_dns
}