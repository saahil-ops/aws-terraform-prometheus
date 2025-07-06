provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "developer" {
  key_name   = "devops-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "monitoring" {
  ami                         = "ami-0f918f7e67a3323f0" #forubuntu 24.0#youcanalsoaddavariablethatcanfetchthisamivalueforyou##
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.monitoring_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "PrometheusMonitoring"
  }
}

resource "aws_security_group" "monitoring_sg" {
  name = "monitoring_sg"

  ingress {
    from_port   = 0
    to_port     = 65535              #notforprodofc
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/x"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["x.x.x.x/x"]
  }
}
