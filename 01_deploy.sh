#!/bin/bash

terraform init ./terraform
# echo "yes" | terraform apply ./terraform
terraform plan ./terraform
