provider "aws" {
  region = "us-east-1"
}


data "aws_ami" "latest" {


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  most_recent = true
  owners = ["amazon"]
}


#Create webserver
resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.latest.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  subnet_id                   = var.aws_subnet
  user_data = "${file("config/config.sh")}"
  tags = {
    Name = "jenkins"
  }
}


#Create SG for allowing TCP/80 & TCP/22
resource "aws_security_group" "jenkins-sg" {
  name        = "sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = var.vpc
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["46.121.168.130/32"]
  }
  ingress {
    description = "allow traffic from TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


