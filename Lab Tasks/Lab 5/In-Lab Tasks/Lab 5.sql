-- Layyana Junaid 23k-0056
-- In-Lab Tasks for Lab 5

-- Employees and Departments
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    manager_id INT
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Projects
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    teacher_id INT
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);

-- Teachers/Subjects
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE teaching_assignments (
    teacher_id INT,
    subject_id INT,
    PRIMARY KEY (teacher_id, subject_id)
);

-- Customers and Orders
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

insert into EMPLOYEES values(1, 'Layyana Junaid', 2, 3);
insert into EMPLOYEES values(2, 'Taaha Shabbir', 2, 4);
insert into EMPLOYEES values(3, 'Mehdia Rizvi', 1, 1);
insert into EMPLOYEES values(4, 'Hafsa Ali', 3, 2);

insert into DEPARTMENTS values(2, 'AI');
insert into DEPARTMENTS values(1, 'Consulting');
insert into DEPARTMENTS values(3, 'Marketing');

insert into projects values(1, 'Music Genre Predictor', 1);
insert into projects values(2, 'Alpha Recommendation System', 2);
insert into projects values(3, 'Oracle Support', 3);
insert into projects values(4, 'Website Revamp', 4);


INSERT INTO students VALUES (1, 'Layyana Junaid');
INSERT INTO students VALUES (2, 'Anma');

INSERT INTO teachers VALUES (1, 'Dr. Rafi ');
INSERT INTO teachers VALUES (2, 'Sir Talha');
INSERT INTO teachers VALUES (3, 'Dr. Jawad');

INSERT INTO courses VALUES (1, 'Database Systems', 1);
INSERT INTO courses VALUES (2, 'Web Development', 2);
INSERT INTO courses VALUES (3, 'Data Structures', 1);
INSERT INTO courses VALUES (4, 'Algorithms', 3);

INSERT INTO enrollments VALUES (1, 1);
INSERT INTO enrollments VALUES (1, 2);
INSERT INTO enrollments VALUES (2, 1);
INSERT INTO enrollments VALUES (3, 3);
INSERT INTO enrollments VALUES (4, 2);
INSERT INTO enrollments VALUES (5, 4);

INSERT INTO subjects VALUES (1, 'Mathematics');
INSERT INTO subjects VALUES (2, 'Computer Science');
INSERT INTO subjects VALUES (3, 'Physics');
INSERT INTO subjects VALUES (4, 'Chemistry');

INSERT INTO teaching_assignments VALUES (1, 2);
INSERT INTO teaching_assignments VALUES (2, 2);
INSERT INTO teaching_assignments VALUES (3, 1);

INSERT INTO customers VALUES (1, 'ABCD Corporation');
INSERT INTO customers VALUES (2, 'XYZ Ltd');
INSERT INTO customers VALUES (3, 'Global Services');
INSERT INTO customers VALUES (4, 'Tech Solutions'); 

INSERT INTO orders VALUES (1, 1, DATE '2023-01-15');
INSERT INTO orders VALUES (2, 1, DATE '2023-02-20');
INSERT INTO orders VALUES (3, 2, DATE '2023-03-10');
INSERT INTO orders VALUES (4, 3, DATE '2023-04-05');

SELECT 'Employees: ' || COUNT(*) FROM employees;
SELECT 'Departments: ' || COUNT(*) FROM departments;
SELECT 'Projects: ' || COUNT(*) FROM projects;
SELECT 'Students: ' || COUNT(*) FROM students;
SELECT 'Courses: ' || COUNT(*) FROM courses;
SELECT 'Enrollments: ' || COUNT(*) FROM enrollments;
SELECT 'Teachers: ' || COUNT(*) FROM teachers;
SELECT 'Subjects: ' || COUNT(*) FROM subjects;
SELECT 'Teaching Assignments: ' || COUNT(*) FROM teaching_assignments;
SELECT 'Customers: ' || COUNT(*) FROM customers;
SELECT 'Orders: ' || COUNT(*) FROM orders;

-- Q1
SELECT e.emp_name, d.dept_name
FROM employees e
CROSS JOIN departments d
ORDER BY e.emp_name, d.dept_name;

-- Q2
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
ORDER BY d.dept_name, e.emp_name;

-- Q3
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_name;

-- Q4
SELECT e.emp_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL
ORDER BY e.emp_name;

-- Q5
SELECT s.student_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_name, c.course_name;

-- Q6
SELECT c.customer_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date;

-- Q7
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
ORDER BY d.dept_name, e.emp_name;

-- Q8
SELECT t.teacher_name, s.subject_name,
       CASE WHEN ta.teacher_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS teaches_subject
FROM teachers t
CROSS JOIN subjects s
LEFT JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id AND s.subject_id = ta.subject_id
ORDER BY t.teacher_name, s.subject_name;

-- Q9
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY d.dept_name;

-- Q10
SELECT s.student_name, c.course_name, t.teacher_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN teachers t ON c.teacher_id = t.teacher_id
ORDER BY s.student_name, c.course_name;
