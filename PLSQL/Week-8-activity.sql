SET SERVEROUTPUT ON
DECLARE

    CURSOR c_load IS
        SELECT * 
        FROM ICCC_load; 

    v_employee_id   faculty.employee_id%TYPE; 
    v_counter       NUMBER; 
    k_min           CONSTANT expertise.expertise_level%TYPE := 5; 


BEGIN

    FOR r_load in c_load LOOP 

        BEGIN 

            UPDATE expertise 
            SET expertise_level = r_load.expertise_level
            WHERE employee_id = r_load.employee_id
            AND course_code = r_load.course_code; 

            IF (SQL%NOTFOUND) THEN  
                -- Valid Employee? Embedded Block --

                BEGIN

                    SELECT employee_id 
                    INTO v_employee_id
                    FROM faculty
                    WHERE employee_id = r_load.employee_id;

                EXCEPTION

                    WHEN no_data_found THEN
                        RAISE_APPLICATION_ERROR(-20001, 'Employee id: ' || r_load.employee_id || ' is invalid.');
                
                END;

                --valid course code? count method --

                SELECT COUNT(*)
                INTO v_counter
                FROM course
                WHERE course_code = r_load.course_code;            

                IF (v_counter = 0) THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Course code: ' || r_load.course_code || ' is invalid');

                END IF; 

            
            INSERT INTO expertise
            VALUES(r_load.employee_id, r_load.course_code, r_load.expertise_level); 

            END IF; 

            SELECT COUNT(*)
            INTO v_counter
            FROM class_section 
            WHERE course_code = r_load.course_code
            AND instructor_id = r_load.employee_id; 

            IF (v_counter > 0) THEN

                IF (r_load.expertise_level < k_min) THEN 

                    RAISE_APPLICATION_ERROR(-20003, 'Expertise level ' || r_load.expertise_level || ' is too low for instructor ' || r_load.employee_id || ' for course ' || r_load.course_code);

                END IF;
            END IF;






            COMMIT;

        EXCEPTION

            WHEN others THEN
                ROLLBACK; 
                DBMS_OUTPUT.PUT_LINE(SQLERRM); 

                /*INSERT INTO ICCC_error_log
                VALUES(r_load.employee_id, r_load.course_code, r_load.expertise_level, SQLERRM); 
                commit; */
        
        END; 

        --data processing
    END LOOP; 

END; 

--Scenario 2


SET SERVEROUTPUT ON
DECLARE

    CURSOR c_load IS
        SELECT * 
        FROM ICCC_load; 

    v_employee_id   faculty.employee_id%TYPE; 
    v_counter       NUMBER; 
    k_min           CONSTANT expertise.expertise_level%TYPE := 5; 
    v_msg           VARCHAR2(100); 


BEGIN

    FOR r_load in c_load LOOP 

        BEGIN 

            UPDATE expertise 
            SET expertise_level = r_load.expertise_level
            WHERE employee_id = r_load.employee_id
            AND course_code = r_load.course_code; 

            IF (SQL%NOTFOUND) THEN  
                -- Valid Employee? Embedded Block --

                BEGIN

                    SELECT employee_id 
                    INTO v_employee_id
                    FROM faculty
                    WHERE employee_id = r_load.employee_id;

                EXCEPTION

                    WHEN no_data_found THEN
                        RAISE_APPLICATION_ERROR(-20001, 'Employee id: ' || r_load.employee_id || ' is invalid.');
                
                END;

                --valid course code? count method --

                SELECT COUNT(*)
                INTO v_counter
                FROM course
                WHERE course_code = r_load.course_code;            

                IF (v_counter = 0) THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Course code: ' || r_load.course_code || ' is invalid');

                END IF; 

            
            INSERT INTO expertise
            VALUES(r_load.employee_id, r_load.course_code, r_load.expertise_level); 

            END IF; 

            SELECT COUNT(*)
            INTO v_counter
            FROM class_section 
            WHERE course_code = r_load.course_code
            AND instructor_id = r_load.employee_id; 

            IF (v_counter > 0) THEN

                IF (r_load.expertise_level < k_min) THEN 

                    RAISE_APPLICATION_ERROR(-20003, 'Expertise level ' || r_load.expertise_level || ' is too low for instructor ' || r_load.employee_id || ' for course ' || r_load.course_code);

                END IF;
            END IF;






            COMMIT;

        EXCEPTION

            WHEN others THEN
                ROLLBACK;

                v_msg := SQLERRM;

                INSERT INTO ICCC_error_log
                VALUES(r_load.employee_id, r_load.course_code, r_load.expertise_level, v_msg); 
                commit; 

                DBMS_OUTPUT.PUT_LINE(v_msg); 
        
        END; 

        --data processing
    END LOOP; 

END; 