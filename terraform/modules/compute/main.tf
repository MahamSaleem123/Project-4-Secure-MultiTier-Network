resource "aws_instance" "web" {
  count         = length(var.public_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.web_sg_id]
  key_name = var.key_name

  tags = {
    Name = "web-${count.index}"
    Tier = "web"
    Project = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "app" {
  count         = length(var.private_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.app_sg_id]
  key_name = var.key_name

  tags = {
    Name = "app-${count.index}"
    Tier = "app"
    Project = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.management_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]
  key_name = var.key_name

  tags = {
    Name = "bastion"
    Tier = "management"
    Project = var.project
    Environment = var.environment
  }
}
