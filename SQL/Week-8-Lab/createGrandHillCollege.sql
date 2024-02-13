rem script to create the Grand Hill college database
rem Dave Leskiw
rem Sept 2022
rem
set echo on
rem
rem drop child tables first and then the parent tables
rem
drop table ghc_expertise cascade constraints;
drop table ghc_course cascade constraints;
drop table ghc_faculty cascade constraints;
drop table ghc_department cascade constraints;
rem
rem Create parent tables first and then their children after
rem
rem Create the department table without any constraints, add the
rem constraints after.
rem
CREATE TABLE GHC_DEPARTMENT (
    dept_no NUMBER,
    dept_name VARCHAR2(20)
);
rem
rem Add the constraints
rem 
ALTER TABLE GHC_DEPARTMENT 
    ADD CONSTRAINT sys_ghc_dept_pk PRIMARY KEY (dept_no);
ALTER TABLE GHC_DEPARTMENT 
    MODIFY (dept_name NOT NULL);
rem
rem create ghc_course table with constraints
rem
CREATE TABLE GHC_COURSE (
   course_code CHAR(7) CONSTRAINT SYS_GHC_COURSE_PK PRIMARY KEY,
   course_title VARCHAR2(60) CONSTRAINT SYS_GHC_COURSE_TITLE_NN NOT NULL,
   credits NUMBER(2) 
        CONSTRAINT SYS_GHC_COURSE_CREDITS_NN NOT NULL
        CONSTRAINT SYS_GHC_COURSE_CREDITS_CK CHECK (credits between 1 and 9)
);
rem
rem create ghc_faculty table with constraints
rem notice that the foreign key is done at the column level
rem so you don't need the keyword foreign key
rem
CREATE TABLE GHC_FACULTY (
   faculty_id NUMBER CONSTRAINT SYS_GHC_FAC_PK PRIMARY KEY,
   surname VARCHAR2(50) CONSTRAINT SYS_GHC_FAC_SURNAME_NN NOT NULL,
   firstname VARCHAR2(50) CONSTRAINT SYS_GHC_FAC_FIRSTNAME_NN NOT NULL,
   date_hired DATE CONSTRAINT SYS_GHC_FAC_DATE_HIRED_NN NOT NULL,
   date_fired DATE,
   is_active NUMBER(1) CONSTRAINT SYS_GHC_IS_ACTIVE_NN NOT NULL
       CONSTRAINT SYS_GHC_IS_ACTIVE_CK CHECK (is_active in (0,1)),
   dept_no NUMBER CONSTRAINT SYS_GHC_FAC_GHC_DEPT_FK 
      REFERENCES ghc_department(dept_no)
);
rem
rem create ghc_expertise table with constraints
rem the primary key constraint has to be done at the table level
rem
CREATE TABLE GHC_EXPERTISE (
    faculty_id NUMBER,
    course_code CHAR(7),
    CONSTRAINT sys_ghc_expert_pk PRIMARY KEY (faculty_id, course_code),
    CONSTRAINT sys_ghc_expert_faculty_fk FOREIGN KEY (faculty_id)
        REFERENCES GHC_FACULTY (faculty_id),
    CONSTRAINT sys_ghc_expert_course_fk FOREIGN KEY (course_code) 
        REFERENCES GHC_COURSE (course_code)
);

