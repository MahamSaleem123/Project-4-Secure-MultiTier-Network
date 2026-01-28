# Project 4 – Secure Multi-Tier Network Architecture

## Branching Strategy
main      → Production  
staging   → Pre-production testing  
dev       → Development & experiments  
feature/* → New features

Flow:
feature → dev → staging → main

## Log Collection (Task 4.4)

Logs collected using Ansible fetch module:

- SSH authentication logs (/var/log/auth.log)  
  Used to verify login attempts and system access.

- Nginx access and error logs (web tier only)  
  Used to verify HTTP traffic and application errors.

Logs are stored locally under docs/logs/ for audit evidence.
