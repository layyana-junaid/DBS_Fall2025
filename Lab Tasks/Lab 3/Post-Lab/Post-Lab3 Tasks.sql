--Layyana Junaid 23k-0056
--Lab3 Post-Lab tasks
-- Drop tables if they already exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Create departments
CREATE TABLE departments(
  dept_id NUMBER PRIMARY KEY,
  dept_name VARCHAR2(50) UNIQUE
);

-- Create employees
CREATE TABLE employees(
  emp_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(50),
  salary NUMBER CONSTRAINT chk_salary CHECK (salary > 20000),
  dept_id NUMBER,
  CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert departments
INSERT INTO departments VALUES (101, 'HR');
INSERT INTO departments VALUES (102, 'Finance');
INSERT INTO departments VALUES (103, 'AI');

-- Insert employees
INSERT INTO employees (emp_id, full_name, salary, dept_id) VALUES (1, 'Layyana Junaid', 50000, 101);
INSERT INTO employees (emp_id, full_name, salary, dept_id) VALUES (2, 'Taaha Shabbir', 60000, 102);
INSERT INTO employees (emp_id, full_name, salary, dept_id) VALUES (3, 'Wafa Zehra', 45000, 103);

-- Update salary
UPDATE employees SET salary = 70000 WHERE emp_id = 1;

-- Delete employee
DELETE FROM employees WHERE emp_id = 3;

-- Add new columns
ALTER TABLE employees ADD email VARCHAR2(100);
ALTER TABLE employees ADD bonus NUMBER(6,2) DEFAULT 1000;
ALTER TABLE employees ADD city VARCHAR2(20) DEFAULT 'Karachi';
ALTER TABLE employees ADD age NUMBER;
ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age > 18);

-- Insert more employees
INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus, city, age) 
VALUES (4, 'Ali Raza', 55000, 101, 2000, 'Lahore', 25);

INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus, city, age) 
VALUES (5, 'Sara Khan', 65000, 102, 2500, 'Karachi', 30);

-- Rename column
ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

-- Join query
SELECT d.dept_id, d.dept_name, e.emp_id, e.full_name, e.monthly_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- Find departments with no employees
SELECT dept_id, dept_name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- Department with highest employee count (works in all Oracle versions)
SELECT *
FROM (
  SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS employee_count
  FROM departments d
  LEFT JOIN employees e ON d.dept_id = e.dept_id
  GROUP BY d.dept_id, d.dept_name
  ORDER BY employee_count DESC
)
WHERE ROWNUM = 1;
