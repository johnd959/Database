SET SERVEROUTPUT ON

DECLARE

    k_deductionOne  CONSTANT NUMBER := 1 - 0.5; 
    k_deductionTwo  CONSTANT NUMBER := 1 - 0.25; 
    k_threshold     CONSTANT NUMBER := 100; 
    k_commThreshold CONSTANT NUMBER := 0.22; 
    k_increaseOne   CONSTANT NUMBER := 1 + 0.10; 


    v_president     emp%ROWTYPE;
    v_companyAvg    emp.sal%TYPE; 
    v_deptno        dept.deptno%TYPE; 
    v_deptLowest    emp.comm%TYPE; 


    CURSOR c_emp IS 
        SELECT * 
        FROM emp
        WHERE deptno = v_deptNo
        FOR update;

    CURSOR c_dept IS
        SELECT * 
        FROM dept;

BEGIN

--inserting test values --

--test 6:  trying to make changes to an employee whose department has no manager
-- expect to raise an application error (inserted test at beginning to test if loop will continue)
INSERT INTO emp
values(1116, 'Test 6', 'Tester', 7839, null, 5001, 500, 40);
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
values(1114, 'Test 4', 'Tester', 7839, null, 5001, 1150, 10);

--test 5: commission decrease, testing whether program will decrease commission even though it is less than 22% of their salary --
-- expect sal to stay the same, comm to stay the same; error if comm is 50
INSERT INTO emp
values(1115, 'Test 5', 'Tester', 7839, null, 1000, 219, 20);



    -- getting the company AVG --
    SELECT AVG(sal)
    INTO v_companyAvg
    FROM emp; 

    --getting the president --
    SELECT * 
    INTO v_president 
    FROM emp
    WHERE job = 'PRESIDENT'; 

    DBMS_OUTPUT.PUT_LINE('Average salary for the company: ' || v_companyAvg);
    DBMS_OUTPUT.PUT_LINE('President''s salary: ' || v_president.sal);



    FOR r_dept in c_dept LOOP

        --passing shared deptno to get the employees for that dept
        v_deptno := r_dept.deptno; 

        --getting the lowest comm for the dept
        SELECT min(comm)
        INTO v_deptLowest
        FROM emp 
        WHERE deptno = v_deptNo
        AND comm IS NOT NULL 
        AND comm != 0; 

        DBMS_OUTPUT.PUT_LINE('Lowest commission for the ' || r_dept.dname || ' department: ' || v_deptLowest);

        DECLARE

            v_msg   VARCHAR2(100); 
            v_newSal     NUMBER;
            v_newComm    NUMBER;
            v_deptMan    NUMBER; 

        BEGIN

        
            FOR r_emp in c_emp LOOP


                v_newSal := r_emp.sal;
                v_newComm := r_emp.comm; 

                --reducing an employee's salary Rule 1

                IF (r_emp.sal > v_president.sal) THEN

                    IF (r_emp.sal * k_deductionOne < v_president.sal * k_deductionTwo) THEN

                        v_newSal := r_emp.sal * k_deductionOne;

                    ELSE 

                        v_newSal := v_president.sal * k_deductionTwo; 

                    END IF;

                END IF; 

                -- salary increase Rule 2

                IF (r_emp.sal < k_threshold) THEN 

                    IF (v_companyAvg > r_emp.sal * k_increaseOne) THEN 

                        v_newSal := r_emp.sal * k_increaseOne; 
                        
                    END IF;

                END IF; 


                -- commission decrease Rule 3

                IF (r_emp.comm != NULL OR r_emp.comm != 0) THEN

                    IF (r_emp.comm > r_emp.sal * k_commThreshold) THEN
        
                        v_newComm := v_deptLowest; 

                    END IF; 

                END IF;  

                -- checking if there is a manager for this department

            UPDATE emp
            SET sal = v_newSal, comm = v_newComm
            WHERE CURRENT OF c_emp;

            SELECT count(*)
            INTO v_deptMan
            FROM emp
            WHERE job = 'MANAGER'
            AND deptno = v_deptno; 

            IF (v_deptMan < 1) THEN

                RAISE_APPLICATION_ERROR(-20001, 'There is no manager for department: ' || r_dept.deptno ||  '. Unable to complete the changes for employee: ' || r_emp.empno);

            END IF; 

        END LOOP; 

        COMMIT; 

        EXCEPTION

            WHEN OTHERS THEN
                ROLLBACK; 
                v_msg := SQLERRM; 
                DBMS_OUTPUT.PUT_LINE(SQLERRM); 

        END;

    END LOOP;

END;  


