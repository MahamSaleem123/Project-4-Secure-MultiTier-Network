# Security Checklist

- [x] Root login disabled on all servers
- [x] SSH password authentication disabled
- [x] Only SSH key-based authentication allowed
- [x] App servers have no public IPs
- [x] Web servers expose only HTTP (80) publicly
- [x] SSH access to web and app servers is only via bastion
- [x] Nginx reverse proxy forwards traffic to app tier
- [x] Logs collected and stored in docs/logs/

