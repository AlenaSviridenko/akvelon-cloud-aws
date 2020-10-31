resource "aws_vpc" "vpc_wp" {
  cidr_block            = var.vpc_cidr
  enable_dns_hostnames  = true
  enable_dns_support    = true
}

resource "aws_internet_gateway" "gw_wp" {
  vpc_id = aws_vpc.vpc_wp.id
}

# Subnets
resource "aws_subnet" "pub_sub1_wp" {
  vpc_id                    = aws_vpc.vpc_wp.id
  cidr_block                = var.public_subnet1_cidr
  map_public_ip_on_launch   = true
  availability_zone         = var.a_zones[0]
}

resource "aws_subnet" "pub_sub2_wp" {
  vpc_id                    = aws_vpc.vpc_wp.id
  cidr_block                = var.public_subnet2_cidr
  map_public_ip_on_launch   = true
  availability_zone         = var.a_zones[1]
}

resource "aws_subnet" "priv_sub1_wp" {
  vpc_id                    = aws_vpc.vpc_wp.id
  cidr_block                = var.private_subnet1_cidr
  availability_zone         = var.a_zones[0]
}

resource "aws_subnet" "priv_sub2_wp" {
  vpc_id                    = aws_vpc.vpc_wp.id
  cidr_block                = var.private_subnet2_cidr
  availability_zone         = var.a_zones[1]
}

# Elastic IPS
resource "aws_eip" "elastic_ip1" {
  vpc = true
  depends_on = [aws_internet_gateway.gw_wp]
}

resource "aws_eip" "elastic_ip2" {
  vpc = true
  depends_on = [aws_internet_gateway.gw_wp]
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.elastic_ip1.id
  subnet_id     = aws_subnet.pub_sub1_wp.id
}

resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.elastic_ip2.id
  subnet_id     = aws_subnet.pub_sub2_wp.id
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_wp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_wp.id
  }
}

resource "aws_route_table_association" "pub_sub1_rt_assoc" {
  subnet_id      = aws_subnet.pub_sub1_wp.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_sub2_rt_assoc" {
  subnet_id      = aws_subnet.pub_sub2_wp.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Tables
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.vpc_wp.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }
}

resource "aws_route_table_association" "priv_sub1_rt_assoc" {
  subnet_id      = aws_subnet.priv_sub1_wp.id
  route_table_id = aws_route_table.private_rt1.id
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.vpc_wp.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw2.id
  }
}

resource "aws_route_table_association" "priv_sub2_rt_assoc" {
  subnet_id      = aws_subnet.priv_sub2_wp.id
  route_table_id = aws_route_table.private_rt2.id
}