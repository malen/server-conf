#!/usr/bin/env bash

if [[ ! -e "~/.ssh/*vps.pub" ]]; then
  echo "Not found a ssh publickey like [~/.ssh/*vps.pub]. I will create it for you!"
  read -p "Please type a password for it:" passwd
  read -p "Please type vps's username:" username
  read -p "Please type vps's ip address:" ipaddr
  . include/ssh_keygen.sh "vps" "${passwd}" "${username}" "${ipaddr}"
fi