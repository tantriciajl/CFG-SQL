CREATE DATABASE staff;

USE staff;

/* create staff table to practice views */
CREATE TABLE staff.employee (
	`EmployeeID`	INT				NOT NULL,
	`FirstName`		VARCHAR(45)		NOT NULL,
    `LastName`		VARCHAR(45)		NOT NULL,
    `JobTitle`		VARCHAR(45)		NOT NULL,
	`ManagerID`		INT				NOT NULL,
    `Department`	VARCHAR(45),
    `Salary`		INT				NOT NULL,
    `DateOfBirth`	DATE			NOT NULL,
    
    PRIMARY KEY (`EmployeeID`)
);

SELECT * FROM employee;

/* insert data into staff table */
INSERT INTO employee (
	EmployeeID,
    FirstName,
    LastName,
    JobTitle,
    ManagerID,
    Department,
    Salary,
    DateOfBirth
)
VALUES 
(	1229,
	'Tricia',
	'Tan',
	'DBA',
	3333,
    'Database Administrators',
    50000,
    '2000-12-31'	),
(	3490,
	'Michael',
	'Haneke',
    'DBA',
    3333,
    'Database Administrators',
    70000,
    '1942-03-23'	);

SELECT * FROM employee;

/* alter columns in tables to add default and set limits */
ALTER TABLE employee
 CHANGE COLUMN `Salar`
	`Salary`		INT(11)		DEFAULT 0, -- max digits is now 11 and default is added £0 salary
 CHANGE COLUMN `DateOfBirth`
	`DateOfBirth`	DATE	DEFAULT '1900-01-01';

/* create a view table for HR staff that excludes staff salaries and birthdays */
CREATE VIEW vw_staff_common AS -- can also do REPLACE VIEW to replace existing view table
	SELECT -- select list of columns you would like to add to view table
		EmployeeID,
        FirstName,
        LastName,
        JobTitle,
        ManagerID,
        Department
	FROM
		employee -- select table name
	WHERE
		JobTitle LIKE '%DB%'; -- creating a view table containing only those employed as DB

SELECT * FROM vw_staff_common;

/* insert row for new employee into the original
staff table through the view table we just created */

INSERT INTO vw_staff_common
(	EmployeeID,
	FirstName,
	LastName,
    JobTitle,
    ManagerID,
    Department	)
VALUES
(	8888,
	'Yorgos',
    'Lanthimos',
    'Developer',
    2323,
    'Database Administrators'	);

SELECT * FROM vw_staff_common; -- new employee doesn't appear in view table
SELECT * FROM employee; -- but does appear in original employee table

/* this is because view table only shows 'DBA' job titles 
(as previously set) and new employee is a 'developer' */

/* modify view table to include WITH CHECK OPTION exact same columns as before */
CREATE OR REPLACE VIEW vw_staff_common AS 
	SELECT
		EmployeeID,
        FirstName,
        LastName,
        JobTitle,
        ManagerID,
        Department
	FROM
		Employee
	WHERE
		JobTitle LIKE '%DB%' -- condition of view table rows that can be added to view table
        WITH CHECK OPTION; -- stops + of new rows that doesn't comply with condition of view table

/* to replace old view insert table name of old view table otherwise 
put new view table name to create a new view or just use CREATE VIEW */

/* let's add new developer employee into original 
staff table through the view table just created */
INSERT INTO vw_staff_common -- select view table to insert values
(	EmployeeID,
	FirstName,
    LastName,
    JobTitle,
    ManagerID,
    Department	)
VALUES
(	5555,
	'Thomas',
    'Fisher',
    'Developer',
    8989,
    'Database Administrators'	); -- we get error message for CHECK OPTION

/* now let's add a new DB employee that complies with 
the '%DB%' condition we set before for the view table */
INSERT INTO vw_staff_common
(	EmployeeID,
	FirstName,
    LastName,
    JobTitle,
    ManagerID,
    Department	)
VALUES
(	2222,
	'Thomas',
    'Fisherprice',
    'DB Developer', -- satisfies the '%DB%' condition set for the view table
    '8989',
    'Database Administrators'	);

/* this new employee can be added to the view table because it 
fits in with '%DB%' condition we set for the WITH CHECK view table */

/* WITH CHECK OPTION prevents + of incompatible rows through an error message */

/* create views for shop database */
USE SHOP;

SELECT * FROM sales1;

CREATE VIEW vw_salesman AS
SELECT SalesPerson, SalesAmount
FROM Sales1;

SELECT * FROM vw_salesman;

/* make queries on view table the same way as you would a normal table */
SELECT DISTINCT -- distinct i.e. no repeats of salesperson
	SalesPerson, MAX(SalesAmount)
FROM
	vw_salesman
WHERE
	SalesAmount > 70
GROUP BY
	SalesPerson;
