resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-igw"
    Project     = var.project
    Environment = var.environment
  }
}

# -------------------------
# Public subnets (Web)
# -------------------------
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "web-${count.index}"
    Tier        = "web"
    Project     = var.project
    Environment = var.environment
  }
}

# -------------------------
# Private subnets (App)
# -------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name        = "app-${count.index}"
    Tier        = "app"
    Project     = var.project
    Environment = var.environment
  }
}

# -------------------------
# Management subnet
# -------------------------
resource "aws_subnet" "management" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.management_subnet_cidr
  availability_zone = var.azs[0]

  tags = {
    Name        = "management"
    Tier        = "management"
    Project     = var.project
    Environment = var.environment
  }
}

# -------------------------
# Public route table
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

