SET echo ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\orderQuantity\orderQuantity.txt"

set linesize 200
set pagesize 120

column "Customer#" format a10;
column "Number of Orders#" format a20;
column "Total Costs" format a10;

select customer_number "Customer#" , count(*) "Number of Orders", to_char(sum(price * (1 + amt_tax) + ship_amt), '$9,990.00') "Total Costs"
from TB_product p join TB_order_item oi ON(p.product_number = oi.product_number)
    join TB_customer_order co on(oi.order_number = co.order_number)
group by customer_number
order by 1;


clear columns
spool off
set echo off