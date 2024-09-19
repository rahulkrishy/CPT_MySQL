-- Subqueries/Nested Queries in SQL

-- DATABASE CREATION
CREATE DATABASE subquery;
USE subquery;

-- TABLE CREATION
CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT
);

CREATE TABLE Departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50)
);

-- INSERT DATA INTO Employees TABLE
INSERT INTO Employees (name, salary, department_id) VALUES
('Joker Comali', 60000, 1),
('Bokkayya Sri', 75000, 1),
('Sanillu Sai', 50000, 2),
('Vicky Kutty', 70000, 2),
('Ray Ray', 90000, 3);

-- INSERT DATA INTO Departments TABLE
INSERT INTO Departments (name, location) VALUES
('Engineering', 'New York'),
('Sales', 'San Francisco'),
('HR', 'Los Angeles');

-- 1. Single-Row Subqueries:
--    - Return a single row with one column.
--    - Used with comparison operators (=, <, >, etc.).
SELECT name 
FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 2. Multiple-Row Subqueries:
--    - Return multiple rows with one column.
--    - Used with operators like IN, ANY, ALL.
SELECT name 
FROM Employees 
WHERE department_id IN (SELECT id FROM Departments WHERE location = 'New York');

-- 3. Multiple-Column Subqueries:
--    - Return multiple rows and multiple columns.
--    - Used in clauses like IN, EXISTS, etc.
SELECT * 
FROM Employees 
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary) FROM Employees GROUP BY department_id);

-- Usage in Different Clauses
USE subquery;
-- 1. In the SELECT Clause:
--    - Used to calculate or retrieve a value that is then displayed in the main query results.
SELECT name, 
       (SELECT AVG(salary) FROM Employees) AS AverageSalary 
FROM Employees;

-- 2. In the FROM Clause:
--    - Treated as a temporary table within the main query.
USE subquery;
SELECT e.name, dept_avg.average_salary
FROM Employees AS e
JOIN (SELECT department_id, AVG(salary) AS average_salary 
      FROM Employees 
      GROUP BY department_id) AS dept_avg
ON e.department_id = dept_avg.department_id
WHERE dept_avg.average_salary > 50000;

/*
'JOIN ... ON e.department_id = dept_avg.department_id' performs an inner join between the Employees table (aliased as e) and the subquery result (aliased as dept_avg). 
The join condition e.department_id = dept_avg.department_id ensures that only rows with matching department IDs are joined.
*/

-- 3. In the WHERE Clause:
--    - Used to filter results based on the subquery result.
SELECT name 
FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 4. In the HAVING Clause:
--    - Used to filter groups based on the subquery result.
SELECT department_id, AVG(salary) 
FROM Employees 
GROUP BY department_id 
HAVING AVG(salary) > (SELECT AVG(salary) FROM Employees);

-- Correlated vs. Non-Correlated Subqueries

-- 1. Non-Correlated Subqueries:
--    - Can be executed independently of the main query.
--    - Execute once for the entire query.
SELECT name 
FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 2. Correlated Subqueries:
--    - Reference columns from the outer query.
--    - Execute once for each row processed by the outer query.
SELECT name 
FROM Employees e1 
WHERE salary > (SELECT AVG(salary) FROM Employees e2 WHERE e1.department_id = e2.department_id);

-- Find the Nth highest salary using a subquery
SELECT DISTINCT Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 1 OFFSET (2 - 1);  -- Replace N with the desired rank (e.g., 2 for the 2nd highest salary)
