SET ECHO ON
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 12\SingleRowFunctionsLab.txt"

column "Desc" format a25
column "Start Date" format a25
column "Duration" format a20
column "Dest Desc" format a15

break on "Desc" on "Start Date" on "Duration"
SELECT tour_description "Desc", to_char(start_date, 'MON dd, yyyy') "Start Date", end_date - start_date || ' ' || 'Days' "Duration",
--file says tour_desc should be 15 char, but output shows dest_desc having 15--
order# "Num", substr(dest_description, 1, 15) "Dest Desc", to_char(price, '$9990.00') "Price"
FROM RCV_Customer JOIN RCV_Tour_Customer USING(customer_number)
JOIN RCV_Vacation_Tour USING (tour_code)
JOIN RCV_Tour_Destination USING(tour_code)
JOIN RCV_Destination USING(dest_code)
WHERE initcap(first_name) = 'Amy'
ORDER BY tour_description, order#;
clear columns;

--Q2--
column "Cost" format a5 
column "Country" format a15
column "City" format a20
column "Desc" format a80
SELECT dest_description "Desc", 
CASE WHEN price < 50 then '$'
     WHEN price >= 50 AND price < 100 then '$$'
     WHEN price >= 100 AND price < 200 then '$$$'
     WHEN price >= 200 AND price < 500 then '$$$$'
     WHEN price >=500 then '$$$$$' end "Cost",
 country "Country", initcap(city) "City"
FROM RCV_Destination
WHERE COUNTRY != 'Canada'
AND COUNTRY != 'United States'
ORDER BY 3, 4, 2;  
clear columns;

--Q3--
column "Desc" format a80
column "Country" format a20
column "State" format a5
SELECT dest_description "Desc", 
CASE country WHEN 'United States' THEN 'USA'
             ELSE country END "Country",
nvl(state, 'NA') "State"
FROM RCV_Destination
WHERE INSTR(dest_description, 'Cook') != 0
OR
INSTR(dest_description, 'Wine') != 0
OR
INSTR(dest_description, 'Dinner') != 0
ORDER BY 2, 1;
clear columns;

SPOOL OFF