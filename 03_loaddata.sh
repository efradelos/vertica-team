#!/bin/bash

echo -n 'Waiting for vertica cluster.'
while ! nc -z $VSQL_HOST $VSQL_PORT -G 2; do 
    echo -n '.'
    sleep 2
done

echo ''

pushd ./data
vsql -f ../queries/vmart_define_schema.sql
vsql -f ../queries/vmart_load_data.sql
vsql -F'","' -P footer=off -AXnqf ../queries/vmart_query_09.sql | awk '{print "\""$0"\""}' > example.csv
open example.csv
popd


