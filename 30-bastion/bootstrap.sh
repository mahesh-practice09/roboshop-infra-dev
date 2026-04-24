#!/bin/bash

sudo dnf install -y ansible yum-utils curl
sudo curl -o /etc/yum.repos.d/hashicorp.repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf clean all
sudo dnf makecache
sudo dnf install -y terraform
