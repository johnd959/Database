SET ECHO ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Final\Final.txt"
set linesize 200
set pagesize 120

--Solution for Question 1--
SELECT entertainerID "Enter ID", clientID "Client ID", startDate "Date",
clientFee "Client Fee"
FROM hn_EntertainerGig
WHERE rtrim(to_char(startDate, 'MONTH'), ' ') = 'MAY' 
ORDER BY 3 DESC;


--Solution For Question 2--
column "Client Name" format A30

SELECT c.firstName || ' ' || c.lastName "Client Name", startDate, clientFee, stageName, eventType
FROM hn_Client c JOIN hn_EntertainerGig eg USING(clientID)
JOIN hn_Entertainer e USING(entertainerID)
ORDER BY c.lastName, startDate;
clear columns


--Solution for Question 3--
column "Client First" format a20
column "Client Last" format a20
column "Stage Name" format a20
column "Address" format a50

SELECT c.firstName "Client First", c.lastName "Client Last", stageName "Stage Name",
       to_char(startDate, 'Mon DD, YYYY, HH:MI am') "Event date/time", street || ', ' || City || ', ' || prov "Address"
FROM hn_Client c JOIN hn_EntertainerGig eg USING (clientID)
     JOIN hn_Entertainer e USING(entertainerID)
ORDER BY c.lastname, to_char(startDate, 'HH:MIam');
clear columns;


--Solution for Question 4--
SELECT to_char(SUM(clientFee), '$99,990.00') "Total", to_char(MAX(clientFee), '$99,990.00') "Most Expensive", to_char(AVG(clientFee), '$99,990.00') "Avg Price", count(*) "Number"
FROM hn_EntertainerGig;


--Solution for question 5--
SELECT stageName "Stagename", clientID, startDate, entertainerFee
FROM hn_EntertainerGig JOIN hn_Entertainer USING(entertainerID)
WHERE entertainerFee > (SELECT avg(entertainerFee)
                        FROM hn_EntertainerGig)
;
SPOOL OFF
