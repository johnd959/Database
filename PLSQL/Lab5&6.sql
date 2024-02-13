CREATE OR REPLACE FUNCTION performanceHours (startTime IN ATA_PERFORMANCE.start_time%TYPE, endTime IN ATA_PERFORMANCE.stop_time%TYPE)
RETURN NUMBER
IS

v_startDay NUMBER;
v_startHour NUMBER;

v_endDay NUMBER;
v_endHour NUMBER;

v_totalHours NUMBER;

negativeHours EXCEPTION;


BEGIN


    v_startDay := to_number(to_char(startTime, 'DD'));
    v_startHour := to_number(to_char(startTime, 'HH24'));

    v_endDay := to_number(to_char(endTime, 'DD'));
    v_endHour := to_number(to_char(endTime, 'HH24'));

    v_totalHours := ((v_endDay * 24) + v_endHour) - ((v_startDay * 24) + v_startHour);

    DBMS_OUTPUT.PUT_LINE('Total hours: ' || to_char(v_totalHours));

    IF(v_totalHours < 0) THEN
        raise negativeHours;
    END IF;

    RETURN v_totalHours;

EXCEPTION
    WHEN negativeHours THEN
        RAISE_APPLICATION_ERROR(-20004, 'Inside performance hours, total hours is negative: ' || v_totalHours);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Inside performance hours: '|| sqlerrm);

END;
/
   


CREATE OR REPLACE FUNCTION hourlyRate(event_type IN ata_contract.event_type%TYPE)
RETURN NUMBER
IS

v_event_type VARCHAR2(30);
v_hourlyFee  NUMBER;

BEGIN

    v_event_type := LOWER(event_type);

    CASE
        WHEN v_event_type like('%childrens party%') THEN
            v_hourlyFee := 335;
        WHEN v_event_type like('%concert%') THEN
            v_hourlyFee := 1000;
        WHEN v_event_type like('%divorce party%') THEN
            v_hourlyFee := 170;
        WHEN v_event_type like('%wedding%') THEN
            v_hourlyFee := 300;
        ELSE    
            v_hourlyFee := 100;
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Hourly rate: ' || v_hourlyFee);

    RETURN v_hourlyFee;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Hourly rate: '|| sqlerrm);

END;
/

CREATE OR REPLACE FUNCTION adminFee (startTime IN ATA_PERFORMANCE.start_time%TYPE)
RETURN NUMBER
IS

v_weekDay VARCHAR2(30);
v_adminFee  NUMBER;

BEGIN

    v_weekDay := lower(to_char(startTime, 'DAY'));

    IF (v_weekDay like '%monday%' or v_weekDay like '%friday%') THEN
        v_adminFee := 100;
    ELSE
        v_adminFee := 0;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Admin fee: ' || v_adminFee);

    RETURN v_adminFee;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Admin fee: '|| sqlerrm);

END;
/
           

CREATE OR REPLACE FUNCTION totalFee(startTime IN ATA_PERFORMANCE.start_time%TYPE, endTime IN ATA_PERFORMANCE.stop_time%TYPE, eventType IN ata_contract.event_type%TYPE)
RETURN NUMBER
IS

v_totalFee      ata_contract.fee%TYPE;
v_hourlyRate    NUMBER;
v_adminFee      NUMBER;
v_totalHours    NUMBER;

BEGIN

    v_totalHours := performanceHours(startTime, endTime);
    v_hourlyRate := hourlyRate(eventType);
    v_adminFee := adminFee(startTime);

    v_totalFee := (v_totalHours * v_hourlyRate) + v_adminFee;

    DBMS_OUTPUT.PUT_LINE('Total fee calculated at totalFee: ' || v_totalFee);

    RETURN v_totalFee;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Total fee: '|| sqlerrm);

END;
/




CREATE OR REPLACE PROCEDURE calculateFee(v_totalFee OUT ata_contract.fee%TYPE,
                                        startTime IN ATA_PERFORMANCE.start_time%TYPE,
                                        endTime IN ATA_PERFORMANCE.stop_time%TYPE,
                                        eventType IN ata_contract.event_type%TYPE,
                                        contractNumber ata_contract.contract_number%TYPE)
IS


BEGIN

    v_totalFee := totalFee(startTime, endTime, eventType);

    DBMS_OUTPUT.PUT_LINE('Total fee calculated at calculate fee: ' || v_totalFee || ' for contract: ' || contractNumber);


END;
/

SET SERVEROUTPUT ON
DECLARE

    v_contractNum      ata_contract.contract_number%TYPE;
    v_totalFee         ata_contract.fee%TYPE;
    v_accumulator      ata_contract.fee%TYPE;

    CURSOR c_contract IS
        SELECT *
        FROM ata_contract;

    CURSOR c_performance IS
        SELECT *
        FROM ATA_PERFORMANCE
        WHERE contract_number = v_contractNum;

BEGIN

    FOR r_contract IN c_contract LOOP

        BEGIN

            v_accumulator := 0;
            v_contractNum := r_contract.contract_number;

            FOR r_performance IN c_performance LOOP

                calculateFee(v_totalFee, r_performance.start_time, r_performance.stop_time, r_contract.event_type, r_contract.contract_number);
                v_accumulator := v_accumulator + v_totalFee;

            END LOOP;

            DBMS_OUTPUT.PUT_LINE('accumulator: ' || v_accumulator || ', contract number: ' || r_contract.contract_number);
        
            UPDATE ata_contract
            set fee = v_accumulator
            WHERE contract_number = r_contract.contract_number;

            COMMIT;
        EXCEPTION

            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(sqlerrm);


        END; 

    END LOOP;

END;
/