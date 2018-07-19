#! /bin/bash

yum update -y
rpm -U https://download-i2.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# yum install epel-release -y
yum install nginx -y
systemctl enable nxinx
systemctl start nginx
