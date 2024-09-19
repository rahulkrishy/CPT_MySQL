-- Create a new database for student records
CREATE DATABASE IF NOT EXISTS school;

-- Use the newly created database
USE school;

-- Create a table for students
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollment_date DATE,
    gpa DECIMAL(3, 2)
);

-- Insert sample data into the students table
INSERT INTO students (first_name, last_name, email, enrollment_date, gpa)
VALUES 
('Comali', 'Joker', 'comali.joker@example.com', '2002-02-14', 2.14),
('Sri', 'Bokkayya', 'sri.bokkayya@example.com', '2002-04-11', 4.11),
('Sai', 'Sanillu', 'sai.sanillu@example.com', '2002-05-06', 5.06);
('Charlie', 'Brown', 'charlie.brown@example.com', '2002-07-04', 3.07);

-- Query: Select all columns from the students table
SELECT * FROM students;

-- Query: Select specific columns from the students table
SELECT first_name, last_name, gpa FROM students;

-- Query: Select students with a GPA greater than 3.70
SELECT first_name, last_name, gpa
FROM students
WHERE gpa > 3.70;

-- Query: Order students by GPA in descending order
SELECT first_name, last_name, gpa
FROM students
ORDER BY gpa DESC;

-- Query: Select top 2 students with the highest GPA
SELECT first_name, last_name, gpa
FROM students
ORDER BY gpa DESC
LIMIT 2;

-- Update the GPA of Comali Joker
UPDATE students
SET gpa = 3.07
WHERE first_name = 'Comali' AND last_name = 'Joker';

-- Delete the record of Charlie Brown
DELETE FROM students
WHERE first_name = 'Charlie' AND last_name = 'Brown';
