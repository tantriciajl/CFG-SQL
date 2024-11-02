CREATE DATABASE fruit;

USE fruit;

-- create table 1
CREATE TABLE FruitBasket1
(ID INT,
fruit VARCHAR(50));

-- insert values into table 1
INSERT INTO FRUITBASKET1
(ID, fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'strawberry'),
(4, 'blueberry'),
(5, 'banana');

-- create table 2
CREATE TABLE FRUITBASKET2
(ID INT,
FRUIT VARCHAR(50));

-- insert values into table 2
INSERT INTO FRUITBASKET2
(ID, fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'strawberry'),
(6, 'melon'),
(7, 'peach'),
(8, 'plum');

-- see all values from table 1 and table 2
SELECT *
FROM FruitBasket1;

SELECT * 
FROM FRUITBASKET2;

/* creating the inner join returns ONLY MATCHING columns 
between table 1 and table 2 in the results table in this 
case only the rows where the ID column matches will display */

-- create inner join between table 1 and table 2
SELECT t1.*, t2.*
FROM fruitbasket1 t1
	INNER JOIN
    fruitbasket2 t2
	ON
    t1.id = t2.id;  

-- create inner join between table 1 and table 2 with distinct columns
SELECT 
	t1.ID AS T1_ID,
	t1.fruit AS T1_FRUIT,
    T2.ID AS T2_ID,
    T2.FRUIT AS T2_FRUIT
FROM
	FRUITBASKET1 T1
    INNER JOIN
    FRUITBASKET2 T2
    ON
    T1.ID = T2.ID;

/* creating a left join prints MATCHING AND ALSO
EVERY table 1 value between table 1 and table 2 */

-- create left join between table 1 and table 2
SELECT T1.*, T2.*
FROM
	FRUITBASKET1 T1
    LEFT JOIN
    FRUITBASKET2 T2
    ON
    T1.ID = T2.ID;

/* creating right join displays MATCHING AND ALSO
EVERY table 2 value between table 1 and table 2 */

-- create right join between table 1 and table 2
SELECT T1.*, T2.*
FROM
	FRUITBASKET1 T1
    RIGHT JOIN
    FRUITBASKET2 T2
    ON
    T1.ID = T2.ID; -- where IDs match between the two tables

/* creating full outer joins or full joins 
returns a table with EVERY table 1 AND table 
2 value and also alll the MATCHING values */

-- create outer join between table 1 and table 2

-- the below creates ERROR because FULL OUTER JOIN isn't a thing
/* SELECT T1.*, T2.*
FROM
	FRUITBASKET1 T1
    FULL OUTER JOIN
    FRUITBASKET2 T2
    ON
    T1.ID = T2.ID; */

-- but we can instead emulate a FULL OUTER JOIN using UNION
SELECT *
FROM FRUITBASKET1 T1
	LEFT JOIN
    FRUITBASKET2 T2
    ON
    T1.ID = T2.ID
    WHERE 
    T2.ID IS NULL; -- select only where there is no matching

-- create cross join between table 1 and table 2
SELECT T1.*, T2.*
FROM
	FRUITBASKET1 T1
    CROSS JOIN
    FRUITBASKET2 T2;

-- create union all on fruit table 1 and fruit table 2

/* literally just allows you to combine two 
queries or two datasets from two tables 
into one union all includes duplicate rows */

SELECT T1.ID T1_ID, T1.FRUIT T1_FRUIT
FROM FRUITBASKET1 T1
	UNION ALL
SELECT T2.ID AS T2_ID, T2.FRUIT T2_FRUIT
FROM FRUITBASKET2 T2;

-- create union on fruit table 1 and fruit table 2

/* combines all data from fruit table 1 
and fruit table 2 and keeps duplicate rows */

SELECT T2.ID T2_ID, T2.FRUIT T2_FRUIT
FROM FRUITBASKET2 T2
	UNION ALL
SELECT T1.ID T1_ID, T1.FRUIT T1_FRUIT
FROM FRUITBASKET1 T1;

-- clean up table using the following
/* DROP TABLE FRUITBASKET1;
DROP TABLE FRUITBASKET2; */