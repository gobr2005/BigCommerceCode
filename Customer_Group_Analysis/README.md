# Customer Group Analysis

## Description
As of March 2022, BigCommerce does not have a way to filter sales data in Google Data Studio using Customer Groups. The code stored here allows a user to pull data and create a dashboard to show sales within a customer group. The customer_id from the bc_order table is necessary for this to work. This can be added to any [BigCommerce Data Studio template](https://support.bigcommerce.com/s/article/Google-Data-Studio?language=en_US) with the orders table. In addition to the code, creating a custom customer export in BigCommerce with Customer ID and Customer Group. This can be imported into Google Sheets and connected to Data Studio.

I learned SQL about a year before this repository was created. This may not be the best way to combine all the data. I felt the need to create template tables to combine orders with order line items and products with product variants before I combined everything together. 
