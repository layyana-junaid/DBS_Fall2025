DECLARE
    v_stock   NUMBER;
    v_order   NUMBER := 5001;
    v_cust    NUMBER := 101;
    v_med     NUMBER := 1;
    v_qty     NUMBER := 3;
BEGIN
    SAVEPOINT start_tran;

    INSERT INTO orders(order_id, cust_id)
    VALUES (v_order, v_cust);

    SELECT stock INTO v_stock
    FROM medicines
    WHERE med_id = v_med
    FOR UPDATE;

    IF v_stock < v_qty THEN
        INSERT INTO order_log(log_id, order_id, message)
        VALUES (9001, v_order, 'Insufficient stock');
        ROLLBACK TO start_tran;
    ELSE
        INSERT INTO order_items(item_id, order_id, med_id, qty)
        VALUES (8001, v_order, v_med, v_qty);

        UPDATE medicines
        SET stock = stock - v_qty
        WHERE med_id = v_med;

        INSERT INTO order_log(log_id, order_id, message)
        VALUES (9002, v_order, 'Order successful');
        COMMIT;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        INSERT INTO order_log(log_id, order_id, message)
        VALUES (9003, v_order, 'Transaction failed');
        COMMIT;
END;
/
