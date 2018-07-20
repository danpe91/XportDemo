#! /bin/bash

yum update -y
rpm -U https://download-i2.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# yum install epel-release -y
# yum install nginx -y
# systemctl enable nxinx
# systemctl start nginx

DD_API_KEY=641a88a25f2f2a4f882d1dde189e5eb5 bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
