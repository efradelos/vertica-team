#!/bin/bash

source ./deployment/00_utils.sh

checkEnv $1

if [ -z "$workspace" ]; then
  echo "usage: 01_deploy <poc|sdlc|cust>"
  exit -1
fi

if [ ! -f terraform/secrets/vertica_key ]; then
  mkdir -p terraform/secrets
  ssh-keygen -t rsa -b 2048 -f terraform/secrets/vertica_key -N "" -q
fi

terraform -chdir=terraform init

if [[ "`terraform -chdir=terraform workspace list`" =~ "$workspace" ]]; then
  terraform -chdir=terraform workspace select $workspace
else 
  terraform -chdir=terraform workspace new $workspace
fi

terraform -chdir=terraform workspace select $workspace
echo "yes" | terraform -chdir=terraform apply
