-- ============
-- Functions
-- ============

-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS Functions;
USE Functions;

-- Create Employees table
CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Insert sample data
INSERT INTO Employees (name, salary, hire_date) VALUES
('Joker', 65000.00, '2023-06-12'),
('Bokkayya', 25000.00, '2024-05-20'),
('Sanillu', 20000.00, '2023-12-04');

-- ===================
-- Built-In Functions
-- ===================

-- String Functions
SELECT CONCAT('Employee: ', name) AS EmployeeName FROM Employees;
SELECT SUBSTRING(name, 1, 3) AS ShortName FROM Employees;
SELECT LENGTH(name) AS NameLength FROM Employees;
SELECT UPPER(name) AS UpperName FROM Employees;
SELECT LOWER(name) AS LowerName FROM Employees;
SELECT TRIM(' ' FROM name) AS TrimmedName FROM Employees;

-- Numeric Functions
SELECT salary, ROUND(salary, 2) AS RoundedSalary FROM Employees;
SELECT salary, FLOOR(salary) AS FlooredSalary FROM Employees;
SELECT salary, CEIL(salary) AS CeilSalary FROM Employees;
SELECT salary, ABS(salary - 60000) AS SalaryDifference FROM Employees;
SELECT salary, MOD(salary, 10000) AS SalaryMod FROM Employees;

-- Date and Time Functions
SELECT hire_date, NOW() AS CurrentDateTime FROM Employees;
SELECT hire_date, DATE_ADD(hire_date, INTERVAL 1 YEAR) AS NextYear FROM Employees;
SELECT DATEDIFF(NOW(), hire_date) AS DaysSinceHired FROM Employees;
SELECT DATE_FORMAT(hire_date, '%Y-%m-%d') AS FormattedDate FROM Employees;
SELECT YEAR(hire_date) AS HireYear FROM Employees;

-- Aggregate Functions
SELECT SUM(salary) AS TotalSalaries FROM Employees;
SELECT AVG(salary) AS AverageSalary FROM Employees;
SELECT COUNT(*) AS TotalEmployees FROM Employees;
SELECT MAX(salary) AS HighestSalary FROM Employees;
SELECT MIN(salary) AS LowestSalary FROM Employees;

-- Conditional Functions
SELECT name,
       IF(salary > 60000, 'High', 'Low') AS SalaryLevel
FROM Employees;

SELECT name,
       CASE
         WHEN salary > 60000 THEN 'High'
         WHEN salary >= 25000 THEN 'Mid'
         ELSE 'Low'
       END AS SalaryCategory
FROM Employees;

SELECT NULLIF(salary, 50000) AS SalaryNullIf FROM Employees;
SELECT COALESCE(salary, 0) AS SalaryCoalesce FROM Employees;

-- ========================
-- User-Defined Functions
-- ========================

-- Creating a User-Defined Function for Salary Range
DELIMITER //
CREATE FUNCTION GetSalaryRange(salary DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC  -- The function returns the same result for the same inputs every time.
READS SQL DATA  -- The function can read from the database but does not modify any data.
BEGIN
    DECLARE salary_range VARCHAR(20); -- Declare the variable to hold the result

    -- Determine salary range based on the value
    IF salary > 60000 THEN
        SET salary_range = 'High'; -- Set 'High' if salary is above 60,000
    ELSEIF salary >= 25000 THEN
        SET salary_range = 'Mid'; -- Set 'Mid' if salary is between 25,000 and 60,000
    ELSE
        SET salary_range = 'Low'; -- Set 'Low' if salary is below 25,000
    END IF;

    RETURN salary_range; -- Return the result
END //
DELIMITER ;

-- Using the User-Defined Function for Salary Range
SELECT name, GetSalaryRange(salary) AS SalaryRange
FROM Employees;

-- Creating a Function to Calculate Years of Experience
DELIMITER //
CREATE FUNCTION CalculateExperience(hire_date DATE)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE experience VARCHAR(50);

    -- Calculate years
    SET years = TIMESTAMPDIFF(YEAR, hire_date, CURDATE());

    -- Calculate months within the current year
    SET months = TIMESTAMPDIFF(MONTH, DATE_ADD(hire_date, INTERVAL years YEAR), CURDATE());

    -- Format experience as 'X years Y months'
    SET experience = CONCAT(years, ' years ', months, ' months');

    RETURN experience;
END //
DELIMITER ;

-- Using the Function to Calculate Years of Experience
SELECT name, hire_date, CalculateExperience(hire_date) AS YearsOfExperience
FROM Employees;

-- Creating a Function with Error Handling
DELIMITER //
CREATE FUNCTION SafeDivide(dividend DECIMAL(10,2), divisor DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL          -- The function performs no SQL operations, only arithmetic.
BEGIN
    DECLARE result DECIMAL(10,2);
    IF divisor = 0 THEN
        RETURN NULL; -- Handle division by zero
    ELSE
        SET result = dividend / divisor;
        RETURN result;
    END IF;
END //
DELIMITER ;

-- Using the Function with Error Handling
SELECT name, salary, SafeDivide(salary, 10000) AS SalaryPerDivision
FROM Employees;




