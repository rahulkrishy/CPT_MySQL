-- Create the database named 'clauses'
CREATE DATABASE IF NOT EXISTS clauses;
USE clauses;

-- Create example tables for demonstration
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Insert sample data into the tables
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Comali', 1, 50000),
(2, 'Bokkayya', 2, 60000),
(3, 'Ray', 1, 70000),
(4, 'Sanillu', 2, 80000),
(5, 'Kutty', 1, 90000);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance');

-- Demonstrate the WHERE clause to filter records
-- Retrieve employees with Salary greater than 60000
SELECT * FROM Employees
WHERE Salary > 60000;

-- Demonstrate the GROUP BY clause to group results
-- Count the number of employees in each department
SELECT DepartmentID, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY DepartmentID;

-- Demonstrate the HAVING clause to filter groups
-- Retrieve departments with more than 1 employee
SELECT DepartmentID, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

-- Demonstrate the ORDER BY clause to sort results
-- Retrieve all employees, ordered by Salary in descending order
SELECT * FROM Employees
ORDER BY Salary DESC;

-- Demonstrate the LIMIT clause to restrict the number of rows returned
-- Retrieve the top 3 highest-paid employees in ascending order
SELECT * FROM Employees
ORDER BY Salary ASC
LIMIT 3;

-- Demonstrate the OFFSET clause to skip rows
-- Retrieve employees starting from the 2nd row, limiting to 3 rows
SELECT * FROM Employees
ORDER BY Salary DESC
LIMIT 3 OFFSET 1;

-- Demonstrate various JOIN types
-- INNER JOIN: Retrieve employees with their department names
SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- LEFT JOIN: Retrieve all employees and their department names (including those without a department)
SELECT e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- UNION: Combine results from two queries
-- Retrieve all distinct department names and employee names
SELECT DepartmentName AS Name FROM Departments
UNION
SELECT Name FROM Employees;

-- EXISTS: Check if there are any employees in the HR department
-- Return departments that have employees in them
SELECT DepartmentID
FROM Departments d
WHERE EXISTS (SELECT 1 FROM Employees e WHERE e.DepartmentID = d.DepartmentID);

-- CASE: Provide conditional logic in a query
-- Retrieve employee names and a custom message based on salary
SELECT Name,
       CASE
         WHEN Salary > 80000 THEN 'High Salary'
         WHEN Salary BETWEEN 60000 AND 80000 THEN 'Medium Salary'
         ELSE 'Low Salary'
       END AS SalaryCategory
FROM Employees;

-- DISTINCT: Retrieve unique department names
-- Ensure that department names are unique
SELECT DISTINCT DepartmentName
FROM Departments;

-- WITH (CTE): Define a Common Table Expression and use it
-- Retrieve employees with a salary higher than the average salary
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT Name, Salary
FROM Employees, AvgSalary
WHERE Employees.Salary > AvgSalary.AverageSalary;
