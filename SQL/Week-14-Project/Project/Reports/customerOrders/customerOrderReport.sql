SET echo ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\customerOrders\customerOrderReport.txt"

set linesize 200
set pagesize 120

column "Customer#" format a10;
column "Email#" format a20;
column "Order#" format a10;
column "Timber member?" format a15;
select customer_number "Customer#", email_address "Email", order_number "Order#", 
        case is_TimMem when 1 then 'Yes' else 'No' end "Timber member?"
from TB_customer join TB_customer_order using (customer_number)
order by 1,2 ;
clear columns 

spool off
set echo off
