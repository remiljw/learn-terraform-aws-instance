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
  ami           = var.machine_image
  instance_type = var.instance_type

  provisioner "local-exec" {
    command = <<EOH
set -e
sudo apt-get update
sudo apt-get install -y python3 python3-pip
pip3 install boto3 flask

mkdir templates
cd templates

echo "Name = <h3>Not Much Going On Here</h3> <a href='/tags.html'><button>See Tags</button>\
        </a><span><a href='/shutdown'><button>Kill Server</button></a>" > index.html
echo "Name = ${data.template_file.user_data.vars.instance_tag_name} <br> Owner = ${data.template_file.user_data.vars.instance_tag_owner} <br>\
        </a><span><a href='/'><button>Go back</button></a>" > tags.html
"python3 ${path.module}/test/lom.py"
    EOH
  }
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.app_server.id]

  tags = var.resource_tags

}

resource "aws_security_group" "app_server" {
  name = var.resource_tags.Name
  ingress {
    from_port   = var.instance_port
    to_port     = var.instance_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "bucket32" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = var.resource_tags
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data/user-data.sh")

  vars = {
    instance_tag_name  = var.resource_tags.Name
    instance_tag_owner = var.resource_tags.Owner
    instance_port      = var.instance_port
  }
}