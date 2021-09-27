#!/bin/bash
# This script is meant to be run in the User Data of an EC2 Instance while it's booting. It starts a simple
# "Hello, World" web server.

set -e
# set -e
# sudo apt-get update
# sudo apt-get install -y python3 python3-pip
# pip3 install boto3 flask
# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# The variables below are filled in using Terraform interpolation
echo "Name = <h3>Not Much Going On Here</h3> <a href='/tags.html'><button>See Tags</button>\
        </a><span><a href='/shutdown'><button>Kill Server</button></a>" > index.html
echo "Name = ${instance_tag_name} <br> Owner = ${instance_tag_owner} <br>\
        </a><span><a href='/'><button>Go back</button></a>" > tags.html
# echo "Name = ${instance_tag_name} <br> Owner = ${instance_tag_owner}" > dead.html

nohup busybox httpd -f -p "${instance_port}" &