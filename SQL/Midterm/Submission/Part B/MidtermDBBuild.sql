SET ECHO ON
SPOOl "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 9\Midterm\Part B\MidtermDBBuild.txt"

DROP TABLE MT_Home CASCADE CONSTRAINTS;
DROP TABLE MT_Room CASCADE CONSTRAINTS;
DROP TABLE MT_Furniture CASCADE CONSTRAINTS; 



CREATE TABLE MT_Furniture(
    furniture_id VARCHAR2(60) CONSTRAINT SYS_MT_Furniture_PK PRIMARY KEY,
    furniture_name VARCHAR2(60) NOT NULL,
    price NUMBER(7,2),
    est_value NUMBER(7,2),
    height NUMBER(3,2) CONSTRAINT SYS_MT_Furniture_Height_CK CHECK(height > 0) NOT NULL,
    depth NUMBER(3,2) CONSTRAINT SYS_MT_Furniture_Depth_CK CHECK(depth > 0) NOT NULL,
    furniture_length NUMBER(3,2) CONSTRAINT SYS_MT_Furniture_Length_CK CHECK(furniture_length > 0) NOT NULL
);

CREATE TABLE MT_Room(
    room_id VARCHAR2(60) CONSTRAINT SYS_MT_Room_PK PRIMARY KEY,
    furniture_id VARCHAR2(60) CONSTRAINT SYS_MT_Furniture_Room_FK REFERENCES MT_Furniture (furniture_id) ON DELETE CASCADE,
    room_name VARCHAR2(60) NOT NULL,
    wall_colour VARCHAR2(60) NOT NULL
);

CREATE TABLE MT_Home(
    home_id VARCHAR2(60) CONSTRAINT SYS_MT_Home_PK PRIMARY KEY,
    room_id VARCHAR2(60) CONSTRAINT SYS_MT_Room_Home_FK REFERENCES MT_Room (room_id) ON DELETE CASCADE NOT NULL,
    street VARCHAR2(60) NOT NULL,
    city VARCHAR2(60) NOT NULL,
    prov CHAR(2) CONSTRAINT SYS_MT_Home_prov_CK CHECK(prov in ('AB', 'BC', 'SK')) NOT NULL,
    postal_code CHAR(6) CONSTRAINT SYS_MT_Home_postCode_CK CHECK (regexp_like(postal_code, '[A-Z][0-9][A-z][0-9][A-Z][0-9]')) NOT NULL,
    owner_first VARCHAR2(60) NOT NULL,
    owner_sur VARCHAR2(60) NOT NULL
);

SPOOL OFF