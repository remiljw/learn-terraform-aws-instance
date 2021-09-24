terraform {
  backend "remote" {
    #         # The name of your Terraform Cloud organization.
    organization = "remi-org"
    #
    #         # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "remi-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
  access_key = var.aws_access
  secret_key = var.aws_secret
}

resource "aws_instance" "app_server" {
  ami                    = "ami-00dfe2c7ce89a450b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<EOF
  #!/bin/bash
  echo "Hello, World!" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF

  tags = var.ec2_tags

}

resource "aws_security_group" "instance" {
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "bucket32" {
  bucket = "flugel-bucket"
  acl    = "private"

  versioning {
    enabled = "true"
  }

  tags = var.s3_tags
}
