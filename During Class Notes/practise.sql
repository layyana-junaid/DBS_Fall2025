--------------------------------------------------------------------------------
-- Q1: HR SCHEMA QUERIES
-- You are working as a Database Developer using Oracle's HR schema.
-- This section performs analytical queries on employees, departments, and locations.
--------------------------------------------------------------------------------

-- 1️⃣ List employee name, job title, department name, and city of all employees.
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       e.job_id,
       d.department_name,
       l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
-- Explanation: We join EMPLOYEES with DEPARTMENTS (for department name)
-- and LOCATIONS (for city) to get complete employee information.

--------------------------------------------------------------------------------

-- 2️⃣ Find employees who earn more than the average salary of their department.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
-- Explanation: For each employee, we calculate the average salary of their department
-- and show those who earn more than that average.

--------------------------------------------------------------------------------

-- 3️⃣ Find names of employees who work in the same department as ‘Steven King’.
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.department_id = (
    SELECT department_id
    FROM employees
    WHERE first_name = 'Steven' AND last_name = 'King'
)
AND e.first_name <> 'Steven' AND e.last_name <> 'King';
-- Explanation: A subquery gets Steven King's department ID.
-- Then, the main query lists all other employees in that same department.

--------------------------------------------------------------------------------

-- 4️⃣ Display the highest paid employee in each department.
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);
-- Explanation: The subquery finds the maximum salary in each department,
-- and we display employees whose salary matches that max value.

--------------------------------------------------------------------------------

-- 5️⃣ Display department name, manager name, and number of employees under each manager.
SELECT d.department_name,
       m.first_name || ' ' || m.last_name AS manager_name,
       COUNT(e.employee_id) AS num_employees
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON e.manager_id = m.employee_id
GROUP BY d.department_name, m.first_name, m.last_name;
-- Explanation: We join DEPARTMENTS with the MANAGER record and count how many employees report to that manager.

--------------------------------------------------------------------------------

-- 6️⃣ Find employees who were hired before their department's manager.
SELECT e.first_name, e.last_name, e.hire_date,
       m.first_name AS manager_name, m.hire_date AS manager_hire_date
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;
-- Explanation: We compare each employee’s hire date to their manager’s hire date.

--------------------------------------------------------------------------------

-- 7️⃣ Show job title and average salary for jobs where the average salary exceeds $10,000.
SELECT job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_id
HAVING AVG(salary) > 10000;
-- Explanation: Group employees by JOB_ID and only show those with an average salary greater than 10,000.

--------------------------------------------------------------------------------

-- 8️⃣ List departments that have no employees assigned.
SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM employees
    WHERE department_id IS NOT NULL
);
-- Explanation: We select all departments not appearing in the EMPLOYEES table.

--------------------------------------------------------------------------------

-- 9️⃣ Find employees who have the maximum commission percentage.
SELECT first_name, last_name, salary, commission_pct
FROM employees
WHERE commission_pct = (SELECT MAX(commission_pct) FROM employees);
-- Explanation: The subquery finds the maximum commission percentage,
-- and the main query returns all employees with that commission.

--------------------------------------------------------------------------------
-- END OF Q1
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- Q2: E-COMMERCE MANAGEMENT SYSTEM DATABASE
-- We’ll design tables for Customers, Products, Orders, and OrderItems
-- with proper constraints and relationships.
--------------------------------------------------------------------------------

-- Drop existing tables (for reruns)
--------------------------------------------------------------------------------

-- 🧍‍♂️ Q1: Create Customers Table
CREATE TABLE Customers (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Auto-increment ID
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,   -- Unique email for each customer
    phone VARCHAR2(15) UNIQUE NOT NULL     -- Unique phone number
);

--------------------------------------------------------------------------------

-- 💻 Q2: Create Products Table
CREATE TABLE Products (
    product_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- Auto-increment
    product_name VARCHAR2(100) NOT NULL,
    price NUMBER(10,2) CHECK (price > 0),          -- Must be positive
    stock_quantity NUMBER DEFAULT 0 CHECK (stock_quantity >= 0)
);

--------------------------------------------------------------------------------

-- 📦 Q3: Create Orders Table
CREATE TABLE Orders (
    order_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER NOT NULL REFERENCES Customers(customer_id),
    order_date DATE DEFAULT SYSDATE NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
-- Explanation: Each order is linked to a customer.
-- The status must be one of the allowed options.

--------------------------------------------------------------------------------

-- 🧾 Q4: Create OrderItems Table
CREATE TABLE OrderItems (
    order_item_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id NUMBER NOT NULL REFERENCES Orders(order_id),
    product_id NUMBER NOT NULL REFERENCES Products(product_id),
    quantity NUMBER DEFAULT 1 CHECK (quantity >= 1),
    subtotal NUMBER(10,2) GENERATED ALWAYS AS (quantity *
        (SELECT price FROM Products WHERE Products.product_id = OrderItems.product_id)) VIRTUAL
);
-- Explanation:
-- Each OrderItem links an Order with a Product.
-- Subtotal is automatically calculated (price × quantity).

--------------------------------------------------------------------------------
-- INSERTION AND QUERY TASKS
--------------------------------------------------------------------------------

-- a) Insert a new customer named Ali Raza
INSERT INTO Customers (first_name, last_name, email, phone)
VALUES ('Ali', 'Raza', 'aliraza@example.com', '03001234567');

--------------------------------------------------------------------------------

-- b) Insert a new product 'Laptop'
INSERT INTO Products (product_name, price, stock_quantity)
VALUES ('Laptop', 100000, 10);

--------------------------------------------------------------------------------

-- c) Record a new order for Ali Raza with status 'Pending'
INSERT INTO Orders (customer_id, status)
VALUES (
    (SELECT customer_id FROM Customers WHERE first_name = 'Ali' AND last_name = 'Raza'),
    'Pending'
);

--------------------------------------------------------------------------------

-- d) Add an order item for that order with 2 Laptops
INSERT INTO OrderItems (order_id, product_id, quantity)
VALUES (
    (SELECT MAX(order_id) FROM Orders WHERE customer_id = 
        (SELECT customer_id FROM Customers WHERE first_name='Ali' AND last_name='Raza')),
    (SELECT product_id FROM Products WHERE product_name='Laptop'),
    2
);

--------------------------------------------------------------------------------

-- e) Update stock of 'Laptop' after purchase
UPDATE Products
SET stock_quantity = stock_quantity - 2
WHERE product_name = 'Laptop';

--------------------------------------------------------------------------------

-- f) Update the order status to 'Shipped'
UPDATE Orders
SET status = 'Shipped'
WHERE order_id = (SELECT MAX(order_id) FROM Orders);

--------------------------------------------------------------------------------

-- g) Retrieve customers who purchased products worth more than 50,000
SELECT c.first_name, c.last_name, SUM(oi.subtotal) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
HAVING SUM(oi.subtotal) > 50000;
-- Explanation: Joins all related tables, sums total purchase per customer,
-- and filters only those who spent above 50,000.

--------------------------------------------------------------------------------

-- h) Find the most frequently ordered product
SELECT p.product_name, SUM(oi.quantity) AS total_ordered
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_ordered DESC
FETCH FIRST 1 ROWS ONLY;
-- Explanation: Groups by product, counts how many were ordered, 
-- and returns the top one.

-- ================================================
-- Create CUSTOMER Table
-- Stores all customer details
-- ================================================
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,             -- Unique ID for each customer
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DriverLicenseNo VARCHAR(20) UNIQUE      -- Prevent duplicate licenses
);

-- ================================================
-- Create VEHICLE Table
-- Stores information about all vehicles
-- ================================================
CREATE TABLE Vehicle (
    VehicleID INT PRIMARY KEY,              -- Unique vehicle ID
    Model VARCHAR(50),
    Type VARCHAR(20),                       -- Car, Bike, or Van
    RentalRatePerDay DECIMAL(10,2)          -- Rate per day
);

-- ================================================
-- Create RENTAL Table
-- Links customers with vehicles and dates
-- ================================================
CREATE TABLE Rental (
    RentalID INT PRIMARY KEY,               -- Unique rental transaction
    CustomerID INT,                         -- References Customer
    VehicleID INT,                          -- References Vehicle
    StartDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),

    -- Ensures valid rental period
    CONSTRAINT chk_valid_dates CHECK (ReturnDate >= StartDate),

    -- Prevents a vehicle from being rented twice for overlapping periods
    CONSTRAINT unique_vehicle_rental UNIQUE (VehicleID, StartDate, ReturnDate)
);

-- ================================================
-- Create PAYMENT Table
-- Each rental can have multiple payments
-- ================================================
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,              -- Unique payment ID
    RentalID INT,                           -- References Rental
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
);

