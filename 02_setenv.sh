#!/bin/bash
source ./00_utils.sh

checkEnv $1

if [ -z "$workspace" ]; then
  echo "usage: 02_setenv.sh <poc|sdlc|cust>"
  exit -1
fi

export VERTICA_ENV=`terraform -chdir=terraform workspace show`
export VSQL_HOST=`terraform -chdir=terraform output -raw lb_dns_name`
export VSQL_DATABASE=`terraform -chdir=terraform output -raw db_name`
export VSQL_PORT=`terraform -chdir=terraform output -raw db_port`
export VSQL_USER=`terraform -chdir=terraform output -raw db_user`
export VSQL_PASSWORD=`aws secretsmanager get-secret-value --secret-id=vertica/modeling/$workspace --query SecretString --output text | jq -r .db_password`

echo "export VERTICA_ENV=`terraform -chdir=terraform workspace show`"
echo "export VSQL_HOST=`terraform -chdir=terraform output -raw lb_dns_name`"
echo "export VSQL_DATABASE=`terraform -chdir=terraform output -raw db_name`"
echo "export VSQL_PORT=`terraform -chdir=terraform output -raw db_port`"
echo "export VSQL_USER=`terraform -chdir=terraform output -raw db_user`"
echo "export VSQL_PASSWORD=`aws secretsmanager get-secret-value --secret-id=vertica/modeling/$workspace --query SecretString --output text | jq -r .db_password`"
