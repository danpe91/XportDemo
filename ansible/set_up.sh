#!/usr/bin/env bash

yum update -y

yum install ansible -y

echo 'export ANSIBLE_HOST_KEY_CHECKING=False' >> /home/vagrant/.bash_profile
