#!/bin/bash

export VERTICA_ENV=`terraform -chdir=terraform workspace show`
export VSQL_HOST=`terraform -chdir=terraform output -raw lb_dns_name`
export VSQL_DATABASE=`terraform -chdir=terraform output -raw db_name`
export VSQL_PORT=`terraform -chdir=terraform output -raw db_port`
export VSQL_USER=`terraform -chdir=terraform output -raw db_user`
export VSQL_PASSWORD="admin"

echo "export VERTICA_ENV=`terraform -chdir=terraform workspace show`"
echo "export VSQL_HOST=`terraform -chdir=terraform output -raw lb_dns_name`"
echo "export VSQL_DATABASE=`terraform -chdir=terraform output -raw db_name`"
echo "export VSQL_PORT=`terraform -chdir=terraform output -raw db_port`"
echo "export VSQL_USER=`terraform -chdir=terraform output -raw db_user`"
echo "export VSQL_PASSWORD=admin"
