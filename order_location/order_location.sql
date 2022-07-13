WITH
  order_address AS (
  SELECT
    addresses.order_id,
    addresses.city,
    spc.state,
    LEFT(addresses.postal_code, 5) AS zip,
    addresses.country_code
  FROM
    `project_name.store_name.bc_order_shipping_addresses` AS addresses
  JOIN
    `project_name.store_name.state_postal_code` AS spc
  ON
    CASE
      WHEN LENGTH(addresses.state) = 2 THEN addresses.state = spc.state_code
    ELSE
    addresses.state = spc.state
  END
  WHERE
    country_code = 'US' )
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
WHERE
  order_status = "Completed"
  OR order_status = "Awaiting Shipment"
  OR order_status = "Partially Shipped"
  OR order_status = "Partially Refunded"
  OR order_status = "Shipped";
