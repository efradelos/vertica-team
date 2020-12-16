#!/bin/bash

mkdir -p ./reports
vsql -F'","' -P footer=off -AXnqf ./queries/query_09.sql | awk '{print "\""$0"\""}' > ./reports/query_09.csv
open ./reports/query_09.csv
