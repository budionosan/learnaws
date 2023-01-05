terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
  }
  required_version = ">= 1.3.6"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "app_server" {
  name        = "Allow HTTP, SSH and custom TCP"
  description = "Allow HTTP, SSH and custom TCP"
  vpc_id      = "vpc-04c8a40e20cf7bbd6"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Custom TCP"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP, SSH and custom TCP"
  }
}