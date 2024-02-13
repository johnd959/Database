set ECHO on
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 11\usingJoinsLab.txt"
set linesize 200
set pagesize 66



--Question 1--
column tour_description format a60
column dest_description format a75
column tour_description format a25
break on first_name on last_name
SELECT first_name, last_name, tour_description, order#, dest_description 
FROM RCV_Customer JOIN RCV_Tour_Customer USING(customer_number)
JOIN RCV_Vacation_Tour USING (tour_code)
JOIN RCV_Tour_Destination USING(tour_code)
JOIN RCV_Destination USING(dest_code)
WHERE first_name = 'Sheldon'
AND last_name = 'Cooper'
ORDER BY last_name, first_name, tour_description, order#;


--Question 2--
break on first_name on last_name
SELECT first_name, last_name, tour_description, order#, dest_description 
FROM RCV_Customer c, RCV_Tour_Customer tc, RCV_Vacation_Tour vt, RCV_Tour_Destination td,
RCV_Destination d
WHERE c.customer_number = tc.customer_number
AND tc.tour_code = vt.tour_code
AND vt.tour_code = td.tour_code
AND td.dest_code = d.dest_code
AND first_name = 'Sheldon'
AND last_name = 'Cooper'
ORDER BY last_name, first_name, tour_description, order#;

--Question 3--
SELECT UNIQUE dest_description, first_name, last_name
FROM RCV_Destination LEFT JOIN RCV_Tour_Destination ON (RCV_Destination.dest_code = RCV_Tour_Destination.dest_code)
LEFT JOIN RCV_Tour_Customer ON (RCV_Tour_Destination.tour_code = RCV_Tour_Customer.tour_code)
LEFT JOIN RCV_Customer ON (RCV_Tour_Customer.customer_number = RCV_Customer.customer_number)
WHERE RCV_Destination.country = 'Canada'
ORDER BY dest_description;

--Question 4--
column training_description format a60 
break on first_name on last_name
SELECT first_name, last_name, training_description, date_completed "Date Comp."
FROM RCV_Agent JOIN RCV_Agent_Training USING(agent_id)
JOIN RCV_Training USING(training_code)
ORDER BY first_name, last_name, training_description, date_completed;

clear columns
SPOOL off


