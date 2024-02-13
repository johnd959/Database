SET ECHO ON

SPOOl "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 9\Midterm"

DELETE MT_Home;
DELETE MT_Room;
DELETE MT_Furniture;


--this should be successful--
INSERT INTO MT_Furniture (furniture_id, furniture_name, price, est_value, height, depth, furniture_length)
VALUES ('1', 'Ottoman', 500, 300, 0.75, 1, 1);

--this should not--
INSERT INTO MT_Furniture (furniture_id, furniture_name, price, est_value, height, depth, furniture_length, purchase_date)
VALUES ('1', 'Desk', '500', 300, 0.75, 1, 1, '19-JAN-2005');

--successful--
INSERT INTO MT_Room (room_id, furniture_id, room_name, wall_colour)
VALUES ('2', '1', 'Living', 'white');

--unsucessful--
INSERT INTO MT_Room (room_id, furniture_id, room_name, wall_colour)
VALUES ('2', '2', 'Living', 'white');

--successful--
INSERT INTO MT_Home (home_id, room_id, street, city, prov, postal_code, owner_first, owner_sur, purchase_price)
VALUES ('3', '2', '123 Livingston Way', 'Saskatoon', 'SK', 'L9L9L9', 'John', 'Smith', 545000);

--unsuccessful
INSERT INTO MT_Home (home_id, room_id, street, city, prov, postal_code, owner_first, owner_sur, purchase_price)
VALUES ('4', '2', '124 Livingston Way', 'Saskatoon', 'SK', 'L9L9LL', 'Jaden', 'Smith', 545000);

SPOOL OFF