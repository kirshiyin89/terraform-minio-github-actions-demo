terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-high-risk-bucket"
  
  # Deliberate security violations
  acl = "public-read"  # Explicitly making bucket public
}

resource "aws_security_group" "example" {
  name        = "allow-all"
  description = "Allow all inbound and outbound traffic"

  # Deliberately open security group
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
