variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "management_subnet_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

