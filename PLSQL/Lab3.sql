set SERVEROUTPUT ON
DECLARE

k_typeOne_deduction CONSTANT number := (1 - 0.5); 
k_typeTwo_deduction CONSTANT number := (1 - 0.25);
k_minimum_sal CONSTANT number:= 100;
k_raise_rate CONSTANT number := (1 + 0.10);
k_commission_threshold number := (0.22); 

company_avg number;
president emp%ROWTYPE;
lowest_commission number; 
new_sal number;
v_shared_info number;
new_comm number; 


Cursor c_employees is 
SELECT * 
FROM emp
WHERE deptno = v_shared_info;

cursor c_departments is
SELECT * 
FROM dept;

BEGIN

--inserting test values --

--test 1: type one deduction, expected new SAL to be 3000 --
INSERT INTO emp 
values(1111, 'Test 1', 'Tester', 7839, null, 6000, 500, 10);

-- test 2: type two deduction, expected new SAL to be 3750 -- 
-- also testing acquisition of the lowest commission for each dept in conjunction with test 3, expected lowest for dept 20 to be 50 --
INSERT INTO emp 
values(1112, 'Test 2', 'Tester', 7839, null, 8000, 100, 20);

--test 3: raise (employee makes less than 100 and new raise is less than avg, expected 108.9) --

INSERT INTO emp
values(1113, 'Test 3', 'Tester', 7839, null, 99, 50, 20);

--test 4: commission decrease, testing whether program operates with the original salary
-- 5001 will be decreased to 2500.5 and commission should be decreased to 500

INSERT INTO emp
values(1114, 'Test 4', 'Tester', 7839, null, 5001, 1101, 10);

--test 5: commission decrease, testing whether program will decrease commission even though it is less than 22% of their salary --
-- expect sal to stay the same, comm to stay the same; error if comm is 50
INSERT INTO emp
values(1115, 'Test 5', 'Tester', 7839, null, 1000, 219, 20);

-- getting the president --
SELECT *
INTO president
FROM emp
WHERE JOB = 'PRESIDENT';

--getting employee avg before changes--
SELECT Round(avg(SAL), 2)
INTO company_avg
FROM emp; 

DBMS_OUTPUT.PUT_LINE('President''s Salary:' || president.SAL);
DBMS_OUTPUT.PUT_LINE('Average employee salary:' || company_avg); 

For r_departments in c_departments LOOP 


        SELECT MIN(COMM) 
        INTO lowest_commission
        FROM emp 
        WHERE deptno = r_departments.deptno
        AND (COMM != null
        OR COMM != 0); 

        DBMS_OUTPUT.PUT_LINE('Lowest Commission: ' || lowest_commission || ', for Department#: ' || r_departments.deptno); 

        v_shared_info := r_departments.deptno;

    For r_employees in c_employees LOOP

        new_sal := r_employees.SAL; 
        new_comm := r_employees.comm; 

        IF (r_employees.SAL > president.SAL) THEN
            

            IF (r_employees.SAL * k_typeOne_deduction < president.SAL * k_typeTwo_deduction) THEN
                new_sal := r_employees.SAL * k_typeOne_deduction; 
            ELSE 
                new_sal := president.SAL * k_typeTwo_deduction;
            END IF;
        END IF;

        IF (r_employees.SAL < 100 AND (r_employees.SAL * k_raise_rate < company_avg)) THEN
            new_sal := r_employees.SAL * k_raise_rate;
        
        END IF;
    

        IF (r_employees.COMM > (k_commission_threshold * r_employees.SAL)) THEN
            new_comm := lowest_commission; 
            
        END IF;

        UPDATE EMP
        SET SAL = new_sal, COMM = new_comm
        WHERE empno = r_employees.empno; 

    END LOOP;

END LOOP;

END;






