#!/bin/bash

set -e

source ./01_deploy.sh
source ./02_setenv.sh >> /dev/null
source ./03_loaddata.sh
