SET ECHO ON
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 12\SingleRowFunctionsEx.txt"

--Q1--
SELECT isbn, initcap(title) "Title", NVL2(discount, 'Fixed Discount', '20% discount') "Discount Type",
    to_char(retail, '$9,990.00') "Orig Price",
    to_char(nvl(discount, retail*0.2), '$9,990.00')  "Discount",
    to_char(nvl(retail-discount, retail - retail * 0.2), '$9,990.00') "Final $"
FROM books
ORDER BY 2; 

column orderdate format a14
column shipdate format a14
column "Days to Ship" format a15
SELECT initcap(firstname) || ' ' || initcap(lastname) "Customer",  order# "Order #", to_char(orderdate, 'Month dd, yyyy') "Order Date", to_char(shipdate, 'Month dd, yyyy') "Ship Date", nvl(to_char(shipdate - orderdate), 'Not Shipped') "Days to Ship"
FROM customers JOIN orders using(customer#)
ORDER BY lastname, order#; 
clear columns;

SELECT initcap(firstname) || ' ' || initcap(lastname) "Customer", order# "Order #", title "Title", to_char(orderdate, 'dd-MON-yy') "Order Date", to_char(pubdate, 'dd-MON-yy') "Pub Date", round(months_between(orderdate, pubdate)) "Months old"
FROM customers JOIN orders USING(customer#) JOIN orderitems USING (order#) JOIN books USING (isbn)
ORDER BY lastname, order#;

SPOOL OFF