set echo on


spool 'C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 8\Lab\manipulatingDataLab.txt'

delete ghc_expertise;
delete ghc_faculty;
delete ghc_course;
delete ghc_department;

insert into ghc_department (dept_no, dept_name) values (25, 'ICT');
insert into ghc_department (dept_no, dept_name) values (26, 'Business');


insert into ghc_course (course_code, course_title, credits)
values ('CMPS253',	'Interface Design	                    ',3);

insert into ghc_course (course_code, course_title, credits)
values ('CPRG250',	'Database Design and Programming	    ',5);

insert into ghc_course (course_code, course_title, credits)
values ('CPRG251',	'Object Oriented Programming Essentials	',5);

insert into ghc_course (course_code, course_title, credits)
values ('CPRG302',	'Web Essentials	                        ',3);

insert into ghc_course (course_code, course_title, credits)
values ('HREL250',	'Business Dynamics	                    ',3);



insert into ghc_faculty (faculty_id, surname, firstname, date_hired, date_fired, is_active, dept_no)
values (1294,	'Harris	   ', '  Len	  ',  '15-Dec-19',	NULL,	        1,	25);

insert into ghc_faculty (faculty_id, surname, firstname, date_hired, date_fired, is_active, dept_no)
values (1244,	'Lock	     ', 'Sara	   ', '15-Dec-19',	'1-May-20',	0,	25);

insert into ghc_faculty (faculty_id, surname, firstname, date_hired, date_fired, is_active, dept_no)
values (1948,	'Fischer	  ', '   Jenny',	    '15-Mar-21',	NULL,	        1,	26);

insert into ghc_faculty (faculty_id, surname, firstname, date_hired, date_fired, is_active, dept_no)
values (7839,	'Wallbanger', '	 Harvey',	    '15-Aug-02',		NULL,        1,	25); 




insert into ghc_expertise (faculty_id, course_code)
values (1294,	'CMPS253');

insert into ghc_expertise (faculty_id, course_code)
values (1294,	'CPRG302');

insert into ghc_expertise (faculty_id, course_code)
values (1294,	'CPRG251');

insert into ghc_expertise (faculty_id, course_code)
values (1948,	'HREL250');

insert into ghc_expertise (faculty_id, course_code)
values (7839,	'CPRG251');

insert into ghc_expertise (faculty_id, course_code)
values (7839,	'CPRG250');

insert into ghc_expertise (faculty_id, course_code)
values (7839,	'CMPS253');

insert into ghc_expertise (faculty_id, course_code)
values (1244,	'HREL250');

insert into ghc_expertise (faculty_id, course_code)
values (1244,	'CMPS253');

--lab data

insert into ghc_department (dept_no, dept_name) values (100, 'Astrophysics');

insert into ghc_faculty (faculty_id, surname, firstname, date_hired, date_fired, is_active, dept_no)
values (1001, 'Danny', 'Faulkner', '1-Jan-2022', NULL, 1, 100);

insert into ghc_course (course_code, course_title, credits) values ('APHY202', 'The Solar System', 5);
insert into ghc_course (course_code, course_title, credits) values ('APHY203', 'Nebula', 5);
insert into ghc_course (course_code, course_title, credits) values ('APHY204', 'Global Clusters', 5);

insert into ghc_expertise (faculty_id, course_code) values (1001, 'APHY202');
insert into ghc_expertise (faculty_id, course_code) values (1001, 'APHY203');
insert into ghc_expertise (faculty_id, course_code) values (1001, 'APHY204');

INSERT INTO ghc_course (course_code, course_title, credits) values ('APHY302', 'Nebula', 5);

UPDATE ghc_expertise
SET course_code = 'APHY302'
WHERE course_code = 'APHY203';

DELETE ghc_course 
WHERE course_code = 'APHY203';

DELETE ghc_expertise
WHERE faculty_id = 1001; 

DELETE ghc_faculty
WHERE faculty_id = 1001; 



commit;

select * from ghc_course;
select * from ghc_department;
select * from ghc_expertise;
select * from ghc_faculty; 

spool off