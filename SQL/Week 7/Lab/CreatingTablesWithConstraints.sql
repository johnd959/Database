SET ECHO ON

SPOOL 'C:\Users\ASUS\OneDrive\Documents\SAIT\Courses\CPRG-250-SA1\Week 7\Lab\CTWC.txt'

DROP TABLE RCV_Tour_Destination CASCADE CONSTRAINTS; 
DROP TABLE RCV_Tour_Customer CASCADE CONSTRAINTS;
DROP TABLE RCV_Agent_Training CASCADE CONSTRAINTS;
DROP TABLE RCV_Vacation_Tour CASCADE CONSTRAINTS;
DROP TABLE RCV_Customer CASCADE CONSTRAINTS;
DROP TABLE RCV_Destination;
DROP TABLE RCV_Ratings;
DROP TABLE RCV_Agent;
DROP TABLE RCV_Training;

CREATE TABLE RCV_Destination(
    destination_code VARCHAR2(60) CONSTRAINT SYS_RCV_DESTINATION_PK PRIMARY KEY,
    city VARCHAR2(50) NOT NULL,
    destination_state CHAR(2) CONSTRAINT SYS_RCV_DESTINATION_desState_CK CHECK (destination_state in ('BC', 'AB', 'SK', 'MB', 'OM', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE', 'YT')) NOT NULL,
    country VARCHAR2(250) NOT NULL,
    destination_desciption VARCHAR2(100) NOT NULL
);

CREATE TABLE RCV_Ratings(
    rating_code VARCHAR2(60) CONSTRAINT SYS_RCV_Ratings_PK PRIMARY KEY,
    rating_description VARCHAR2(50) NOT NULL
);

CREATE TABLE RCV_Vacation_Tour(
    tour_code VARCHAR2(60) CONSTRAINT SYS_RCV_Vacation_Tour_PK PRIMARY KEY,
    tour_description VARCHAR2(30) NOT NULL,
    tour_region CHAR(2) NOT NULL CONSTRAINT SYS_RCV_Vacation_Tour_tourReg_CK CHECK (tour_region in ('CA', 'US', 'EU')),
    rating_code VARCHAR2(60) NOT NULL CONSTRAINT SYS_RCV_Ratings_Vacation_Tour_FK REFERENCES RCV_Ratings(rating_code) 
);

CREATE TABLE RCV_Agent(
    agent_id VARCHAR2(60) CONSTRAINT SYS_RCV_Agent_PK PRIMARY KEY,
    first_name VARCHAR2(60) NOT NULL,
    last_name VARCHAR2(60) NOT NULL,
    years_of_experience NUMBER(2) NOT NULL CONSTRAINT SYS_RCV_Agent_yrsExp_CK CHECK (years_of_experience between 0 and 99),
    agent_level CHAR(2) NOT NULL CONSTRAINT SYS_RCV_Agent_agentLvl_CK CHECK (agent_level IN ('I','II','III','IV','V')),
    agent_specialty CHAR(2) NOT NULL CONSTRAINT SYS_RCV_Agent_agentSpec_CK CHECK (agent_specialty IN ('CA','US','EU'))
);
CREATE TABLE RCV_Training(
    training_code CHAR(1) CONSTRAINT SYS_RCV_Training_PK PRIMARY KEY,
    training_description VARCHAR2(50) NOT NULL,
    duration_hours NUMBER(3) NOT NULL 
);
CREATE TABLE RCV_Agent_Training(
    agent_id VARCHAR2(60),
    training_code CHAR(1) ,
    CONSTRAINT SYS_RCV_Agent_Training_PK PRIMARY KEY (agent_id,training_code),
    CONSTRAINT SYS_RCV_Agent_Agent_Training_FK FOREIGN KEY (agent_id) REFERENCES RCV_Agent (agent_id),
    CONSTRAINT SYS_RCV_Training_Agent_Training_FK FOREIGN KEY (training_code) REFERENCES RCV_Training (training_code)
);

CREATE TABLE RCV_Tour_Destination(
    destination_code VARCHAR2(60),
    tour_code VARCHAR2(60),
    order_number NUMBER(2),
    CONSTRAINT SYS_RCV_Tour_Destination_PK PRIMARY KEY(destination_code, tour_code),
    CONSTRAINT SYS_RCV_Destination_TourDest_FK FOREIGN KEY (destination_code) REFERENCES  RCV_Destination (destination_code),
    CONSTRAINT SYS_RCV_VacTour_TourDest_FK FOREIGN KEY (tour_code) REFERENCES RCV_Vacation_Tour (tour_code)
);

ALTER TABLE RCV_Tour_Destination
MODIFY (order_number NOT NULL); 

CREATE TABLE RCV_Customer(
    customer_number VARCHAR2(60) CONSTRAINT SYS_RCV_Customer_PK PRIMARY KEY,
    first_name VARCHAR2(60) NOT NULL,
    last_name VARCHAR2(60) NOT NULL,
    customer_phone VARCHAR2(12) NOT NULL,
    customer_st_address VARCHAR2(60) NOT NULL,
    customer_city VARCHAR2(50) NOT NULL,
    customer_province CHAR(2) NOT NULL,
    agent_id VARCHAR2(60) NOT NULL 
);

ALTER TABLE RCV_Customer
ADD CONSTRAINT SYS_RCV_Customer_cusPhone_UK UNIQUE(customer_phone)
ADD CONSTRAINT SYS_RCV_Customer_cosPhone_CK CHECK (regexp_like(customer_phone, '[1-9][0-9]{2}.[0-9]{3}.[0-9]{4}'))
ADD CONSTRAINT SYS_RCV_Customer_CusProv_CK CHECK (customer_province in ('BC', 'AB', 'SK', 'MB', 'OM', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE', 'YT'))
ADD CONSTRAINT SYS_RCV_Agent_Customer_FK FOREIGN KEY (agent_id) REFERENCES RCV_Agent (agent_id);

CREATE TABLE RCV_Tour_Customer(
    tour_code VARCHAR2(60),
    customer_number VARCHAR2(60),
    startDate DATE NOT NULL,
    end_Date DATE NOT NULL,
    CONSTRAINT SYS_RCV_Tour_Customer_PK PRIMARY KEY(tour_code, customer_number),
    CONSTRAINT SYS_RCV_VacTour_TourCus_FK FOREIGN KEY (tour_code) REFERENCES RCV_Vacation_Tour (tour_code),
    CONSTRAINT SYS_RCV_Customer_TourCus_FK FOREIGN KEY (customer_number) REFERENCES RCV_Customer (customer_number)
);

SPOOL OFF


