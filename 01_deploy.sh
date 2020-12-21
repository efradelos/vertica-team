#!/bin/bash

available_envs=(dev uat prod)
VERTICA_ENV="$1"

yes=0

for w in ${available_envs[*]}
do
  if [ "$w" == "$VERTICA_ENV" ] 
  then
      yes=1
      break
  fi
done;

if [ "$yes" -ne 1 ]; then
    echo "Error: invalid environment, exit now..."
    exit -1
fi


terraform init ./terraform
terraform workspace select $VERTICA_ENV ./terraform
echo "yes" | terraform apply ./terraform
