SET echo ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\productReviews\prodductReviews.txt"
column "Reviews" format a30;
column "Product ID" format a10;
column "Customer#" format a10;
column "Email" format a30;
column "Ratings" format 0.0;

set verify off
accept productID CHAR prompt "Enter the product ID: " 


select TB_Product.product_number "Product ID", TB_Customer.customer_number "Customer#", email_address "Email", rating "Ratings", comments "Reviews"
from TB_product JOIN TB_order_item ON(TB_Product.product_number = TB_Order_Item.product_number)  
JOIN TB_customer_order ON(TB_order_item.order_number = TB_Customer_order.order_number)
join TB_customer ON(TB_customer_order.customer_number = TB_Customer.customer_number)
join TB_product_review ON(TB_customer.customer_number = TB_product_review.customer_number)
where TB_Product.product_number = to_char(&productID)
order by 2;


clear columns
spool off
set echo off