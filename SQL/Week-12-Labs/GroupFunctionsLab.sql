SET ECHO ON
set linesize 200
set pagesize 120
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 12\GroupFunctionsLab.txt"


--Q1
select tour_description "Tour", count(*) "# of destinations", to_char(sum(price), '$9,990.00') "Total"
from rcv_vacation_tour join rcv_tour_destination using(tour_code) join rcv_destination using(dest_code)
group by tour_description
having count(*) > 3;

--Q2
select sum(price) "Total for all customers"
from rcv_tour_customer join rcv_vacation_tour using (tour_code) join rcv_tour_destination using(tour_code) join rcv_destination using (dest_code);

SPOOL OFF