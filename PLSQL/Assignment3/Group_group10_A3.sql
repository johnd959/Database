
/* ******************************************  
** Program Name:	Anonymous Block        **  
** Author: Ahmad H. Syed B. Qiaomu L. Luan D.**  
** Created:	November 21, 2023              **  
** Description:	Will load new transactions ** 
** from the new_transactions table and log **
** them in the transaction_details and     **
** transaction_history_table, while        **
** simultaneously updating the balances    **
** of the accounts referenced              */


SET SERVEROUTPUT ON;

DECLARE

    v_transactionNo     NUMBER; 

    -- declaring outer-loop cursor to iterate over load table --
    CURSOR c_new_transaction is 
        SELECT DISTINCT transaction_no, transaction_date, description
        FROM new_transactions;

    -- declaring inner-loop cursor
    CURSOR c_transactions is 
        SELECT *
        FROM new_transactions
        where transaction_no = v_transactionNo;


    EX_NULL_TRANSACTION_NUMBER      EXCEPTION;
    PRAGMA EXCEPTION_INIT(EX_NULL_TRANSACTION_NUMBER, -20001);



BEGIN

    --iterating over the new transaction (load) table
    FOR r_new_transaction IN c_new_transaction LOOP

        DECLARE 

            v_account_valid         NUMBER := -1; 
            v_default_trans_type    CHAR(1); 
            v_debits                new_transactions.transaction_amount%TYPE := 0;
            v_credits               new_transactions.transaction_amount%TYPE := 0;
            v_errm                  VARCHAR2(200); 


        BEGIN 

            v_transactionNo := r_new_transaction.transaction_no; 
            DBMS_OUTPUT.PUT_LINE('Beginning transaction: ' || v_transactionNo); 

            --checking if there is a transaction_number-- 

            IF (r_new_transaction.transaction_no IS NULL) THEN
                RAISE_APPLICATION_ERROR(-20001, 'There is no transaction number for this transaction');
            END IF; 

            --updating transaction history with information --
            INSERT INTO transaction_history
            VALUES
            (r_new_transaction.transaction_no, r_new_transaction.transaction_date, r_new_transaction.description); 


            --iterating over the lines of a transaction 
            FOR r_transaction IN c_transactions LOOP

                -- checking if there is an account number for the current transaction--

                SELECT count(*)
                INTO v_account_valid
                FROM account
                WHERE account_no = r_transaction.account_no;

                IF (v_account_valid <= 0) THEN
                    RAISE_APPLICATION_ERROR(-20003, 'The account number referenced in this transaction (' || r_transaction.account_no || ') does not exist in the accounts table'); 
                END IF; 



                --getting the default transaction type--
                SELECT default_trans_type
                INTO v_default_trans_type
                FROM account_type, account
                WHERE account.account_no = r_transaction.account_no
                AND account_type.account_type_code = account.account_type_code;  

                -- Getting debits or credits and determining whether transaction type is valid--
                CASE r_transaction.transaction_type
                    WHEN 'D' THEN
                        v_debits := v_debits + r_transaction.transaction_amount;
                    WHEN 'C' THEN
                        v_credits := v_credits + r_transaction.transaction_amount;
                    ELSE
                        RAISE_APPLICATION_ERROR(-20005, 'The transaction type: ' || r_transaction.transaction_type || ', is invalid');
                END CASE; 

                -- checking if transaction_amount is negative--
                IF (r_transaction.transaction_amount < 0) THEN
                    RAISE_APPLICATION_ERROR(-20004, 'The amount: ' || r_transaction.transaction_amount ||  ', specified in this transaction is negative');
                END IF; 



                -- determining the operating based on the default transaction type for that account--
                DBMS_OUTPUT.PUT_LINE('Updating account, type: ' || r_transaction.account_no ||',' || r_transaction.transaction_type || ' with def_type of ' || v_default_trans_type);
                IF (r_transaction.transaction_type = v_default_trans_type) THEN

                    UPDATE account
                    SET account_balance = account_balance + r_transaction.transaction_amount
                    WHERE account_no = r_transaction.account_no;
                    DBMS_OUTPUT.PUT_LINE('Setting account balance');

                ELSE
                    
                    UPDATE account
                    SET account_balance = account_balance - r_transaction.transaction_amount
                    WHERE account_no = r_transaction.account_no;
                    DBMS_OUTPUT.PUT_LINE('Setting account balance');
    
                END IF;



                --inserting information into transaction detail about the transaction --
                INSERT INTO transaction_detail
                VALUES (r_transaction.account_no, r_transaction.transaction_no, r_transaction.transaction_type, r_transaction.transaction_amount);

            END LOOP; 

            -- checking if credits equal debits--
            IF (v_debits != v_credits) THEN
                RAISE_APPLICATION_ERROR(-20002, 'The debits: ' || v_debits || ' and credits: ' || v_credits || ' in this transaction block are unequal'); 
            END IF; 

            --removing the processed transaction--
            DELETE FROM new_transactions 
            WHERE transaction_no = v_transactionNo;

            COMMIT;

        --main exception handler
        EXCEPTION

            WHEN dup_val_on_index THEN  
                ROLLBACK;
                v_errm := SUBSTR(SQLERRM, 0, 200); 
                INSERT INTO WKIS_ERROR_LOG 
                (transaction_date, description, error_msg)
                VALUES(r_new_transaction.transaction_date, r_new_transaction.description, v_errm); 
                COMMIT;
                DBMS_OUTPUT.PUT_LINE(SQLERRM); 

            WHEN EX_NULL_TRANSACTION_NUMBER THEN
                ROLLBACK;
                v_errm := SUBSTR(SQLERRM, 0, 200); 
                INSERT INTO WKIS_ERROR_LOG 
                (transaction_date, description, error_msg)
                VALUES(r_new_transaction.transaction_date, r_new_transaction.description, v_errm); 
                COMMIT;
                DBMS_OUTPUT.PUT_LINE(SQLERRM);

            WHEN OTHERS THEN
                ROLLBACK;
                v_errm := SUBSTR(SQLERRM, 0, 200); 
                INSERT INTO WKIS_ERROR_LOG 
                VALUES(r_new_transaction.transaction_no, r_new_transaction.transaction_date, r_new_transaction.description, v_errm);
                COMMIT; 
                DBMS_OUTPUT.PUT_LINE(SQLERRM);

        END;

    END LOOP;

END;
/