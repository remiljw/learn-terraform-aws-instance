#!/bin/bash
echo "RUNNING SUDO UPDATE"
sudo apt-get update
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo apt-get install -y python3-pip  
echo "INSTALLING DEPENDENCIES"
pip3 install boto3 web.py
echo "RUNNING FILE"
echo $1 $2 $3 $4
nohup python3 ~/server.py $1 "--var $2 $3 $4" &