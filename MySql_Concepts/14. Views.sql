-- =======
-- Views
-- =======

-- Create the Database and Tables:
CREATE DATABASE IF NOT EXISTS Views;
USE Views;

CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade DECIMAL(3, 2)
);

CREATE TABLE Classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50),
    teacher_name VARCHAR(50)
);

CREATE TABLE Enrollments (
    student_id INT,
    class_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (class_id) REFERENCES Classes(id)
);

INSERT INTO Students (name, age, grade) VALUES
('Joker', 14, 9.5),
('Bokkayya', 15, 8.7),
('Sanillu', 14, 9.1);

INSERT INTO Classes (class_name, teacher_name) VALUES
('Math', 'Mr. Ray'),
('Science', 'Mr. Kutty ');

INSERT INTO Enrollments (student_id, class_id, enrollment_date) VALUES
(1, 1, '2024-07-29'),
(2, 1, '2024-07-29'),
(3, 2, '2024-07-29');

-- 10.2 Create Views:

-- Simple View
CREATE VIEW StudentView AS  SELECT id, name, grade 
                            FROM Students;

-- Complex View
CREATE VIEW EnrollmentView AS SELECT s.name AS  student_name, c.class_name, e.enrollment_date
                                                FROM Enrollments AS e
                                                JOIN Students AS s 
                                                ON e.student_id = s.id
                                                JOIN Classes AS c 
                                                ON e.class_id = c.id;

-- Read-Only View
CREATE VIEW ClassCountView AS SELECT c.class_name, COUNT(e.student_id) AS num_students
                                                                          FROM Classes AS c
                                                                          JOIN Enrollments AS e 
                                                                          ON c.id = e.class_id
                                                                          GROUP BY c.class_name;

-- 10.3 Querying Views:
SELECT * FROM StudentView;
SELECT * FROM EnrollmentView;
SELECT * FROM ClassCountView;
