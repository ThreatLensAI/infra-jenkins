resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr_range
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id     = aws_vpc.jenkins_vpc.id
  cidr_block = var.subnet_cidr_range
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

  subnet_ids = [ aws_subnet.jenkins_subnet.id ]

  ingress {
    protocol   = var.network_acl_allow_rule_protocol
    rule_no    = var.network_acl_allow_rule_https_number
    action     = var.network_acl_allow_rule_action
    cidr_block = var.network_acl_allow_rule_cidr_range
    from_port  = var.network_acl_allow_rule_https_port
    to_port    = var.network_acl_allow_rule_https_port
  }

  ingress {
    protocol   = var.network_acl_allow_rule_protocol
    rule_no    = var.network_acl_allow_rule_http_number
    action     = var.network_acl_allow_rule_action
    cidr_block = var.network_acl_allow_rule_cidr_range
    from_port  = var.network_acl_allow_rule_http_port
    to_port    = var.network_acl_allow_rule_http_port
  }

  ingress {
    protocol = var.network_acl_deny_all_rule_protocol
    rule_no = var.network_acl_deny_all_rule_number
    action = var.network_acl_deny_all_rule_action
    cidr_block = var.network_acl_deny_all_rule_cidr_range
    from_port = var.network_acl_deny_all_rule_port
    to_port = var.network_acl_deny_all_rule_port
  }

  egress {
    protocol   = var.network_acl_allow_rule_protocol
    rule_no    = var.network_acl_allow_rule_https_number
    action     = var.network_acl_allow_rule_action
    cidr_block = var.network_acl_allow_rule_cidr_range
    from_port  = var.network_acl_allow_rule_https_port
    to_port    = var.network_acl_allow_rule_https_port
  }

  egress {
    protocol   = var.network_acl_allow_rule_protocol
    rule_no    = var.network_acl_allow_rule_http_number
    action     = var.network_acl_allow_rule_action
    cidr_block = var.network_acl_allow_rule_cidr_range
    from_port  = var.network_acl_allow_rule_http_port
    to_port    = var.network_acl_allow_rule_http_port
  }

  egress {
    protocol = var.network_acl_deny_all_rule_protocol
    rule_no = var.network_acl_deny_all_rule_number
    action = var.network_acl_deny_all_rule_action
    cidr_block = var.network_acl_deny_all_rule_cidr_range
    from_port = var.network_acl_deny_all_rule_port
    to_port = var.network_acl_deny_all_rule_port
  }
}