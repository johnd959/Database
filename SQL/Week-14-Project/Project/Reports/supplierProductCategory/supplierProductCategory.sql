SET echo ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 14\Project\Project\Reports\supplierProductCategory\supplierProductCategory.txt"

set linesize 200
set pagesize 120

column "Supplier#" format a15
column "Supplier Name" format a20
column "Product#" format a10
column "Product Category#" format a20

select s.supplier_number "Supplier#" , s.supplier_name "Supplier Name", pm.product_number "Product#", category_name "Product Category"
from TB_supplier s join TB_product_manifest pm on(s.supplier_number = pm.supplier_number)
    join TB_product p on(pm.product_number = p.product_number)
    join TB_category c on(p.category_num = c.category_num)
order by 1;


clear columns
spool off
set echo off