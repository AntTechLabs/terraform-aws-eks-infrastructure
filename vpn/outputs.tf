#=========================== vpn/outputs.tf ===============================

output "vpn_public_ip" {
  description = "Public IP of the VPN Server."
  value       = data.aws_instance.vpn.public_ip
}

output "vpn_dns" {
  description = "Public DNS of VPN Server."
  value       = data.aws_instance.vpn.public_dns
}

output "vpn_lb_dns" {
  description = "AWS LB DNS Name."
  value       = aws_lb.vpn_lb.dns_name
}