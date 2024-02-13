SET ECHO ON
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 13\Group Exercise\GroupExSubq.txt"


--Q1 Solution-- 
SELECT state "ST", customer#, title 
FROM books JOIN orderitems USING(isbn)
JOIN orders USING(order#)
JOIN customers USING(customer#)
WHERE isbn IN (SELECT DISTINCT isbn 
FROM orderitems JOIN orders USING(order#)
JOIN customers USING(customer#)
WHERE state = 'TX')
AND state != 'TX'
ORDER BY 3, 1, 2; 

--Q2--

/*Intermediate step
SELECT isbn, count(DISTINCT state)
FROM orderitems JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn; 

-- Intermediate step 2--
SELECT max(count(DISTINCT state)) "Different states"
FROM orderitems JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn; 

--Intermediate Step 3--

SELECT isbn
FROM orderitems 
JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn
HAVING count(Distinct state) = (SELECT max(count(DISTINCT state)) "Different states"
FROM orderitems JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn); 
*/

--Q2 Solution--
SELECT DISTINCT title, state "ST"
FROM books JOIN orderitems USING(isbn)
JOIN orders USING(order#)
JOIN customers USING(customer#)
WHERE isbn IN (SELECT isbn
FROM orderitems 
JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn
HAVING count(Distinct state) = (SELECT max(count(DISTINCT state)) "Different states"
FROM orderitems JOIN orders USING(order#)
JOIN customers USING(customer#)
GROUP BY isbn))
ORDER BY 1,2;

--Q3--
/*SELECT max(count(isbn))
FROM orderitems
GROUP BY isbn;

SELECT title 
FROM orderitems
JOIN books USING(isbn)
GROUP BY title; */

--Q3 Solution-- 
SELECT title 
FROM orderitems 
JOIN books USING (isbn)
GROUP BY title
HAVING count(*) = (SELECT max(count(isbn))
FROM orderitems
GROUP BY isbn);

--Q4--

/*SELECT category, max(orderdate)
FROM orders JOIN orderitems USING(order#)
JOIN books USING(isbn)
GROUP BY category; */
--Q4--Solution
SELECT DISTINCT category, title, orderdate 
FROM orders JOIN orderitems USING(order#)
JOIN books USING(isbn)
WHERE (category, orderdate) IN (SELECT category, max(orderdate)
FROM orders JOIN orderitems USING(order#)
JOIN books USING(isbn)
GROUP BY category)
ORDER BY 1;

SPOOL OFF 