--Layyana Junaid 23k-0056
--Lab 3-In Lab task
CREATE TABLE departments(
  dept_id NUMBER PRIMARY KEY,
  dept_name VARCHAR2(50) UNIQUE
);

CREATE TABLE employees(
  emp_id   NUMBER PRIMARY KEY,
  emp_name VARCHAR2(50),
  salary   NUMBER CONSTRAINT chk_salary CHECK (salary > 20000),
  dept_id  NUMBER,
  CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

ALTER TABLE employees RENAME COLUMN emp_name TO full_name;

INSERT INTO departments (dept_id, dept_name) VALUES (101, 'HR');
INSERT INTO departments (dept_id, dept_name) VALUES (102, 'Finance');
INSERT INTO departments (dept_id, dept_name) VALUES (103, 'AI');

-- Insert employees
INSERT INTO employees (emp_id, full_name, salary, dept_id) 
VALUES (1, 'Layyana Junaid', 50000, 101);

INSERT INTO employees (emp_id, full_name, salary, dept_id) 
VALUES (2, 'Taaha Shabbir', 60000, 102);

INSERT INTO employees (emp_id, full_name, salary, dept_id) 
VALUES (3, 'Wafa Zehra', 45000, 103);

-- Update salary
UPDATE employees
SET salary = 70000
WHERE emp_id = 1;

-- Delete one employee
DELETE FROM employees WHERE emp_id = 3;

-- Q6: Add and manage columns
ALTER TABLE employees ADD email VARCHAR2(100);
ALTER TABLE employees MODIFY email VARCHAR2(150);
ALTER TABLE employees DROP COLUMN email;

ALTER TABLE employees MODIFY salary NOT NULL;

-- Unique constraint on name
ALTER TABLE employees ADD CONSTRAINT unique_name UNIQUE (full_name);
ALTER TABLE employees DROP CONSTRAINT unique_name;

ALTER TABLE employees ADD bonus NUMBER(6,2) DEFAULT 1000;

ALTER TABLE employees ADD city VARCHAR2(20) DEFAULT 'Karachi';
ALTER TABLE employees ADD age NUMBER;

ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age > 18);

DELETE FROM employees WHERE emp_id IN (1, 3);

ALTER TABLE employees MODIFY full_name VARCHAR2(20);
ALTER TABLE employees MODIFY city VARCHAR2(20);

ALTER TABLE employees ADD email VARCHAR2(50) UNIQUE;
