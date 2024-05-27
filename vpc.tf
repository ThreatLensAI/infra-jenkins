resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr_range
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id            = aws_vpc.jenkins_vpc.id
  cidr_block        = var.subnet_cidr_range
  availability_zone = var.subnet_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "jenkins_internet_gateway" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_default_route_table" "jenkins_route_table" {
  default_route_table_id = aws_vpc.jenkins_vpc.default_route_table_id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.jenkins_internet_gateway.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.jenkins_vpc.default_network_acl_id

  subnet_ids = [aws_subnet.jenkins_subnet.id]

  dynamic "ingress" {
    for_each = var.network_acl_ingress
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.number
      action     = ingress.value.action
      cidr_block = ingress.value.cidr
      from_port  = ingress.value.port
      to_port    = ingress.value.port
    }
  }

  dynamic "egress" {
    for_each = var.network_acl_egress
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.number
      action     = egress.value.action
      cidr_block = egress.value.cidr
      from_port  = egress.value.port
      to_port    = egress.value.port
    }
  }
}