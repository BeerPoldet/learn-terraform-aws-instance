terraform {
  backend "remote" {
    organization = "beerpoldet"
    workspaces {
      name = "Example-Workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0e999cbd62129e3b1"
  instance_type = "t2.nano"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
