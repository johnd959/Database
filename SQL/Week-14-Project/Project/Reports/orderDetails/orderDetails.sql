SET ECHO ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\orderDetails\orderDetails.txt"

SET linesize 200
SET pagesize 120

column "Order#" format a10
column "Customer#" format a10
column "Order Item" format a15
column "Order Date" format a10
column "Shipping" format 9990.99
column "Shipping Province" format a20
column "Tax%" format 90.99

SELECT order_number "Order#", customer_number "Customer#", order_item "Order Item", order_date "Order Date", to_char(ship_amt, '$9990.99') "Shipping",
ship_prov "Shipping Province", tax_rate "Tax%"  
FROM TB_Customer_Order JOIN TB_Tax ON(TB_Customer_Order.ship_prov = TB_Tax.tax_prov)
WHERE TB_Customer_Order.customer_number = (SELECT TB_customer.customer_number
FROM TB_Customer 
WHERE email_address Like 'amelia.cox@%');

clear columns
spool off