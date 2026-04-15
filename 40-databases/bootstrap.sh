#!/bin/bash

component=$1

sudo ansible-playbook -e component=mongodb roboshop.yaml