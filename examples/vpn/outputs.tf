output "vpn_website_ip" {
  value = "https://${module.vpn.vpn_public_ip}"
}

output "vpn_website_instance_dns" {
  value = "https://${module.vpn.vpn_dns}"
}

output "vpn_website_dns" {
  value = "https://${module.vpn.vpn_lb_dns}"
}

