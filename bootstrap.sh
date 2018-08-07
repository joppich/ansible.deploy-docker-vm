#!/bin/sh
virtualenv env
. env/bin/activate
pip install --upgrade pip
pip install --upgrade -r requirements.txt
mkdir -p ansible-roles
# We need to call this twice because ansible-galaxy is horribly broken atm
ansible-galaxy install -r requirements.yml
ansible-galaxy install -r requirements.yml
ansible-playbook -K -i hosts setup.yml -e "deploying_user="$USER
