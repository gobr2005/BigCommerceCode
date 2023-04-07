WITH
  order_address AS (
    /* 
       This subquery serves many purposes. First, it reduces to the zip code to the first 5 characters. The helps connected the same zip code when a customer 
       uses the Zip+4 code. Second, somes customers uses a state abbreviation so a new table was created to connect the abbreviation with the state name. The join 
       looks at the length of character in the state then joins based which column. For example, if the state was NE, then the join was between state and state_code. 
       However, if the state was Nebraska, it would join state and state. I also limited the query to the United States. 
    */
    SELECT
      addresses.order_id,
      addresses.city,
      spc.state,
      LEFT(addresses.postal_code, 5) AS zip, --This makes all the zip codes uniformed. 
      addresses.country_code
    FROM
      `project_name.store_name.bc_order_shipping_addresses` AS addresses
    JOIN
      `project_name.store_name.state_postal_code` AS spc --This is a separate table created by uploading a CSV into BigQuery
    ON
      CASE
        WHEN LENGTH(addresses.state) = 2 THEN addresses.state = spc.state_code 
        ELSE addresses.state = spc.state
      END
    WHERE
      country_code = 'US' 
  )
SELECT
  orders.order_id,
  trim(order_address.city) city,
  order_address.state,
  order_address.zip,
  orders.order_created_date_time
FROM
  `project_name.store_name.bc_order` orders
JOIN
  order_address
ON
  orders.order_id = order_address.order_id
   /*
  This WHERE statement limits the query to orders that money was exchanged. Refunded was excluded since all products were returned. 
  See BigCommerce order status meanings here: https://support.bigcommerce.com/s/article/Order-Statuses?language=en_US#order-statuses
  */
WHERE
  order_status = "Completed"
  OR order_status = "Awaiting Shipment"
  OR order_status = "Partially Shipped"
  OR order_status = "Partially Refunded"
  OR order_status = "Shipped";
