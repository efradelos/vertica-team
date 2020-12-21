#!/bin/bash
set -e

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

source ./01_deploy.sh $VERTICA_ENV
source ./02_setenv.sh >> /dev/null
source ./03_loaddata.sh
source ./04_report.sh
