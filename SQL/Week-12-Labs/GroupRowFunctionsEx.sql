SET ECHO ON 
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 12\GroupRowFunctionsEx.txt"

--Q1--
column "Commission" format a10
SELECT initcap(fname) || ' ' || initcap(lname) "Author Name", to_char(SUM(paideach*quantity), '$9990.00') "Value", to_char(SUM(paideach*quantity)*0.01, '$9990.00') "Commission"
FROM author JOIN bookauthor USING (authorid) JOIN orderitems USING (isbn)
GROUP BY initcap(fname) || ' ' || initcap(lname)
ORDER BY 1; 
clear columns;





--Q2--
SELECT initcap(firstname) "First", initcap(lastname) "Last",
    count(distinct authorid) "Number Authors"
FROM customers join orders USING (customer#) join orderitems using(order#)
JOIN books using(isbn) join bookauthor using(isbn)
GROUP BY firstname, lastname
HAVING count(distinct authorid) > 1
ORDER BY lastname, firstname; 

--Q3--
column "Avg. Profit" format a10
SELECT name, to_char(AVG(retail - cost), '$9990.00') "Avg. Profit"
FROM publisher JOIN books USING(pubid)
GROUP BY name
ORDER BY name; 
clear columns;

SPOOL OFF