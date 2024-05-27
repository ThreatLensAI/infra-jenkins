data "aws_ami" "jenkins_ami" {
  filter {
    name   = var.jenkins_ami_filter_name
    values = [var.jenkins_ami_filter_value]
  }
}

resource "aws_security_group" "jenkins_allow" {
  name   = var.jenkins_security_group_name
  vpc_id = aws_vpc.jenkins_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "name" {
  for_each = var.jenkins_security_group_ingress_rules

  security_group_id = aws_security_group.jenkins_allow.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  ip_protocol       = each.value.protocol
  to_port           = each.value.port
}

resource "aws_instance" "jenkins_vm" {
  ami                         = data.aws_ami.jenkins_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.jenkins_subnet.id
  associate_public_ip_address = var.ec2_associate_public_ip_address

  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = var.ec2_root_volume_type
  }

  vpc_security_group_ids = [aws_security_group.jenkins_allow.id]
  tags = {
    Name = var.ec2_instance_name
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_vm.id
  allocation_id = var.eip_allocation_id
}