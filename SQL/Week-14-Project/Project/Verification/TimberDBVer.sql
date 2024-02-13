SET ECHO ON

SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 8\Project\Verification\verification.txt"

SELECT * FROM TB_Tax;
SELECT * FROM TB_Category;
SELECT * FROM TB_Product;
SELECT * FROM TB_Customer;
SELECT * FROM TB_Product_Review;
SELECT * FROM TB_Customer_Order;
SELECT * FROM TB_Product_Manifest;
SELECT * FROM TB_Supplier;
SELECT * FROM TB_Order_Item;

SPOOL OFF