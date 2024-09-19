-- ====================================
-- SQL Operators Demonstration Script
-- ====================================

-- Create and use the database
CREATE DATABASE IF NOT EXISTS Operators;
USE Operators;

-- Drop table if exists to avoid conflicts
DROP TABLE IF EXISTS SampleData;

-- Create a sample table for demonstration
CREATE TABLE SampleData (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10, 2),
    Department VARCHAR(50),
    JoiningDate DATE,
    Status VARCHAR(10)
);

-- Insert sample data into the table
INSERT INTO SampleData (ID, Name, Age, Salary, Department, JoiningDate, Status)
VALUES 
    (1, 'Joker', 30, 60000.00, 'HR', '2022-01-15', 'Active'),
    (2, 'Bokkayya', 25, 55000.00, 'Engineering', '2022-03-22', 'Inactive'),
    (3, 'Sanillu', 35, 70000.00, 'Marketing', '2021-12-30', 'Active'),
    (4, 'Kutty', 28, 65000.00, 'Engineering', '2022-06-10', 'Active'),
    (5, 'Ray', NULL, NULL, 'HR', NULL, NULL);

-- =========================
-- Arithmetic Operators
-- =========================
-- Calculate annual salary and add 10% bonus
SELECT Name, 
       Salary, 
       Salary * 12 AS AnnualSalary, 
       Salary * 0.10 AS Bonus,
       ROUND(Salary * 0.10, 2) AS RoundedBonus  -- Function to round the bonus
FROM SampleData;

-- =========================
-- Comparison Operators
-- =========================
-- Find employees with salary greater than 60000
SELECT Name, Salary
FROM SampleData
WHERE Salary > 60000;

-- Find employees with age equal to 30
SELECT Name, Age
FROM SampleData
WHERE Age = 30;

-- =========================
-- Logical Operators
-- =========================
-- Find active employees in Engineering department
SELECT Name, Department
FROM SampleData
WHERE Status = 'Active' AND Department = 'Engineering';

-- Find employees who are either in HR or have a salary over 60000
SELECT Name, Department, Salary
FROM SampleData
WHERE Department = 'HR' OR Salary > 60000;

-- =========================
-- IN Operator
-- =========================
-- Find employees in HR or Marketing department
SELECT Name, Department
FROM SampleData
WHERE Department IN ('HR', 'Marketing');

-- Find employees with IDs 1, 2, or 4
SELECT Name, ID
FROM SampleData
WHERE ID IN (1, 2, 4);

-- =========================
-- IS NULL / IS NOT NULL Operator
-- =========================
-- Find employees with no salary information
SELECT Name
FROM SampleData
WHERE Salary IS NULL;

-- Find employees with a known joining date
SELECT Name
FROM SampleData
WHERE JoiningDate IS NOT NULL;

-- =========================
-- Bitwise Operator
-- =========================
-- MySQL bitwise operations example
-- Example of Bitwise AND: Find rows where ID has a bit set (ID 1 & 2 are valid for demonstration)
SELECT Name, ID
FROM SampleData
WHERE (ID & 1) = 1;  -- Checks if the least significant bit is set in ID

-- Example of Bitwise OR: Find rows where ID is either 1 or 2
SELECT Name, ID
FROM SampleData
WHERE (ID | 2) = 2;  -- Checks if ID has the bit 2 set (i.e., ID is 1 or 2)

-- =========================
-- LIKE & Wildcard Operators
-- =========================
-- Find employees whose names start with 'A'
SELECT Name
FROM SampleData
WHERE Name LIKE 'A%';

-- Find employees whose names contain 'R'
SELECT Name
FROM SampleData
WHERE Name LIKE '%R%';

-- Find employees whose names end with 'u'
SELECT Name
FROM SampleData
WHERE Name LIKE '%u';

-- =========================
-- BETWEEN Operator
-- =========================
-- Find employees whose ages are between 25 and 35
SELECT Name, Age
FROM SampleData
WHERE Age BETWEEN 25 AND 35;

-- Find employees who joined in 2022
SELECT Name, JoiningDate
FROM SampleData
WHERE JoiningDate BETWEEN '2022-01-01' AND '2022-12-31';

-- Clean up: Drop the table
-- DROP TABLE SampleData;

-- Optionally drop the database if needed
-- DROP DATABASE Operators;
