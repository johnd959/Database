SET ECHO ON
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 13\Lab\LabSubQueries.txt"

--Q1--
/*SELECT tour_code, sum(price)
FROM RCV_Tour_Destination JOIN RCV_Destination USING(dest_code)
GROUP BY RCV_Tour_Destination.tour_code; 

SELECT max(sum(price))
FROM RCV_Tour_Destination JOIN RCV_Destination USING(dest_code)
GROUP BY RCV_Tour_Destination.tour_code; 
*/
--Solution--
SELECT tour_description, to_char(sum(price), '$9990.00') "Price" 
FROM RCV_Vacation_Tour JOIN RCV_Tour_Destination USING(tour_code)
JOIN RCV_Destination USING (dest_code)
GROUP BY tour_description
HAVING sum(price) = (SELECT max(sum(price))
FROM RCV_Tour_Destination JOIN RCV_Destination USING(dest_code)
GROUP BY RCV_Tour_Destination.tour_code);

--Q2--

/*SELECT tour_description, sum(price)
FROM RCV_Destination JOIN RCV_Tour_Destination USING(dest_code)
JOIN RCV_Vacation_Tour USING (tour_code)
WHERE tour_region = 'CA'
GROUP BY tour_description; */

--Solution--
SELECT tour_description, to_char(sum(price), '$9990.00') "Price"
FROM RCV_Destination JOIN RCV_Tour_Destination USING(dest_code)
JOIN RCV_Vacation_Tour USING(tour_code)
WHERE tour_region = 'EU'
GROUP BY tour_description
HAVING sum(price) >ANY (SELECT sum(price)
FROM RCV_Destination JOIN RCV_Tour_Destination USING(dest_code)
JOIN RCV_Vacation_Tour USING (tour_code)
WHERE tour_region = 'CA'
GROUP BY tour_description);

--Q3--

SELECT dest_description, to_char(price, '$9990.00') "Price"
FROM RCV_Destination 
WHERE price < (SELECT avg(price)
FROM RCV_Destination);

--Q4--

SELECT RCV_Customer.first_name, RCV_Customer.last_name 
FROM RCV_Customer JOIN RCV_Tour_Customer USING (customer_number)
WHERE tour_code IN (SELECT tour_code
FROM RCV_Tour_Customer JOIN RCV_Customer USING(customer_number)
JOIN RCV_Agent USING (agent_id)
WHERE RCV_Agent.first_name = 'Ethan'
AND RCV_Agent.last_name = 'Hunt')
AND RCV_Customer.agent_id != (Select agent_id
FROM RCV_Agent 
WHERE first_name = 'Ethan'
AND last_name = 'Hunt')
;
SPOOL OFF