data "aws_ami" "jenkins_ami" {
  filter {
    name = "image-id"
    values = [ "ami-0b8623f29c002a373" ]
  }
}

resource "aws_instance" "jenkins_vm" {
  ami           = data.aws_ami.jenkins_ami.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.jenkins_subnet.id
  associate_public_ip_address = false

  tags = {
    Name = "jenkins"
  }
}