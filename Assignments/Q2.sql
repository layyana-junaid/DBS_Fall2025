--Layyana Junaid 23k-0056
--Question#2: Library Management System 

CREATE TABLE Departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL,
    location VARCHAR2(50)
);

CREATE TABLE Students (
    stud_id NUMBER PRIMARY KEY,
    stud_name VARCHAR2(50) NOT NULL,
    age NUMBER(3),
    dept_id NUMBER REFERENCES Departments(dept_id)
);

-- Insert Departments
INSERT INTO Departments VALUES (1, 'Artificial Intelligence', 'Karachi');
INSERT INTO Departments VALUES (2, 'Business Analytics', 'Lahore');
INSERT INTO Departments VALUES (3, 'Fintech', 'Islamabad');

-- Insert Students
INSERT INTO Students VALUES (101, 'Layyana', 20, 1);
INSERT INTO Students VALUES (102, 'Sara', 21, 1);
INSERT INTO Students VALUES (103, 'Taaha', 22, 2);
INSERT INTO Students VALUES (104, 'AbdulRehman', 23, 3);

SELECT s.stud_id, s.stud_name, s.age, d.dept_name
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id;

SELECT * FROM Students WHERE age > 21;

UPDATE Students
SET dept_id = 2
WHERE stud_name = 'Sara';

DELETE FROM Students
WHERE dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'Business Analytics');

SELECT * FROM Students;
SELECT * FROM Departments;
