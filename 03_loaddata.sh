#!/bin/bash

echo -n 'Waiting for vertica cluster.'
while ! nc -z $VSQL_HOST $VSQL_PORT -G 2; do 
    echo -n '.'
    sleep 2
done

echo ''

ssh -i ./terraform/secrets/vertica_key $VSQL_USER@$VSQL_HOST << EOF
    cd /opt/vertica/examples/VMart_Schema
    ./vmart_gen \
        --datadirectory /tmp/vmart_schema \
        --store_sales_fact 5000000 \
        --product_dimension 500 \
        --store_dimension 50 \
        --promotion_dimension 100 \
        --years 2012-2016

    /opt/vertica/bin/vsql -p $VSQL_PORT -U $VSQL_USER -w $VSQL_PASSWORD -f vmart_define_schema.sql

    /opt/vertica/bin/vsql -p $VSQL_PORT -U $VSQL_USER -w $VSQL_PASSWORD <<SQL
        COPY Date_Dimension FROM '/tmp/vmart_schema/Date_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Product_Dimension FROM '/tmp/vmart_schema/Product_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY store.Store_Dimension FROM '/tmp/vmart_schema/Store_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Promotion_Dimension FROM '/tmp/vmart_schema/Promotion_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Vendor_Dimension FROM '/tmp/vmart_schema/Vendor_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Customer_Dimension FROM '/tmp/vmart_schema/Customer_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Employee_Dimension FROM '/tmp/vmart_schema/Employee_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Warehouse_Dimension FROM '/tmp/vmart_schema/Warehouse_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Shipping_Dimension FROM '/tmp/vmart_schema/Shipping_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY online_sales.Online_Page_Dimension FROM '/tmp/vmart_schema/Online_Page_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY online_sales.Call_Center_Dimension FROM '/tmp/vmart_schema/Call_Center_Dimension.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY store.Store_Sales_Fact FROM '/tmp/vmart_schema/Store_Sales_Fact.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY store.Store_Orders_Fact FROM '/tmp/vmart_schema/Store_Orders_Fact.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY online_sales.Online_Sales_Fact FROM '/tmp/vmart_schema/Online_Sales_Fact.tbl' DELIMITER '|' NULL '' DIRECT;
        COPY Inventory_Fact FROM '/tmp/vmart_schema/Inventory_Fact.tbl' DELIMITER '|' NULL '' DIRECT;
EOF

