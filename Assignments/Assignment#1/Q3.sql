-- Layyana Junaid 23k-0056
-- Question 3 - Hospital Management System

CREATE TABLE Patient (
    Patient_ID      NUMBER PRIMARY KEY,
    Name            VARCHAR2(100) NOT NULL,
    Gender          CHAR(1) CHECK (Gender IN ('M', 'F')),
    DOB             DATE,
    Email           VARCHAR2(150) UNIQUE,
    Phone           VARCHAR2(20),
    Address         VARCHAR2(255),
    Username        VARCHAR2(50),
    Password        VARCHAR2(50)
);

CREATE TABLE Doctor (
    Doctor_ID       NUMBER PRIMARY KEY,
    Name            VARCHAR2(100),
    Specialization  VARCHAR2(100),
    Username        VARCHAR2(50),
    Password        VARCHAR2(50)
);

-- Appointment Table
CREATE TABLE Appointment (
    Appointment_ID      NUMBER PRIMARY KEY,
    Appointment_Date    DATE,
    Appointment_Time    VARCHAR2(20),
    Status              VARCHAR2(20),
    Clinic_Number       VARCHAR2(20),
    Patient_ID          NUMBER,
    Doctor_ID           NUMBER,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Prescription Table
-- NOTE: Use Prescription_Date instead of Date to avoid reserved-word conflicts
CREATE TABLE Prescription (
    Prescription_ID     NUMBER PRIMARY KEY,
    Prescription_Date   DATE,
    Doctor_Advice       VARCHAR2(255),
    Followup_Required   CHAR(1) CHECK (Followup_Required IN ('Y', 'N')),
    Patient_ID          NUMBER,
    Doctor_ID           NUMBER,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Invoice Table
CREATE TABLE Invoice (
    Invoice_ID      NUMBER PRIMARY KEY,
    Invoice_Date    DATE,
    Amount          NUMBER(10,2),
    Payment_Status  VARCHAR2(20),
    Payment_Method  VARCHAR2(50),
    Patient_ID      NUMBER,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- Tests Table (now linked to Patient and Doctor so we can show who requested tests)
CREATE TABLE Tests (
    Test_ID         NUMBER PRIMARY KEY,
    Blood_Test      VARCHAR2(5),
    X_Ray           VARCHAR2(5),
    MRI             VARCHAR2(5),
    CT_Scan         VARCHAR2(5),
    Patient_ID      NUMBER,
    Doctor_ID       NUMBER,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

------------------------------------------------------------
-- SAMPLE DATA (insert in dependency order)
------------------------------------------------------------

-- Patients
INSERT INTO Patient VALUES (1, 'Ali Khan', 'M', DATE '1990-01-01', 'ali.khan@email.com', '03001234567', 'Karachi', 'alikhan', 'pass123');
INSERT INTO Patient VALUES (2, 'Sara Ahmed', 'F', DATE '1995-05-10', 'sara.ahmed@email.com', '03007654321', 'Lahore', 'saraah', 'pass456');

-- Doctors
INSERT INTO Doctor VALUES (101, 'Dr. Hamid', 'Cardiology', 'hamid', 'doc123');
INSERT INTO Doctor VALUES (102, 'Dr. Ayesha', 'Neurology', 'ayesha', 'doc456');

-- Appointments
INSERT INTO Appointment VALUES (201, DATE '2025-09-02', '10:00 AM', 'Booked', 'C-01', 1, 101);
INSERT INTO Appointment VALUES (202, DATE '2025-09-03', '11:30 AM', 'Cancelled', 'C-02', 2, 102);

-- Prescriptions (uses Prescription_Date)
INSERT INTO Prescription VALUES (301, DATE '2025-09-02', 'Take medicine twice daily', 'Y', 1, 101);
INSERT INTO Prescription VALUES (302, DATE '2025-09-05', 'Complete rest required', 'N', 2, 102);

-- Invoices
INSERT INTO Invoice VALUES (401, DATE '2025-09-02', 5000, 'Unpaid', 'Cash', 1);
INSERT INTO Invoice VALUES (402, DATE '2025-09-05', 7000, 'Paid', 'Card', 2);

-- Tests (linked to patient & doctor)
INSERT INTO Tests VALUES (501, 'Yes', 'No', 'No', 'No', 1, 101);
INSERT INTO Tests VALUES (502, 'No', 'Yes', 'No', 'No', 2, 102);

COMMIT;

------------------------------------------------------------
-- DML QUERIES (as requested in the assignment)
------------------------------------------------------------

-- a) Update phone number and email of patient with ID = 1
UPDATE Patient
SET Phone = '03111234567', Email = 'ali.khan.new@email.com'
WHERE Patient_ID = 1;
COMMIT;

-- b) Update payment status of an invoice from "Unpaid" to "Paid"
UPDATE Invoice
SET Payment_Status = 'Paid'
WHERE Invoice_ID = 401;
COMMIT;

-- c) Delete all cancelled appointments
DELETE FROM Appointment
WHERE Status = 'Cancelled';
COMMIT;

-- d) Delete an invoice for a refunded patient (example: invoice 402)
DELETE FROM Invoice
WHERE Invoice_ID = 402;
COMMIT;

-- e) Select all appointments that are still "Booked"
SELECT * FROM Appointment
WHERE Status = 'Booked';

-- f) Select all invoices that are "Unpaid"
SELECT * FROM Invoice
WHERE Payment_Status = 'Unpaid';

-- g) Select all lab tests of type "Blood Test"
SELECT * FROM Tests
WHERE Blood_Test = 'Yes';

-- h) Select all prescriptions issued on '2025-09-02'
SELECT * FROM Prescription
WHERE Prescription_Date = DATE '2025-09-02';

------------------------------------------------------------
-- ADVANCED SQL QUERIES
------------------------------------------------------------

-- a) Show all patients with their doctors booked (appointments)
SELECT p.Name   AS Patient_Name,
       d.Name   AS Doctor_Name,
       a.Appointment_Date,
       a.Appointment_Time,
       a.Status
FROM Patient p
JOIN Appointment a ON p.Patient_ID = a.Patient_ID
JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
ORDER BY a.Appointment_Date, a.Appointment_Time;

-- b) Show all lab tests of patients and the doctor who requested them
SELECT p.Name      AS Patient_Name,
       d.Name      AS Doctor_Name,
       t.Test_ID,
       t.Blood_Test,
       t.X_Ray,
       t.MRI,
       t.CT_Scan
FROM Tests t
JOIN Patient p ON t.Patient_ID = p.Patient_ID
JOIN Doctor d  ON t.Doctor_ID = d.Doctor_ID
ORDER BY p.Name;

-- c) Show prescriptions only for patients named "Ali Khan"
SELECT p.Name, pr.Prescription_ID, pr.Doctor_Advice, pr.Prescription_Date
FROM Patient p
JOIN Prescription pr ON p.Patient_ID = pr.Patient_ID
WHERE p.Name = 'Ali Khan';

-- d) Show prescriptions with doctors where follow-up is required
SELECT pr.Prescription_ID,
       pr.Doctor_Advice,
       pr.Prescription_Date,
       p.Name AS Patient_Name,
       d.Name AS Doctor_Name
FROM Prescription pr
JOIN Patient p ON pr.Patient_ID = p.Patient_ID
JOIN Doctor d  ON pr.Doctor_ID = d.Doctor_ID
WHERE pr.Followup_Required = 'Y'
ORDER BY pr.Prescription_Date;

