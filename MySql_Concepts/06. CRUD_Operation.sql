-- =====================================
-- Employee Management System SQL Script
-- =====================================

-- DATABASE CREATION
CREATE DATABASE CRUD_Operations; 

-- =========================
-- CREATE Command
-- =========================
USE CRUD_Operations;
-- Create a new table for employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    DepartmentID INT
);

-- Create a new table for departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- =========================
-- INSERT Command
-- =========================
-- Insert new records into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'Human Resources'), (2, 'Engineering'), (3, 'Marketing');

-- Insert new records into the Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Age, DepartmentID)
VALUES (1, 'Joker', 'Comali', 30, 2),
       (2, 'Bokkayya', 'Sri', 25, 1),
       (3, 'Sanillu', 'Sai', 35, 3);

-- Verify the inserted data
SELECT * FROM Departments;
SELECT * FROM Employees;

-- =========================
-- ALTER Command
-- =========================
-- Add a new column for Email to the Employees table
ALTER TABLE Employees 
ADD COLUMN Email VARCHAR(100);

-- Verify the structure after adding Email column
DESCRIBE Employees;

-- Modify the Age column to SMALLINT type
ALTER TABLE Employees 
MODIFY COLUMN Age SMALLINT;

-- Verify the structure after modifying Age column
DESCRIBE Employees;

-- Drop the Email column from the Employees table
ALTER TABLE Employees 
DROP COLUMN Email;

-- Verify the structure after dropping Email column
DESCRIBE Employees;

-- =========================
-- RENAME Command
-- =========================
-- Rename the Employees table to Staff
RENAME TABLE Employees TO Staff;

-- Verify the renaming of the table
SHOW TABLES;

-- Rename the LastName column to Surname in the Staff table
ALTER TABLE Staff 
CHANGE COLUMN LastName Surname VARCHAR(50);

-- Verify the structure after renaming the column
DESCRIBE Staff;

-- =========================
-- TRUNCATE Command
-- =========================
USE CRUD_Operations;
-- Truncate the Staff table (remove all data but keep the structure)
TRUNCATE TABLE Staff;

-- Verify the truncation
SELECT * FROM Staff;

-- Re-insert records into the Staff table for further operations
INSERT INTO Staff (EmployeeID, FirstName, Surname, Age, DepartmentID)
VALUES (1, 'Joker', 'Comali', 30, 2),
       (2, 'Bokkayya', 'Sri', 25, 1),
       (3, 'Sanillu', 'Sai', 35, 3);

-- Verify the re-inserted data
SELECT * FROM Staff;

-- =========================
-- UPDATE Command
-- =========================
-- Update the age of an employee
UPDATE Staff
SET Age = 31
WHERE EmployeeID = 1;

-- Verify the update
SELECT * FROM Staff 
WHERE EmployeeID = 1;

-- Update the department of an employee
UPDATE Staff
SET DepartmentID = 3
WHERE EmployeeID = 2;

-- Verify the update
SELECT * FROM Staff 
WHERE EmployeeID = 2;

-- =========================
-- DELETE Command
-- =========================
-- Delete a record from the Staff table
DELETE FROM Staff 
WHERE EmployeeID = 3;

-- Verify the deletion
SELECT * FROM Staff;

-- =========================
-- MERGE Command
-- =========================
-- Create a new table for new employee data
USE CRUD_Operations;
CREATE TABLE NewEmployees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    Surname VARCHAR(50),
    Age SMALLINT,
    DepartmentID INT
);

-- Insert new incoming data
INSERT INTO NewEmployees (EmployeeID, FirstName, Surname, Age, DepartmentID)
VALUES (1, 'Joker', 'Comali', 32, 2),  -- Existing employee with updated age
       (3, 'Sanillu', 'Sai', 28, 3), -- New employee
       (4, 'Vicky', 'Kutty', 28, 3); -- New employee

-- Verify the new data
SELECT DISTINCT FirstName, Surname FROM NewEmployees; --DISTINCT keyword to eliminate duplicate values if any

-- Use INSERT with ON DUPLICATE KEY UPDATE to update existing records and insert new records
INSERT INTO Staff (EmployeeID, FirstName, Surname, Age, DepartmentID)
SELECT EmployeeID, FirstName, Surname, Age, DepartmentID
FROM NewEmployees
ON DUPLICATE KEY UPDATE
    FirstName = VALUES(FirstName),
    Surname = VALUES(Surname),
    Age = VALUES(Age),
    DepartmentID = VALUES(DepartmentID);

-- Verify the merge operation
SELECT * FROM Staff;

-- =========================
-- DROP Command
-- =========================
USE CRUD_Operations;
-- Drop the NewEmployees table
DROP TABLE NewEmployees;

-- Verify the drop operation
SHOW TABLES;

-- Drop the Departments table
DROP TABLE Departments;

-- Verify the drop operation
SHOW TABLES;

