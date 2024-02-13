SET SERVEROUTPUT ON;

DECLARE

    CURSOR c_new_transaction is 
        SELECT * FROM new_transactions;

    CURSOR c_account is 
        SELECT account_no, default_trans_type 
        FROM account, account_type 
        where account.account_type_code = account_type.account_type_code;

BEGIN
    FOR r_new_transaction IN c_new_transaction LOOP

        FOR r_account IN c_account LOOP

            IF (r_new_transaction.account_no = r_account.account_no) THEN

                IF (r_new_transaction.transaction_type = r_account.default_trans_type) THEN

                    UPDATE account
                    SET account_balance = account_balance + r_new_transaction.transaction_amount
                    WHERE account_no = r_new_transaction.account_no;

                ELSE
                    
                    UPDATE account
                    SET account_balance = account_balance - r_new_transaction.transaction_amount
                    WHERE account_no = r_new_transaction.account_no;
    
                END IF;

            END IF;

            COMMIT;

        END LOOP;

        UPDATE transaction_history SET transaction_no = r_new_transaction.transaction_no WHERE transaction_no = r_new_transaction.transaction_no;

        IF (SQL%NOTFOUND) THEN
            INSERT INTO transaction_history
            VALUES (r_new_transaction.transaction_no, r_new_transaction.transaction_date, r_new_transaction.description);
        END IF;


        INSERT INTO transaction_detail
        VALUES (r_new_transaction.account_no, r_new_transaction.transaction_no, r_new_transaction.transaction_type, r_new_transaction.transaction_amount);
        
        DELETE FROM new_transactions WHERE transaction_no = r_new_transaction.transaction_no;

        COMMIT;
    END LOOP;
END;
/