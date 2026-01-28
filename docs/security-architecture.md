# Security Architecture

## Network Segmentation
The infrastructure is divided into three tiers:

- Web Tier: Public-facing EC2 instances running Nginx.
- App Tier: Private EC2 instances running the application on port 8080.
- Management Tier (Bastion): Used for administrative SSH access.

Traffic rules:
- Internet → Web Tier: HTTP (port 80) only
- Web Tier → App Tier: Application traffic on port 8080
- Bastion → Web/App Tier: SSH (port 22)
- Direct Internet → App Tier: Not allowed

This segmentation enforces least-privilege network access.

## Security Groups (Least Privilege)
- Web SG:
  - Allow inbound HTTP (80) from 0.0.0.0/0
  - Allow SSH (22) only from Bastion SG
- App SG:
  - Allow inbound 8080 only from Web SG
  - Allow SSH (22) only from Bastion SG
- Bastion SG:
  - Allow SSH (22) only from admin IP

No unnecessary ports are exposed.

## SSH Access Flow via Bastion
1. Admin connects to Bastion using SSH key.
2. From Bastion, SSH is used to access Web or App servers via private IP.
3. Direct SSH to Web/App from the internet is blocked.

## Ansible Hardening
Ansible hardening enforces:
- Root login disabled
- Password authentication disabled
- Only SSH key-based authentication allowed
- Secure SSH configuration applied consistently across servers
