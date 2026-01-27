output "web_public_ips" {
  value = aws_instance.web[*].public_ip
}

output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
