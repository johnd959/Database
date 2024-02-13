spool "C:\Software Development\SAIT\CPRG-307-B-SD\Week 1\Lab1.txt"
set echo on

-- 1.	Display the structure of the MM_MEMBER table. (2 marks) --
desc MM_MEMBER; 


-- 2.	Add yourself as a member. (2 marks) --
INSERT INTO MM_MEMBER (MEMBER_ID, LAST, FIRST)
VALUES (15, 'Dao', 'John'); 

Hint: Only populate the first three columns. 
-- 3.	Modify your membership by adding a made-up credit card number. Do not use your real-life credit card number. (2 marks) -- 
UPDATE MM_MEMBER
SET CREDIT_CARD = '111122223333'
WHERE MEMBER_ID = 15;


Hint: There is a check constraint on this column.

-- 4.	Remove your membership. (2 marks) --

DELETE FROM MM_MEMBER 
WHERE MEMBER_ID = 15;

-- 5.	Save your data changes. (2 marks) --
commit;

-- 6.	Display the title of each movie, the rental ID and the last names of all members who have rented those movies. (2 marks) --
SELECT MOVIE_TITLE, RENTAL_ID, LAST FROM MM_MOVIE
JOIN MM_RENTAL USING (MOVIE_ID)
JOIN MM_MEMBER USING (MEMBER_ID);

-- a.	Sort the result set by the rental ID. --
SELECT MOVIE_TITLE, RENTAL_ID, LAST FROM MM_MOVIE
JOIN MM_RENTAL USING (MOVIE_ID)
JOIN MM_MEMBER USING (MEMBER_ID)
ORDER BY RENTAL_ID;

-- b.	Ensure that no other information appears. --
-- c.	Use three tables for this query: MM_MEMBER, MM_MOVIE and MM_RENTAL. --

-- Restriction: Solve using JOIN…ON as your join method. --
SELECT MOVIE_TITLE, RENTAL_ID, LAST FROM MM_MOVIE
JOIN MM_RENTAL ON (MM_MOVIE.MOVIE_ID = MM_RENTAL.MOVIE_ID)
JOIN MM_MEMBER ON (MM_RENTAL.MEMBER_ID = MM_MEMBER.MEMBER_ID)
ORDER BY RENTAL_ID;

/*7.	Display the title of each movie, the rental ID, and the last names of all members who have rented those movies. (2 marks)
a.	No other information should appear. 
b.	Use three tables for this query: MM_MEMBER, MM_MOVIE and MM_RENTAL. 
Restriction: Solve using the traditional join method, where join is in the WHERE clause. */

SELECT MOVIE_TITLE, RENTAL_ID, LAST
FROM MM_MOVIE, MM_MEMBER, MM_RENTAL
WHERE MM_MOVIE.MOVIE_ID = MM_RENTAL.MOVIE_ID
AND MM_RENTAL.MEMBER_ID = MM_MEMBER.MEMBER_ID
ORDER BY RENTAL_ID;


-- 8.	Create a new table called MY_TABLE that is made up of three columns: MY_NUMBER, MY_DATE and MY_STRING, and that have data types: NUMBER, DATE and VARCHAR2(5), respectively. (2 marks) --
CREATE TABLE MY_TABLE (
    MY_NUMBER NUMBER CONSTRAINT MT_NUMBER_PK PRIMARY KEY, 
    MY_DATE DATE,
    MY_STRING VARCHAR2(3000)
);

-- 9.	Create a new sequence called seq_movie_id. Have the sequence start at 20 and increment by 2. (2 marks) --
CREATE SEQUENCE seq_movie_id 
START WITH 20
INCREMENT BY 2;

-- 10.	Display the sequence information (at least the last number and increment by) from the data dictionary’s user_sequences view. --
SELECT LAST_NUMBER, INCREMENT_BY FROM USER_SEQUENCES 
WHERE SEQUENCE_NAME = upper('seq_movie_id'); 

Note: Your output should only show this one sequence. 


-- 11.	Use a query to display the next sequence number on the screen. (2 marks) --
SELECT seq_movie_id.NEXTVAL FROM DUAL;

-- 12.	Change the sequence created in Step 9 to increment by 5 instead of 2. (2 marks) --
ALTER SEQUENCE seq_movie_id
INCREMENT BY 5;


-- 13.	Add your favorite movie to the MM_MOVIE table using the sequence created in Step 9 for the movie_id. (2 marks) --
INSERT INTO MM_MOVIE(MOVIE_ID, MOVIE_TITLE, MOVIE_CAT_ID, MOVIE_VALUE, MOVIE_QTY)
VALUES (seq_movie_id.NEXTVAL, 'The Great Gatsby (2013)', 5, 10.00, 20);

-- 14.	Create a view named VW_MOVIE_RENTAL using the query from either Step 6 or Step 7. (2 marks) --
CREATE VIEW VM_MOVIE_RENTAL AS 
SELECT MOVIE_TITLE, RENTAL_ID, LAST FROM MM_MOVIE
JOIN MM_RENTAL ON (MM_MOVIE.MOVIE_ID = MM_RENTAL.MOVIE_ID)
JOIN MM_MEMBER ON (MM_RENTAL.MEMBER_ID = MM_MEMBER.MEMBER_ID)
ORDER BY RENTAL_ID;


-- 15.	Use a query to display the data accessed by the VW_MOVIE_RENTAL view. (2 marks) --
SELECT * FROM VM_MOVIE_RENTAL;

 -- 16.	Make the VW_MOVIE_RENTAL view read only. (2 marks) --
CREATE OR REPLACE VIEW VM_MOVIE_RENTAL AS 
SELECT MOVIE_TITLE, RENTAL_ID, LAST FROM MM_MOVIE
JOIN MM_RENTAL ON (MM_MOVIE.MOVIE_ID = MM_RENTAL.MOVIE_ID)
JOIN MM_MEMBER ON (MM_RENTAL.MEMBER_ID = MM_MEMBER.MEMBER_ID)
ORDER BY RENTAL_ID
WITH READ ONLY;


/*17.	Using the VW_MOVIE_RENTAL view in Step 14, change the last name of the member who rented the movie with the ID of 2 to Tangier 1. (2 marks)
a.	Why does this UPDATE cause an error? */

UPDATE VM_MOVIE_RENTAL
SET LAST = 'Tangier1'
WHERE RENTAL_ID = 2; 

/* Trying to update any view that accesses two or more tables is not possible, especially if the action is not performed on the Key-preserved 
table and the where clause does not include primary Key of the view*/