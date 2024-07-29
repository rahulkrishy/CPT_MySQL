-- // JOINS

-- DATABASE CREATION
CREATE DATABASE joins;

USE joins;

-- TABLE 1 CREATION
CREATE TABLE friends(
id INT AUTO_INCREMENT PRIMARY KEY, -- AUTO_INCREMENT: Automatically generate a unique sequential value for each new row
name VARCHAR(20)
);

-- INSERTING DATA INTO TABLE 1
INSERT INTO friends(name)
VALUES
("regex"),
("Ray"),
("Joker"),
("Bokkayya"),
("Sanillu"),
("kutty");

-- SELECT ALL DATA FROM friends TABLE
SELECT * FROM friends;

-- TABLE 2 CREATION
CREATE TABLE explore(
id INT AUTO_INCREMENT PRIMARY KEY,
lists VARCHAR(20)
);

-- INSERTING DATA INTO TABLE 2
INSERT INTO explore(lists)
VALUES
("Technology"),
("Technology"),
("Teaching"),
("Gaming"),
("Government"),
("Travelling"),
("Business");

-- SELECT ALL DATA FROM explore TABLE
SELECT * FROM explore;

-- // INNER JOIN
-- Retrieves rows with matching ids from both tables
SELECT friends.id, friends.name, explore.lists
FROM friends
INNER JOIN explore
ON friends.id = explore.id;

-- // OUTER JOIN

-- // LEFT JOIN
-- Retrieves all rows from friends table and matched rows from explore table
SELECT friends.id, friends.name, explore.lists
FROM friends
LEFT JOIN explore
ON friends.id = explore.id;

-- // RIGHT JOIN
-- Retrieves all rows from explore table and matched rows from friends table
SELECT friends.id, friends.name, explore.lists
FROM friends
RIGHT JOIN explore
ON friends.id = explore.id;

-- // FULL JOIN
-- Retrieves rows when there is a match in either table
SELECT *
FROM friends
LEFT JOIN explore
ON friends.id = explore.id
UNION
SELECT *
FROM friends
RIGHT JOIN explore
ON friends.id = explore.id;

-- // CROSS JOIN
-- Produces Cartesian product of both tables
SELECT *
FROM friends
CROSS JOIN explore
ORDER BY friends.id, explore.id ASC;

-- // SELF JOIN

-- TABLE 3 CREATION
CREATE TABLE members(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
mentorid INT
);

-- INSERTING DATA INTO TABLE 3
INSERT INTO members(name, mentorid)
VALUES
("Ray", 2),
("joker", 1),
("bokkayya", 1),
("sanillu", 3),
("kutty", 1);

-- SELECT ALL DATA FROM members TABLE
SELECT * FROM members;

-- Joining the table to itself to retrieve members and their mentors
SELECT r1.id, r1.name, r2.name AS mentor_name
FROM members AS r1
JOIN members AS r2
ON r1.mentorid = r2.id
ORDER BY r1.id ASC;

-- // Exclusive JOINS

-- // LEFT Exclusive JOIN
-- Retrieves rows from friends that do not have matching rows in explore
SELECT *
FROM friends
LEFT JOIN explore
ON friends.id = explore.id
WHERE explore.id IS NULL;

-- // RIGHT Exclusive JOIN
-- Retrieves rows from explore that do not have matching rows in friends
SELECT *
FROM friends
RIGHT JOIN explore
ON friends.id = explore.id
WHERE friends.id IS NULL;

-- // FULL Exclusive JOIN
-- Retrieves rows from both tables that do not have matching rows in the other table
SELECT *
FROM friends
LEFT JOIN explore
ON friends.id = explore.id
WHERE explore.id IS NULL
UNION
SELECT *
FROM friends
RIGHT JOIN explore
ON friends.id = explore.id
WHERE friends.id IS NULL;

-- // UNION
-- Combines the result sets of two SELECT statements and removes duplicates
SELECT id
FROM friends
UNION
SELECT id
FROM explore;

-- // UNION ALL
-- Combines the result sets of two SELECT statements and includes duplicates
SELECT id
FROM friends
UNION ALL
SELECT id
FROM explore;
