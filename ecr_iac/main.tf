provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "web_ecr_repo" {
  name  = "web_ecr"
}