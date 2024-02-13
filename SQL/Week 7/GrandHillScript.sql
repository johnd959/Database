-- Unit 8: Activity Create the Grand Hill College Database 2/28/23 --
set echo on 

-- spool
spool "C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 7\grandHillOutput.txt";

-- drop child tables first followed by parents 
DROP TABLE GHC_EXPERTISE;
DROP TABLE GHC_FACULTY;
DROP TABLE GHC_COURSE;
DROP TABLE GHC_DEPARTMENT; 

-- create parent tables first, followed by children

CREATE TABLE GHC_DEPARTMENT(
     dept_no NUMBER,
   dept_name VARCHAR2(20)
);

-- alter department to add in constraints 
   ALTER TABLE GHC_DEPARTMENT
ADD CONSTRAINT sys_ghc_dept_no_pk PRIMARY KEY(dept_no)
ADD CONSTRAINT sys_ghc_dept_name_uk UNIQUE(dept_name);

ALTER TABLE GHC_DEPARTMENT
     MODIFY (dept_no not null); 

CREATE TABLE GHC_COURSE(
 course_code char(7) CONSTRAINT sys_ghc_course_pk PRIMARY KEY,
course_title varchar2(60) not null,
     credits number(2) not null,
             CONSTRAINT sys_ghc_course_credits_ck CHECK (credits between 1 and 9)
);

CREATE TABLE GHC_FACULTY(
  faculty_id NUMBER CONSTRAINT sys_ghc_faculty_pk PRIMARY KEY,
     surname varchar2(60) not null,
   firstname varchar2(50) not null, 
  date_hired DATE not null,
  date_fired DATE, 
   is_active NUMBER(1) not null, 
     dept_no NUMBER not null,
             CONSTRAINT sys_ghc_faculty_active_ck CHECK (is_active in (0, 1))
);

ALTER TABLE GHC_FACULTY
ADD CONSTRAINT sys_ghc_dept_fac_fk FOREIGN KEY (dept_no) REFERENCES GHC_DEPARTMENT (dept_no);

CREATE TABLE GHC_EXPERTISE(
  faculty_id NUMBER,
 course_code CHAR(7),
  CONSTRAINT sys_expertise_pk PRIMARY KEY (faculty_id, course_code),
  CONSTRAINT sys_ghc_fac_expertise_fk FOREIGN KEY (faculty_id) REFERENCES GHC_FACULTY(faculty_id),
  CONSTRAINT sys_ghc_course_expertise_fk FOREIGN KEY (course_code) REFERENCES GHC_COURSE(course_code)
);

spool off; 