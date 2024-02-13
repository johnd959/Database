set SERVEROUTPUT ON 

DECLARE

Cursor c_emp is
    SELECT *
    FROM emp; 

r_emp emp%ROWTYPE; 

BEGIN

open c_emp;

LOOP

    FETCH c_emp into r_emp;
    EXIT WHEN (c_emp%NOTFOUND);

    DBMS_OUTPUT.PUT_LINE(r_emp.empno); 

END LOOP; 

END;

/

DECLARE 

Cursor c_emp is
    SELECT * 
    FROM emp; 

BEGIN

FOR r_emp in c_emp LOOP

    DBMS_OUTPUT.PUT_LINE(r_emp.empno); 

END LOOP; 

END; 

/

-- Question 2 Scenario 1/4--
DECLARE 

    k_current_department  emp.deptno%type := 20; 
    k_other_department  emp.deptno%TYPE := 30;
    
    v_lowest_sal NUMBER; 
    v_avg_sal NUMBER; 
     

    CURSOR c_emp is
        SELECT ename, sal, empno
        FROM EMP
        WHERE deptno = k_current_department; 
        FOR UPDATE; 

    v_name  emp.ename%type; 
    v_sal   emp.sal%TYPE; 
    v_empno emp.empno%TYPE;

BEGIN

    SELECT AVG(sal), MIN(sal)
    INTO v_avg_sal, v_lowest_sal
    FROM emp
    WHERE deptno = k_other_department; 

    DBMS_OUTPUT.PUT_LINE(v_avg_sal || '     ' || v_lowest_sal); 

    FOR r_emp in c_emp LOOP 
        DBMS_OUTPUT.PUT_LINE(r_emp.ename || '    ' || r_emp.sal); 
        IF r_emp.sal > v_avg_sal THEN 
            UPDATE emp 
            SET sal = v_lowest_sal
            WHERE CURRENT OF c_emp; 
        END IF; 

    END LOOP; 
    commit; 

END; 

/

-- Question 5 -- 
--Scenario 1-- 

DECLARE

    CURSOR c_dept is
        SELECT dname, ename, sal
        FROM dept
        JOIN emp using(deptno)
        ORDER BY dname; 

    v_change dept.dname%TYPE := -1; 

BEGIN 

    For r_dept in c_dept LOOP

        IF (v_change != r_dept.dname) THEN
            DBMS_OUTPUT.PUT_LINE(r_dept.dname); 
            v_change := r_dept.dname; 
        END IF; 

        DBMS_OUTPUT.PUT_LINE('>>>>>>>' || r_dept.ename || '      ' || r_dept.sal);

    END LOOP;

END;
/
 
DECLARE

    v_deptno dept.deptno%type; 

    CURSOR c_dept is
        SELECT * 
        FROM  dept; 

    cursor c_emp is
        SELECT *
        FROM emp 
        WHERE deptno = v_deptno; 

   

BEGIN

    FOR r_dept in c_dept LOOP

        DBMS_OUTPUT.PUT_LINE(r_dept.dname);
        v_deptno := r_dept.deptno; 

        FOR r_emp in c_emp LOOP

            DBMS_OUTPUT.PUT_LINE('>>>>>>>' || r_emp.ename || '       ' || r_emp.sal);

        END LOOP;

    END LOOP; 

END; 

DECLARE

    v_deptno dept.deptno%type; 

    CURSOR c_dept is
        SELECT dname, deptno
        FROM  dept; 

    cursor c_emp is
        SELECT ename, sal
        FROM emp 
        WHERE deptno = v_deptno; 

    v_dname dept.dname%TYPE;
    v_ename emp.ename%TYPE;
    v_sal emp.sal%TYPE; 
   

BEGIN

    OPEN c_dept; 
    LOOP

        FETCH c_dept into v_dname, v_deptno;
        EXIT WHEN (c_dept%NOTFOUND); 

        DBMS_OUTPUT.PUT_LINE(v_dname);

        
        OPEN c_emp;
        LOOP
            FETCH c_emp into v_ename, v_sal;
            EXIT WHEN(c_emp%NOTFOUND); 
            DBMS_OUTPUT.PUT_LINE('>>>>>>>' || v_ename || '       ' || v_sal);

        END LOOP;
        CLOSE c_emp; 

    END LOOP; 
    CLOSE c_dept; 
    
END; 