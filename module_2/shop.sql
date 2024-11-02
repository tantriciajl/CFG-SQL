CREATE DATABASE SHOP;
USE SHOP;

CREATE TABLE SALES1 (
Store VARCHAR(20) NOT NULL,
Week INT NOT NULL,
Day VARCHAR(10) NOT NULL,
SalesPerson VARCHAR(20) NOT NULL,
SalesAmount FLOAT NOT NULL,
Month VARCHAR(3) NOT NULL
);

SELECT * FROM SALES1;

INSERT INTO SALES1 (Store, Week, Day, SalesPerson, SalesAmount, Month)
VALUES 
('London', 2, 'Monday', 'Frank', 56.25, 'May'),
('London', 5, 'Tuesday', 'Frank', 74.32, 'Sep'),
('London', 5, 'Monday', 'Bill', 98.42, 'Sep'),
('London', 5, 'Saturday', 'Bill', 73.90, 'Dec'),
('London', 1, 'Tuesday', 'Josie', 44.27, 'Sep'),
('Dusseldorf', 4, 'Monday', 'Manfred', 77.00, 'Jul'),
('Dusseldorf', 3, 'Tuesday', 'Inga', 9.99, 'Jun'),
('Dusseldorf', 4, 'Wednesday', 'Manfred', 86.81, 'Jul'),
('London', 6, 'Friday', 'Josie', 74.02, 'Oct'),
('Dusseldorf', 1, 'Saturday', 'Manfred', 43.11, 'Apr');

SELECT * FROM SALES1;

USE SHOP;

ALTER TABLE SALES1
MODIFY COLUMN SalesAmount DECIMAL (6,2) NOT NULL;

SELECT * FROM SALES1;

ALTER TABLE SALES1
MODIFY COLUMN SalesAmount FLOAT NOT NULL;

ALTER TABLE SALES1
MODIFY COLUMN SalesAmount DECIMAL (6,3) NOT NULL;

ALTER TABLE SALES1
MODIFY COLUMN SalesAmount DECIMAL (6,3) NOT NULL;

USE SHOP;

SELECT * FROM SALES1;

SELECT
Store,
week
FROM SALES1;

USE SHOP;

SELECT * FROM SALES1;

SELECT *
FROM SALES1 S
ORDER BY S.MONTH;

SELECT *
FROM SALES1 S
WHERE S.STORE
LIKE 'D%'
ORDER BY S.WEEK;

SELECT S.STORE
FROM SALES1 S
WHERE S.STORE
LIKE '%DUSSEL%';

SELECT * FROM SALES1;

SELECT
SUM(S.SALESAMOUNT)
FROM SALES1 S;

SELECT * FROM SALES1;

SELECT
COUNT(DISTINCT S.SALESPERSON)
FROM SALES1 S;

SELECT 
MAX(S.SALESAMOUNT)
FROM SALES1 S;

SELECT
MIN(S.SALESAMOUNT)
FROM SALES1 S;

SELECT
AVG(S.SALESAMOUNT)
FROM SALES1 S;

SELECT 
LISTAG
FROM SALES1 S;

SELECT * FROM SALES1;

USE SHOP;

SELECT * FROM SALES1;

SELECT *
FROM SALES1 S
WHERE
S.STORE = 'LONDON' AND
S.MONTH != 'DEC' AND
S.SALESAMOUNT > 50.00 AND
S.SALESPERSON IN('FRANK', 'BILL');

SELECT -- total amount of sales per week number (no particular order)
SUM(S.SALESAMOUNT), S.WEEK
FROM SALES1 S
GROUP BY S.WEEK;

SELECT -- total amount of sales per week (in ascending order)
SUM(S.SALESAMOUNT), S.WEEK
FROM SALES1 S
GROUP BY S.WEEK
ORDER BY SUM(S.SALESAMOUNT) DESC;

SELECT
SUM(S.SALESAMOUNT), S.WEEK
FROM SALES1 S
GROUP BY S.WEEK
ORDER BY SUM(S.SALESAMOUNT); -- ascending order is default

select * from sales1;

SELECT
SUM(S.SALESAMOUNT),
S.DAY
FROM SALES1 S
GROUP BY S.DAY;

SELECT * FROM SALES1;

UPDATE SALES1
SET
SALES1.SALESPERSON = 'Annette'
WHERE
sales1.salesperson = 'ANNETTE';

SELECT * FROM SALES1;

SELECT 
SUM(S.SALESAMOUNT), S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON
HAVING S.SALESPERSON = 'ANNETTE';

SELECT * FROM SALES1;

SELECT
SUM(S.SALESAMOUNT), S.DAY
FROM SALES1 S
GROUP BY S.DAY;

SELECT * FROM SALES1;

SELECT
SUM(S.SALESAMOUNT),
AVG(S.SALESAMOUNT),
MIN(S.SALESAMOUNT),
MAX(S.SALESAMOUNT),
S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON;

SELECT
S.STORE,
SUM(S.SALESAMOUNT)
FROM SALES1 S
GROUP BY S.STORE;

SELECT
S.MONTH,
SUM(S.SALESAMOUNT)
FROM SALES1 S
GROUP BY S.MONTH
HAVING SUM(S.SALESAMOUNT) < 100.00;

SELECT
S.WEEK, COUNT(*)
FROM SALES1 S
GROUP BY S.WEEK;

SELECT * FROM SALES1;

SELECT
WEEK, COUNT(WEEK) AS 'NUM_SALES'
FROM SALES1
GROUP BY WEEK
ORDER BY WEEK;

SELECT 
    WEEK, DAY, COUNT(week) AS 'NUM_sales'
FROM
    SALES1
GROUP BY WEEK , Day
ORDER BY WEEK , DAY;

USE SHOP;

SELECT * FROM SALES1;

SELECT *
FROM SALES1 S
WHERE 
S.SALESPERSON = 'BILL' OR 'FRANK' AND
S.STORE = 'LONDON' AND
S.MONTH != 'DEC' AND
S.SALESAMOUNT > 50.00;

SELECT * FROM SALES1;

-- how many sales took place each week?
SELECT 
 S.WEEK, COUNT(*) AS 'SalesNumber'
FROM SALES1 S
GROUP BY S.WEEK
ORDER BY S.WEEK DESC;

-- how many sales were recorded each week on each day of the week?
SELECT 
S.WEEK, S.DAY, COUNT(*) AS 'SalesRecorded'
FROM SALES1 S
GROUP BY S.WEEK, S.DAY;

SELECT * FROM SALES1;

-- change name of salesperson
UPDATE SALES1 S
SET S.SALESPERSON = 'Annette'
WHERE S.SALESPERSON = 'Annette';

SELECT * FROM SALES1;

-- how many sales did annette do
SELECT
COUNT(*) AS 'SalesRecorded',
S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON
HAVING S.SALESPERSON = 'Annette';

SELECT * FROM SALES1;

-- find the total sales amount by each person by day
SELECT
S.DAY, SUM(S.SALESAMOUNT), S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON, S.DAY;

--  how much (sum) each person sold for the given period
SELECT
SUM(S.SALESAMOUNT), S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON;

/* How much (sum) each person sold for the given period, 
including the number of sales per person, their average, 
lowest and highest sale amounts */
SELECT
SUM(S.SALESAMOUNT), 
COUNT(*), 
AVG(S.SALESAMOUNT), 
MIN(S.SALESAMOUNT), 
MAX(S.SALESAMOUNT),
S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON;

-- Find the total monetary sales amount achieved by each store
SELECT * FROM SALES1;

SELECT
SUM(S.SALESAMOUNT), S.STORE
FROM SALES1 S
GROUP BY S.STORE;

/* Find the number of sales by each person if 
they did less than 3 sales for the past period */

SELECT
COUNT(*), S.SALESPERSON
FROM SALES1 S
GROUP BY S.SALESPERSON
HAVING COUNT(*) < 3;

SELECT * FROM SALES1;

/* Find the total amount of sales by month 
where combined total is less than £100 */
SELECT
SUM(S.SALESAMOUNT), S.MONTH
FROM SALES1 S
GROUP BY S.MONTH
HAVING SUM(S.SALESAMOUNT) < 100;

-- 09/08/2022

USE SHOP;

CREATE VIEW SALESPERSONAMOUNT
AS SELECT SALESPERSON, SALESAMOUNT
FROM SALES1;

SELECT * FROM SALESPERSONAMOUNT;