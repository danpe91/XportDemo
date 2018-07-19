#!/usr/bin/env bash

yum update -y

yum install ruby ruby-devel wget -y

wget https://packages.chef.io/files/stable/chefdk/3.0.36/el/7/chefdk-3.0.36-1.el7.x86_64.rpm

sudo yum install chefdk-3.0.36-1.el7.x86_64.rpm -y

yum install git -y

git config --global user.name "Daniel Pedroza"
git config --global user.email "daniel_pedroza@epam.com"
