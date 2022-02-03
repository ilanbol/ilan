provider "aws" {
  region = "us-east-1"
}


module "ec2" {
  source = "./modules/ec2"
}

#Create webserver
resource "aws_instance" "webserver" {
  ami                         = module.ec2.ami_id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = var.aws_subnet
  user_data = "${file("config/config.sh")}"
  tags = {
    Name = "webserver"
  }
}


#Create SG for allowing TCP/80 & TCP/22
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = var.vpc.id
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_ecr_repository" "web_ecr_repo" {
  name                 = "web_ecr"
}


