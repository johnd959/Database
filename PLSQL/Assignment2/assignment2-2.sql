
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
        SELECT DISTINCT transaction_no
        FROM new_transactions;

    -- declaring inner-loop cursor
    CURSOR c_transactions is 
        SELECT *
        FROM new_transactions
        where transaction_no = v_transactionNo; 

BEGIN
    --iterating over the new transaction (load) table
    FOR r_new_transaction IN c_new_transaction LOOP

        DECLARE 

            v_default_trans_type    CHAR(1); 

        BEGIN 

            v_transactionNo := r_new_transaction.transaction_no; 
            DBMS_OUTPUT.PUT_LINE('Beginning transaction: ' || v_transactionNo); 


            --iterating over the lines of a transaction 
            FOR r_transaction IN c_transactions LOOP

                SELECT default_trans_type
                INTO v_default_trans_type
                FROM account_type, account
                WHERE account.account_no = r_transaction.account_no
                AND account_type.account_type_code = account.account_type_code;  

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

                --updating transaction history with information --
                UPDATE transaction_history
                SET transaction_date = r_transaction.transaction_date, description = r_transaction.description
                WHERE transaction_no = r_new_transaction.transaction_no;

                IF(SQL%NOTFOUND) THEN
                    INSERT INTO transaction_history
                    VALUES
                    (r_new_transaction.transaction_no, r_transaction.transaction_date, r_transaction.description); 
                END IF;

                --inserting information into transaction detail about the transaction --
                INSERT INTO transaction_detail
                VALUES (r_transaction.account_no, r_transaction.transaction_no, r_transaction.transaction_type, r_transaction.transaction_amount);

            END LOOP; 
        
            --removing the processed transaction--
            DELETE FROM new_transactions 
            WHERE transaction_no = v_transactionNo;

            COMMIT;

        --main exception handler
        EXCEPTION
            WHEN dup_val_on_index THEN  
                DBMS_OUTPUT.PUT_LINE(SQLERRM); 

        END;

    END LOOP;

END;
/