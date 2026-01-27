variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "management_subnet_id" { type = string }

variable "web_sg_id" { type = string }
variable "app_sg_id" { type = string }
variable "bastion_sg_id" { type = string }

variable "ami" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }

variable "project" { type = string }
variable "environment" { type = string }
