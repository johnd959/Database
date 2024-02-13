rem Lab Unit 10-11 Simple SELECT and Sorting 
set echo on
set linesize 100
set pagesize 66
spool "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 10\Lab\Labskeleton.txt"

rem Q1 - basic select columns with headers

rem insert solution here!

SELECT  first_name, last_name
FROM RCV_Agent 
WHERE agent_level IN ('III', 'IV')
AND AGENT_SPECIALITY != 'CA'
ORDER BY last_name;

rem Q2 

rem insert solution here!

SELECT tour_description FROM RCV_Vacation_Tour 
WHERE rating_code IN ('E', 'M')
AND tour_description LIKE '%Paris%';

rem Q3 

rem insert solution here!

column dest_description FORMAT a50
column country FORMAT a20
SELECT country, dest_description
FROM RCV_Destination
WHERE country in ('United States', 'Canada')
ORDER BY country, dest_description; 
clear columns;

spool off
