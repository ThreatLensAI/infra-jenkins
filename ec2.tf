resource "aws_security_group" "jenkins" {
  name   = var.jenkins_security_group_name
  vpc_id = aws_vpc.jenkins.id
}

resource "aws_vpc_security_group_ingress_rule" "jenkins" {
  count = length(var.jenkins_security_group_ingress)

  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.jenkins_security_group_ingress[count.index].cidr
  from_port         = var.jenkins_security_group_ingress[count.index].port
  ip_protocol       = var.jenkins_security_group_ingress[count.index].protocol
  to_port           = var.jenkins_security_group_ingress[count.index].port
}

resource "aws_vpc_security_group_egress_rule" "jenkins" {
  count = length(var.jenkins_security_group_egress)

  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.jenkins_security_group_egress[count.index].cidr
  from_port         = var.jenkins_security_group_egress[count.index].port
  ip_protocol       = var.jenkins_security_group_egress[count.index].protocol
  to_port           = var.jenkins_security_group_egress[count.index].port
}

resource "aws_instance" "jenkins" {
  ami           = var.jenkins_ec2.ami
  subnet_id     = aws_subnet.jenkins.id
  instance_type = var.jenkins_ec2.instance_type

  root_block_device {
    volume_size = var.jenkins_ec2.volume.size
    volume_type = var.jenkins_ec2.volume.type
  }

  vpc_security_group_ids = [aws_security_group.jenkins.id]
  tags = {
    Name = var.jenkins_ec2.instance_name
  }
}

resource "aws_eip_association" "jenkins" {
  instance_id   = aws_instance.jenkins.id
  allocation_id = var.jenkins_ec2_eip_allocation_id
}
