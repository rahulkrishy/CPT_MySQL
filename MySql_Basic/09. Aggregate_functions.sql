-- Create the database named 'AggregateFunc'
CREATE DATABASE IF NOT EXISTS AggregateFunc;
USE AggregateFunc;

-- Create the Employees table for demonstration
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

-- Insert sample data into the Employees table
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Comali', 1, 50000),
(2, 'Bokkayya', 2, 60000),
(3, 'Ray', 1, 70000),
(4, 'Sanillu', 2, 80000),
(5, 'Kutty', 1, 90000);

-- Demonstrate COUNT() function
-- Count the total number of employees
SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- Demonstrate SUM() function
-- Calculate the total salary of all employees
SELECT SUM(Salary) AS TotalSalary
FROM Employees;

-- Demonstrate AVG() function
-- Find the average salary of all employees
SELECT AVG(Salary) AS AverageSalary
FROM Employees;

-- Demonstrate MIN() function
-- Find the minimum salary among employees
SELECT MIN(Salary) AS LowestSalary
FROM Employees;

-- Retrieve only the rows with the minimum salary
SELECT *
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees);

-- Retrieve only the rows with the minimum salary and include the minimum salary as a column
SELECT *,
       (SELECT MIN(Salary) FROM Employees) AS LowestSalary
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees);

-- Demonstrate MAX() function
-- Find the maximum salary among employees
SELECT MAX(Salary) AS HighestSalary
FROM Employees;

-- Demonstrate GROUP_CONCAT() function
-- List all employee names in each department
SELECT DepartmentID, GROUP_CONCAT(Name ORDER BY Name SEPARATOR ', ') AS EmployeesList
FROM Employees
GROUP BY DepartmentID;

-- Demonstrate COUNT(DISTINCT) function
-- Count the number of unique departments
SELECT COUNT(DISTINCT DepartmentID) AS UniqueDepartments
FROM Employees;
