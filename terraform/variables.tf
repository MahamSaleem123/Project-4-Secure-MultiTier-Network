variable "region" {
  type    = string
  default = "me-central-1"
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "admin_cidr" {
  type = string
}

variable "http_allowed_cidr" {
  type = string
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "instance_type_web" {
  type = string
}

variable "instance_type_app" {
  type = string
}

variable "instance_type_bastion" {
  type = string
}

variable "web_count" {
  type = number
}

variable "app_count" {
  type = number
}

variable "key_name" {
  type = string
}
