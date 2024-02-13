SET ECHO ON
SPOOL "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 8\Project\Build\TimberBuild.txt"

DROP TABLE TB_Order_Item CASCADE CONSTRAINTS;
DROP TABLE TB_Supplier CASCADE CONSTRAINTS;
DROP TABLE TB_Product_Manifest CASCADE CONSTRAINTS;
DROP TABLE TB_Customer_Order CASCADE CONSTRAINTS;
DROP TABLE TB_Product_Review CASCADE CONSTRAINTS;
DROP TABLE TB_Customer CASCADE CONSTRAINTS;
DROP TABLE TB_Product;
DROP TABLE TB_Category;
DROP TABLE TB_Tax;

CREATE TABLE TB_Tax(
    tax_prov CHAR(2)CONSTRAINT SYS_TB_TAX_PK PRIMARY KEY, 
    tax_rate NUMBER(2) NOT NULL,
    CONSTRAINT SYS_TB_Tax_tax_prov_CK CHECK(tax_prov in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE','YT') )
);

CREATE TABLE TB_Customer(
    customer_number VARCHAR2(60) CONSTRAINT SYS_TB_Customer_PK PRIMARY KEY,
    street_address VARCHAR2(60),
    city VARCHAR2(50),
    prov CHAR(2) CONSTRAINT SYS_TB_Customer_prov_CK CHECK (prov in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE','YT')),
    postal_code CHAR(6) CONSTRAINT SYS_TB_Customer_postCode_CK CHECK(regexp_like(postal_code, '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')),
    phone_number CHAR(12) CONSTRAINT SYS_TB_Customer_phoneNum_CK CHECK (regexp_like(phone_number, '[1-9][0-9]{2}.[0-9]{3}.[0-9]{4}')),
    email_address VARCHAR2(60) CONSTRAINT SYS_TB_Customer_emailAddr_UK UNIQUE,
    is_TimMem NUMBER(1) CONSTRAINT SYS_TB_Customer_isTimMem_CK CHECK (is_TimMem in (0, 1))
);

CREATE TABLE TB_Category(
    category_num VARCHAR2(60) CONSTRAINT SYS_TB_Category_PK PRIMARY KEY,
    category_name VARCHAR2(60) NOT NULL,
    parent_catNum VARCHAR2(60)
);

CREATE TABLE TB_Product(
    product_number VARCHAR2(60) CONSTRAINT SYS_TB_Product_PK PRIMARY KEY,
    title VARCHAR2(300) NOT NULL,
    product_description VARCHAR2 (4000), 
    price NUMBER(20, 2) NOT NULL,
    weight_kg NUMBER(6,3) NOT NULL,
    tax_exempt NUMBER(1) NOT NULL,
    category_num VARCHAR2(60) NOT NULL
);

ALTER TABLE TB_Product
ADD CONSTRAINT SYS_TB_Product_price_CK CHECK (price >= 0)
ADD CONSTRAINT SYS_TB_Product_weightKG_CK CHECK (weight_kg >= 0)
ADD CONSTRAINT SYS_TB_Product_taxExempt_CK CHECK(tax_exempt in (0, 1))
ADD CONSTRAINT SYS_TB_Category_Product_FK FOREIGN KEY (category_num) REFERENCES TB_Category(category_num);

CREATE TABLE TB_Customer_Order(
    order_number VARCHAR2(60) CONSTRAINT SYS_TB_Customer_Order_PK PRIMARY KEY,
    customer_number VARCHAr2(60) NOT NULL CONSTRAINT SYS_TB_CustomerNum_CustomOrd_FK REFERENCES TB_customer (customer_number),
    order_item VARCHAR2(60) NOT NULL,
    order_date DATE NOT NULL,
    est_deliv_date DATE,
    ship_amt NUMBER(4, 2) NOT NULL,
    amt_tax NUMBER(2),
    ship_prov CHAR(2) NOT NULL CONSTRAINT SYS_TB_Customer_Order_shipProv_CK CHECK (ship_prov in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE','YT'))
);

CREATE TABLE TB_Product_Review(
    review_number VARCHAR2(60) CONSTRAINT SYS_TB_Product_Review_PK PRIMARY KEY,
    product_number VARCHAR2(60) NOT NULL CONSTRAINT SYS_TB_Product_Product_Review__FK REFERENCES TB_Product(product_number),
    rating number(2,1) CONSTRAINT SYS_TB_Product_Review_Rating_CK CHECK (rating between 1 and 5),
    comments VARCHAR2(4000),
    review_date Date,
    price number(10) NOT NULL,
    product_weight number(6,3),
    tax_exempt NUMBER(1)
);

ALTER TABLE TB_Product_Review
ADD CONSTRAINT SYS_TB_Product_Review_price_CK CHECK(price > 0)
ADD CONSTRAINT SYS_TB_Product_Review_product_weight_CK CHECK( product_weight > 0)
ADD CONSTRAINT SYS_TB_Product_Review_tax_exempt_CK CHECK (tax_exempt in (0,1));

CREATE TABLE TB_Order_Item(
    order_number VARCHAR2(60),
    product_number VARCHAR2(60),
    CONSTRAINT SYS_TB_Order_Item_PK PRIMARY KEY (order_number, product_number),
    CONSTRAINT SYS_TB_CusOrder_OrdItem_FK FOREIGN KEY (order_number) REFERENCES TB_Customer_Order(order_number),
    CONSTRAINT SYS_TB_Product_OrdItem_FK FOREIGN KEY (product_number) REFERENCES TB_Product(product_number)
);

-- CREATE TABLE TB_Category(
--     category_num VARCHAR2(60) CONSTRAINT TB_Category_PK PRIMARY KEY,
--     category_name VARCHAR2(60) NOT NULL,
--     parent_category_number VARCHAR2(60)
-- ) ;
CREATE TABLE TB_Supplier(
    supplier_number VARCHAR2(60) CONSTRAINT SYS_TB_Supplier_PK PRIMARY KEY,
    supplier_name VARCHAR2(60) NOT NULL CONSTRAINT SYS_TB_Supplier_supplier_name_UK UNIQUE,
    email VARCHAR2(60) NOT NULL CONSTRAINT SYS_TB_Supplier_emaill_UK UNIQUE,
    supplier_city VARCHAR2(60),
    supplier_prov CHAR(2)
);

CREATE TABLE TB_Product_Manifest(
    supplier_number VARCHAR2(60),
    product_number VARCHAR2(60),
    quantity NUMBER(5) NOT NULL CONSTRAINT SYS_TB_Product_Manifest_quantity_CK CHECK(quantity >= 0),
    est_days NUMBER(3) NOT NULL CONSTRAINT SYS_TB_Product_Manifest_est_days_CK CHECK(est_days >= 0),
    CONSTRAINT SYS_TB_Product_Manifest_PK PRIMARY KEY(supplier_number,product_number),
    CONSTRAINT SYS_TB_Supplier_ProductManifest_FK FOREIGN KEY(supplier_number) REFERENCES TB_Supplier(supplier_number),
    CONSTRAINT SYS_TB_Category_ProductManifest_FK FOREIGN KEY(product_number) REFERENCES TB_Category(category_num)
);

SPOOL OFF