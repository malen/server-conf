#!/usr/bin/env bash

if [[ ! -e "~/.ssh/*vps.pub" ]]; then
  echo "Not found a ssh publickey like [~/.ssh/*vps.pub]. I will create it for you!"
  read -p "Please type your email." email
  read -p "Please type a password for it." passwd
  read -p "Please type your server ip address." ipaddr
  . ssh_keygen.sh "vps" "${email}" "${passwd}" "${ipaddr}"
fi