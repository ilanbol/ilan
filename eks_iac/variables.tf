variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_subnet" {
  type    = string
  default = "subnet-id"
}

variable "key_name" {
  type    = string
  default = "ec2-key"
}

variable "vpc" {
  type    = string
  default = "vpc-id"
}