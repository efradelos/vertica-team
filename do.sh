#!/bin/bash
set -e

source ./00_utils.sh

checkEnv $1

if [ -z "$workspace" ]; then
  echo "usage: do.sh <poc|sdlc|cust>"
  exit -1
fi

source ./01_deploy.sh $workspace
source ./02_setenv.sh $workspace >> /dev/null
source ./03_loaddata.sh
source ./04_report.sh
