#!/bin/bash
sudo yum install -y docker
sudo sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16"' /etc/sysconfig/docker
sudo systemctl restart docker
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/CentOS-Base.repo
sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/CentOS-Base.repo
echo "Bootstrap complete"