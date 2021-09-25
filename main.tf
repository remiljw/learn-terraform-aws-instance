terraform {
  backend "remote" {
    #         # The name of your Terraform Cloud organization.
    hostname     = "app.terraform.io"
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
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  ami                    = var.machine_image
  instance_type          = var.instance_type
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.app_server.id]

  tags = var.ec2_tags

}

resource "aws_security_group" "app_server" {
  name = var.ec2_tags.Name
  ingress {
    from_port   = var.instance_port
    to_port     = var.instance_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "bucket32" {
  bucket = var.bucket_prefix
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = var.s3_tags
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data/user-data.sh")

  vars = {
    instance_tag_name  = var.ec2_tags.Name
    instance_tag_owner = var.ec2_tags.Owner
    instance_port      = var.instance_port
  }
}