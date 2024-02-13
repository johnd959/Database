SET echo ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\incomeReport\incomeReport.txt"

set linesize 200
set pagesize 120
set verify off
set feedback off
clear columns 
clear breaks
clear computes


ttitle left 'Income Report' skip 2
btitle off
break on "Customer#" skip 1 on report
compute sum label 'Cust Total Value' of "Order Value" on "Customer#"
compute num label 'Cust Total Orders' of "Order#" on "Customer#"
compute sum label 'Cust Total Values' of "Order Value" on report
compute num label 'Cust Total Orders' of "Order#" on report
column "Order Value" format $9,990.00
column "Customer#" format a20
column "Order#" format a20 

select co.customer_number "Customer#" , oi.order_number "Order#",   sum((price * (1 + amt_tax) + ship_amt))  "Order Value"
from TB_product p join TB_order_item oi ON(p.product_number = oi.product_number)
    join TB_customer_order co on(oi.order_number = co.order_number)
group by co.customer_number, oi.order_number
order by 1;

clear columns 
clear breaks
clear computes
set verify on
set feedback on
spool off
set echo off