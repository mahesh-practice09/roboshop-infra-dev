#!/bin/bash

component=$1
git clone https://github.com/mahesh-practice09/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf
sudo ansible-playbook -e component=$1 roboshop.yaml