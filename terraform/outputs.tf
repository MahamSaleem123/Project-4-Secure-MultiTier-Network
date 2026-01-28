output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}

output "web_public_ips" {
  value = module.compute.web_public_ips
}

output "app_private_ips" {
  value = module.compute.app_private_ips
}
