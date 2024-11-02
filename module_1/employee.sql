CREATE DATABASE employee;

-- create employee table
CREATE TABLE employee
(employeeID INT PRIMARY KEY,
name VARCHAR(55),
managerID INT);

-- insert data into employee table
INSERT INTO employee
(employeeID, name, managerID)
VALUES
(1, 'mike', 3),
(2, 'david', 3),
(3, 'roger', NULL),
(4, 'mary', 2),
(5, 'joseph', 2),
(6, 'ben', 2);

SELECT *
FROM employee;

-- create inner join (self join) in employee table
SELECT 
	E1.NAME EMPLOYEENAME, E2.NAME AS MANAGERNAME
FROM
	EMPLOYEE E1 -- assign one identifier key to one table
    INNER JOIN
    EMPLOYEE E2 -- assign another identifier key to same table
    ON
    E1.MANAGERID = E2.EMPLOYEEID;

-- create outer join (self join) on employee table
SELECT 
	E1.NAME EMPLOYEE_NAME,
	IFNULL(E2.NAME, 'TOP MANAGER') AS MANAGER_NAME
FROM
	EMPLOYEE E1 -- E1 is identifier for employees
    LEFT JOIN
    EMPLOYEE E2 -- E2 is identifier for managers
    ON
    E1.MANAGERID = E2.EMPLOYEEID;

/* returns all employees and corresponding manager */