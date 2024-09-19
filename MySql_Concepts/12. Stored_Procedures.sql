-- ==================
-- Stored Procedures
-- ==================

-- DATABASE CREATION
CREATE DATABASE IF NOT EXISTS Stored_procedure;
USE Stored_procedure;

-- TABLE CREATION
CREATE TABLE IF NOT EXISTS Employees (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Auto-incrementing primary key
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT
);

CREATE TABLE IF NOT EXISTS Departments (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Auto-incrementing primary key
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
('Engineering', 'Bangalore'),
('Marketing', 'Hyderabad'),
('Sales', 'Chennai'),
('HR', 'Coimbatore');

-- Stored Procedure Without Parameters
-- Creating a Stored Procedure
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * 
    FROM Employees;
END //
DELIMITER ;

-- Calling the Stored Procedure
USE Stored_procedure;
CALL GetAllEmployees();


-- Stored Procedure With Parameters
-- Creating a Stored Procedure
DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN empID INT)
BEGIN
    SELECT * 
    FROM Employees 
    WHERE id = empID;
END //

DELIMITER ;

-- Calling a Stored Procedure
USE Stored_procedure;
CALL GetEmployeeDetails(1);

-- Stored Procedure With IN Parameter
DELIMITER //

CREATE PROCEDURE ExampleIN(IN paramName INT)
BEGIN
    SELECT paramName AS InputValue;
END //

DELIMITER ;

-- Calling the IN Parameter Procedure
CALL ExampleIN(10);

-- Stored Procedure With OUT Parameter
DELIMITER //

CREATE PROCEDURE ExampleOUT(OUT paramName INT)
BEGIN
    SET paramName = 100;
END //

DELIMITER ;

-- Preparing to Call the OUT Parameter Procedure

-- Initialize a session variable @outputValue to 0 to hold the OUT parameter's value
SET @outputValue = 0;

-- Call the stored procedure ExampleOUT and pass @outputValue as the OUT parameter to capture the returned value
CALL ExampleOUT(@outputValue);

-- Select and display the value of the session variable @outputValue to see the result from the stored procedure
SELECT @outputValue AS OutputValue;

-- Stored Procedure With INOUT Parameter
DELIMITER //

CREATE PROCEDURE ExampleINOUT(INOUT paramName INT)
BEGIN
    SET paramName = paramName + 100;
END //

DELIMITER ;

-- Preparing to Call the INOUT Parameter Procedure
SET @inoutValue = 50;
CALL ExampleINOUT(@inoutValue);
SELECT @inoutValue AS InOutValue;

-- Control Flow Statement Example: Using IF
DELIMITER //

CREATE PROCEDURE CheckSalary(IN empID INT, OUT result VARCHAR(50))
BEGIN
    DECLARE empSalary DECIMAL(10, 2);

    SELECT salary INTO empSalary 
    FROM Employees 
    WHERE id = empID;

    IF empSalary > 70000 THEN
        SET result = 'High Salary';
    ELSE
        SET result = 'Average or Low Salary';
    END IF;
END //

DELIMITER ;

-- Preparing to Call the Control Flow Procedure
SET @salaryResult = '';
CALL CheckSalary(2, @salaryResult);
SELECT @salaryResult AS SalaryCheckResult;

-- Nth Highest Salary Using Subquery
DELIMITER //

CREATE PROCEDURE NthHighestSalary(IN N INT, OUT salaryValue DECIMAL(10, 2))
BEGIN
	-- Construct the dynamic SQL query to find the Nth highest salary
    SET @query = CONCAT('
    SELECT salary 
	INTO @sal 
    FROM (
    SELECT salary 
    FROM Employees 
    ORDER BY salary DESC 
    LIMIT ', N - 1, ', 1) 
    AS temp'
    );
    -- Prepare the dynamic SQL query
    PREPARE stmt FROM @query;
    
    -- Execute the prepared statement
    EXECUTE stmt;
    
    -- Deallocate the prepared statement to free resources
    DEALLOCATE PREPARE stmt;
    
    -- Set the output parameter with the result of the query
    SET salaryValue = @sal;
END //

DELIMITER ;

-- Preparing to Call the Nth Highest Salary Procedure
-- Initialize a variable to store the output value
SET @nthSalary = 0;

-- Call the stored procedure to find the 3rd highest salary
CALL NthHighestSalary(3, @nthSalary);

-- Select the output value to display the result
SELECT @nthSalary AS NthHighestSalary;
