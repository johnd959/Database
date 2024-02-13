SET ECHO ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 9\Midterm\Part C\MidtermDBModify.txt"

ALTER TABLE MT_Home
ADD purchase_price NUMBER(9,2);

ALTER TABLE MT_Furniture
ADD purchase_date DATE DEFAULT SYSDATE;

ALTER TABLE MT_Furniture
MODIFY (price NOT NULL);

SPOOL OFF