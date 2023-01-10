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