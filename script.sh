#!/bin/bash
echo "RUNNING SUDO UPDATE"
sudo apt-get update
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo apt-get install -y python3-pip  
echo "INSTALLING DEPENDENCIES"
pip3 install boto3 web.py
echo "RUNNING FILE"
nohup python3 ~/server.py --${data.template_file.user_data.instance_port} ${data.template_file.user_data.instance_tag_name} ${data.template_file.user_data.instance_tag_owner} ${data.template_file.user_data.instance_id} &