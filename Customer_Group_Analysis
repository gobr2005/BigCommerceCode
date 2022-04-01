WITH
  all_products AS (
    SELECT
      product_variants.product_id,
      product_variants.variants_id,
      product_variants.variants_sku,
      products.product_name,
      products.sku
    FROM
      `project_name.store_name.bc_product_variants` product_variants
    JOIN
      `project_name.store_name.bc_product` products
    ON
      product_variants.product_id = products.product_id ),
  all_orders AS (
    SELECT
      line_items.order_id,
      bc_orders.order_status,
      bc_orders.customer_id,
      line_items.variant_id,
      line_items.quantity,
      line_items.total_inc_tax,
      line_items.refund_amount,
      bc_orders.order_created_date_time
    FROM
      `project_name.store_name.bc_order_line_items` line_items
    JOIN
      `project_name.store_name.bc_order` bc_orders
    ON
      line_items.order_id = bc_orders.order_id
    WHERE bc_orders.order_status != 'Cancelled'
    AND bc_orders.order_status != 'Incomplete'
    AND bc_orders.order_status != 'Refunded'
    AND bc_orders.order_status != 'Manual Verification Required'
   )
SELECT
  all_orders.order_id,
  all_orders.order_status,
  all_orders.customer_id,
  all_orders.variant_id,
  all_products.variants_sku,
  all_products.product_name,
  all_orders.quantity,
  all_orders.total_inc_tax,
  all_orders.refund_amount,
  all_orders.order_created_date_time
FROM 
  all_orders
JOIN
  all_products
ON
  all_orders.variant_id = all_products.variants_id
ORDER BY
  1;
