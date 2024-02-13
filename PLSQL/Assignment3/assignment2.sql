SET SERVEROUTPUT ON

DECLARE 

    v_transactionNo     NUMBER; 
    v_transactionAmount     NUMBER;

Cursor c_newTransactions AS
    SELECT DISTINCT transaction_no, 
    FROM NEW_TRANSACTIONS;

Cursor c_Transactions AS
    SELECT * 
    FROM NEW_TRANSACTIONS 
    WHERE transaction_no = v_transactionNo; 



BEGIN

FOR r_newTransactions IN c_newTransactions LOOP

    v_transactionNo := r_newTransactions.transaction_no;
    DBMS_OUTPUT.PUT_LINE('Beginning transaction ' || v_transactionNo); 
    
    DECLARE

        v_accountNo     NUMBER;
        v_transactionType   NUMBER; 
        v_transactionDate   Date; 
        v_description       VARCHAR2(100); 
        v_defaultTransaction    CHAR(1); 
 

    BEGIN



        FOR r_Transactions IN c_Transactions LOOP

            v_accountNo := r_Transactions.account_no; 
            v_transactionType := r_Transactions.transaction_type; 
            v_transactionDate := r_Transactions.transaction_date; 
            v_description := r_Transactions.description; 

            CASE v_transactionType
                WHEN 'D'




        END LOOP; 

        INSERT INTO transaction_detail
        values
        (v_accountNo, v_transactionNo, v_transactionType, v_transactionAmount); 

        INSERT INTO transaction_history
        values
        (v_transactionNo, v_transactionDate, v_description); 

    EXCEPTION

    END; 

    





END LOOP; 



EXCEPTION

END; 