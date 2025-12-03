--employees who have salary higher than the avg salary in the same year
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       m.first_name || ' ' || m.last_name AS manager_name,
       e.salary AS employee_salary,
       m.salary AS manager_salary
FROM   employees e
JOIN   employees m
       ON e.manager_id = m.employee_id
WHERE  e.salary > m.salary;

select first_name ||''|| last_name as employee_name, salary from employees
where salary > (select avg(salary) from employees);

select first_name, salary from employees
where salary > (select AVG(salary) from employees);

--min salary problem
select e.first_name from employees e
where not exists (select 1 from job_history j where j.employee_id = e.employee_id)
or salary < (select min(salary) from employees);

--comission
select e.first_name, e.job_id, e.commission_pct from employees e
where e.commission_pct > (select avg(commission_pct) from employees where job_id = e.job_id);

--department hired most employees
select hire_year from
(select extract(year from hire_date) as hire_year, count(*) as total
from employees 
group by extract(year from hire_date)
order by total desc) where rownum = 1;

SELECT first_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = (
    SELECT hire_year
    FROM (
        SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,
               COUNT(*) AS total
        FROM employees
        GROUP BY EXTRACT(YEAR FROM hire_date)
        ORDER BY total DESC
    ) WHERE ROWNUM = 1
);

--list departments with more than 5 employees with salary > 5000
select department_id, count(*) as total_employees from employees
where salary > 5000 group by department_id
having count(*) > 5;

DESC products;
--SQL TRIGGERS QUESTION
CREATE OR REPLACE TRIGGER trg_name
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
BEGIN
    IF :New.price <= 0 or :New.stock_quantity <= 0 THEN
       RAISE_APPLICATION_ERROR(-2001, 'invalid values');
    END IF;
END;
/

INSERT INTO products 
VALUES (11, 'Test Product', 5000, 5, NULL, NULL, NULL, NULL);

insert into products VALUES (12, 'Bad Product', -2000, 5, NULL, NULL, NULL, NULL);

CREATE OR REPLACE TRIGGER prevent_negative_values
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
BEGIN
    -----------------------------------------------------------------
    -- 1. Prevent entry of negative or zero values
    -----------------------------------------------------------------
    IF :NEW.price <= 0 OR :NEW.stock_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Product price or product quantity cannot be negative or zero'
        );
    END IF;

    -----------------------------------------------------------------
    -- 2. Monitor low stock levels  (stock < 5)
    -----------------------------------------------------------------
    IF :NEW.stock_quantity < 5 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'The product is going out of stock'
        );
    END IF;

    -----------------------------------------------------------------
    -- 3. Restrict stock reduction during UPDATE (> 50% drop)
    -----------------------------------------------------------------
    IF UPDATING THEN
        IF :OLD.stock_quantity IS NOT NULL
           AND :OLD.stock_quantity > 0
           AND :NEW.stock_quantity < (:OLD.stock_quantity * 0.5) THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Stock reduction exceeds allowed limit (50%)'
            );
        END IF;
    END IF;

    -----------------------------------------------------------------
    -- 4. Automatically calculate SUBTOTAL and
    --    prevent manual updates on SUBTOTAL
    -----------------------------------------------------------------
    -- If someone tries: UPDATE products SET subtotal = ...;
    IF UPDATING('SUBTOTAL') THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'This field cannot be updated manually'
        );
    END IF;

    -- Always calculate subtotal from price * stock_quantity
    :NEW.subtotal := :NEW.price * :NEW.stock_quantity;

    -----------------------------------------------------------------
    -- 5. Maintain audit fields CREATED_BY / UPDATED_BY
    -----------------------------------------------------------------
    IF INSERTING THEN
        :NEW.created_by := USER;   -- who is inserting
    ELSIF UPDATING THEN
        :NEW.updated_by := USER;   -- who is updating
    END IF;

    -----------------------------------------------------------------
    -- 6. Update LAST_UPDATED on every INSERT or UPDATE
    -----------------------------------------------------------------
    :NEW.last_updated := SYSDATE;
END;
/
--transactions
CREATE TABLE customers (
    cust_id    NUMBER PRIMARY KEY,
    name       VARCHAR2(50)
);
CREATE TABLE medicines (
    med_id     NUMBER PRIMARY KEY,
    name       VARCHAR2(50),
    stock      NUMBER,
    price      NUMBER
);
CREATE TABLE orders (
    order_id   NUMBER PRIMARY KEY,
    cust_id    NUMBER REFERENCES customers(cust_id)
);
CREATE TABLE order_items (
    item_id    NUMBER PRIMARY KEY,
    order_id   NUMBER REFERENCES orders(order_id),
    med_id     NUMBER REFERENCES medicines(med_id),
    qty        NUMBER
);
CREATE TABLE order_log (
    log_id     NUMBER PRIMARY KEY,
    order_id   NUMBER,
    message    VARCHAR2(200)
);


INSERT INTO customers VALUES (101, 'Ali Khan');
INSERT INTO customers VALUES (102, 'Sara Malik');

INSERT INTO medicines VALUES (1, 'Panadol', 50, 30);
INSERT INTO medicines VALUES (2, 'Augmentin', 10, 120);
INSERT INTO medicines VALUES (3, 'Vitamin C', 100, 15);

DECLARE
    v_stock   NUMBER;
    v_order   NUMBER := 5001;  -- example order id
    v_cust    NUMBER := 101;   -- example customer
    v_med     NUMBER := 1;     -- example medicine
    v_qty     NUMBER := 3;     -- quantity ordered
BEGIN
    SAVEPOINT start_order;

    -- Step 1: Insert into orders
    INSERT INTO orders(order_id, cust_id)
    VALUES (v_order, v_cust);

    -- Step 2: Check stock
    SELECT stock INTO v_stock
    FROM medicines
    WHERE med_id = v_med
    FOR UPDATE;

    IF v_stock < v_qty THEN
        -- Not enough stock
        INSERT INTO order_log(log_id, order_id, message)
        VALUES (1001, v_order, 'Insufficient stock');

        ROLLBACK TO start_order;
    ELSE
        -- Step 3: Insert item
        INSERT INTO order_items(item_id, order_id, med_id, qty)
        VALUES (2001, v_order, v_med, v_qty);

        -- Step 4: Deduct stock
        UPDATE medicines
        SET stock = stock - v_qty
        WHERE med_id = v_med;

        -- Log success
        INSERT INTO order_log(log_id, order_id, message)
        VALUES (1002, v_order, 'Order completed successfully');

        COMMIT;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO start_order;

        INSERT INTO order_log(log_id, order_id, message)
        VALUES (1003, v_order, 'Transaction failed due to error');

        COMMIT;
END;
/

--plsql

-- 1. CREATE OBJECT TYPE
CREATE OR REPLACE TYPE order_item AS OBJECT (
    item_name  VARCHAR2(50),
    quantity   NUMBER,
    price      NUMBER,
    MEMBER FUNCTION total_cost RETURN NUMBER
);
/

-- 2. TYPE BODY WITH MEMBER FUNCTION
CREATE OR REPLACE TYPE BODY order_item AS
    MEMBER FUNCTION total_cost RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        -- basic total
        v_total := quantity * price;

        -- if quantity > 5, apply 5% discount
        IF quantity > 5 THEN
            v_total := v_total * 0.95;   -- 5% off
        END IF;

        RETURN v_total;
    END;
END;
/

-- 3. OBJECT TABLE TO STORE ORDER ITEMS
CREATE TABLE order_items_obj OF order_item;

INSERT INTO order_items_obj VALUES (order_item('Pens',        3,  20));
INSERT INTO order_items_obj VALUES (order_item('Notebooks',   6, 150));
INSERT INTO order_items_obj VALUES (order_item('Markers',     8,  50));
INSERT INTO order_items_obj VALUES (order_item('Folders',     2, 100));

SET SERVEROUTPUT ON;

DECLARE
    v_highest NUMBER := 0;
    v_cost    NUMBER;
BEGIN
    -- Loop through all object rows
    FOR r IN (SELECT VALUE(o) AS item_obj FROM order_items_obj o) LOOP
        -- call member function on the object
        v_cost := r.item_obj.total_cost();

        DBMS_OUTPUT.PUT_LINE(
              'Item: ' || r.item_obj.item_name
           || ', Qty: ' || r.item_obj.quantity
           || ', Price: ' || r.item_obj.price
           || ', Final Bill: ' || v_cost
        );

        -- track highest bill
        IF v_cost > v_highest THEN
            v_highest := v_cost;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Highest bill amount = ' || v_highest);
END;
/


