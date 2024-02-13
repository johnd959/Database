set SERVEROUTPUT ON

DECLARE

k_president emp%ROWTYPE;
k_deduction_rate CONSTANT NUMBER := (1 - 0.25);
k_raise_rate CONSTANT NUMBER := (1 + 0.10);
k_minimum_sal CONSTANT NUMBER := 100;

company_avg NUMBER; 

BEGIN

-- inserting test rows--
INSERT INTO EMP
VALUES(1112, 'test1', 'tester', 7839, '', 9000, null, 10);
INSERT INTO EMP
VALUES(1113, 'test2', 'tester', 7839, '', 99, null, 10);

-- getting the president --
SELECT *
INTO k_president
FROM emp
WHERE JOB = 'PRESIDENT';

-- setting deductions for those with a salary greater than that of the president --
UPDATE EMP 
SET SAL = (k_president.SAL * k_deduction_rate)
WHERE SAL > k_president.SAL; 

-- calculating company average --
SELECT ROUND(AVG(SAL), 2)
INTO company_avg
FROM EMP;

-- setting increases --
UPDATE EMP 
SET SAL = ROUND(SAL * k_raise_rate, 2)
WHERE SAL < 100 AND (ROUND((SAL * k_raise_rate),2) < company_avg); 

--printing president's salary and average employee salary
DBMS_OUTPUT.PUT_LINE('Presidents Salary: ' || k_president.SAL);
DBMS_OUTPUT.PUT_LINE('Average Employee Salary: ' || company_avg);

END;
/ 
