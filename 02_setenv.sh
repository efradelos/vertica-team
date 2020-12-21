#!/bin/bash

export VERTICA_ENV=`terraform workspace show ./terraform`
# export VSQL_HOST=`terraform output lb_dns_name`
# export VSQL_DATABASE=`terraform output db_name`
# export VSQL_PORT=`terraform output db_port`
# export VSQL_USER=`terraform output db_user`
# export VSQL_PASSWORD="admin"

echo "export VERTICA_ENV=`terraform workspace show ./terraform`"
# echo "export VSQL_HOST=`terraform output lb_dns_name`"
# echo "export VSQL_DATABASE=`terraform output db_name`"
# echo "export VSQL_PORT=`terraform output db_port`"
# echo "export VSQL_USER=`terraform output db_user`"
# echo "export VSQL_PASSWORD=admin"
