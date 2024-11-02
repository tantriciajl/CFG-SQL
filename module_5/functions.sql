CREATE DATABASE BANK;

USE BANK;

/* create table of individual accounts */
CREATE TABLE ACCOUNTS
(AccountNumber INT NOT NULL, 
AccountFirstName VARCHAR(50) NOT NULL, 
AccountSurname VARCHAR(50) NOT NULL, 
Balance DECIMAL(2), 
OverdraftAllowed BOOLEAN);

ALTER TABLE ACCOUNTS
DROP COLUMN BALANCE;

ALTER TABLE ACCOUNTS
ADD Balance FLOAT;

SELECT * FROM ACCOUNTS;

/* insert data into table of individual accounts */
INSERT INTO ACCOUNTS
(AccountNumber, AccountFirstName, AccountSurname, 
Balance, OverdraftAllowed)
VALUES
(111112, 'Florence', 'Fairchild', 250.00, TRUE),
(111113, 'Aaliyah', 'Appleton', 100.00, FALSE),
(111114, 'Maxwell', 'McConnell', -50.00, TRUE),
(111115, 'Jayden', 'Jeffries', -150.00, FALSE);

SELECT * FROM ACCOUNTS;

/* start a transaction function which transfers £50
from one account to another */

-- 'start transaction' turns off autocommit
START TRANSACTION;

/* create function variable called @moneyAvailable
which prints balance or 'money' in the selected person's account
to assign something to this variable in mySQL we use :=
IF() returns balance if 'balance > 0' is TRUE
IF() returns 0 if 'balance > 0' is FALSE
to assign a column name to output we use AS MONEY */

-- check Florence's bank balance to see if she has enough money to transfer
-- hence the balance > 0
SELECT
	@moneyAvailable:= IF(balance > 0, balance, 0) AS MONEY
FROM bank.accounts -- select table from database to perform function
WHERE
	AccountNumber = 111112 AND -- select row from table
    AccountSurname = 'Fairchild';

/* set amount to be transferred */
SET @transferAmount = 50;

/* remove £50 from Florence's bank account specifically from the 'balance' column */
UPDATE ACCOUNTS
SET
	balance = balance - 50
WHERE
	AccountNumber = 111112 AND
    AccountSurname = 'Fairchild';

-- deposit £50 into another person's account specifically into the balance column */
UPDATE ACCOUNTS
SET
	balance = balance + @transferAmount
WHERE
	AccountNumber = 111115 AND
    AccountSurname = 'Jeffries';
    
SELECT * FROM ACCOUNTS;

-- revert results back to original table before transaction
ROLLBACK;

SELECT * FROM ACCOUNTS;

-- apply changes made during transaction to table
COMMIT;

/* steps to making a transaction is as follows

1. check balance of account to see if they have enough £ to transfer
2. remove money from one account - maybe set transferred amount as its own variable
3. deposit money into another account
4. end transaction either as COMMIT or ROLLBACK */

/* test built in convert function */
/* CONVERT() converts value or input into the specified datatype */
/* in this case we convert to DATE datatype */

SELECT CONVERT('2019-08-10 14:47:22', DATE) AS DATE1;
SELECT CONVERT('2019-08-10 14:47:88', DATE) AS DATE1; -- will not work because invalid time at 00:00:88

/* below shows all the possible date input syntaxes you can use
converted to the same DATE datatype and corresponding format using the CONVERT function */
SELECT CONVERT('10-08-19 14:47:22', DATE) AS DATE2,
CONVERT ('20190810', DATE) AS DATE3,
CONVERT ('100819', DATE) AS DATE4;

/* CONVERT() to change time to TIME datatype and its corresponding format */
/* also shows all the time syntaxes you can use */
SELECT CONVERT('14:47:22', TIME) AS TIME1, -- AS TIME1 to assign the column name
CONVERT('144722', TIME) AS TIME2;

/* you can look up all the possible datatypes that can be used with CONVERT() */
SELECT CONVERT('2019-08-10 14:47:22', DATETIME) AS DATEnTIME;

/* converts to decimal with 2 decimal points and 4 digits in total */
SELECT CONVERT('11.1', DECIMAL(4,2)) AS DEC1;

/* ADDDATE() and DATE_ADD() functions syntax which is the same functions */
SELECT ADDDATE('2020-06-15', INTERVAL 10 DAY) AS NEWDAY;
SELECT ADDDATE('20220814', 14) AS NEWDAY;

SELECT DATE_ADD('201130', INTERVAL 10 DAY);

/* SUBDATE() and DATE_SUB() to subtract from dates function */
SELECT SUBDATE('1950-01-23', INTERVAL 14 YEAR),
DATE_SUB('19780405', INTERVAL 2 MONTH);

/* function to return current date - all  syntaxes do the same thing */
-- useful for bookings, orders etc.
SELECT CURDATE(),
CURRENT_DATE(),
CURRENT_DATE;

/* return current time - all three syntaxes do the same thing */
-- useful for timestamps
SELECT CURRENT_TIME(),
CURRENT_TIME,
CURTIME(),
TIME(NOW());

/* return both the DATE and TIME - all three syntax do the same thing */
SELECT NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP();

/* return all the different individual parts of the time */
SELECT NOW(), -- date and time
DATE(NOW()), -- today's full date
TIME(NOW()), -- current time
YEAR(NOW()), -- current year
QUARTER(NOW()), -- current quarter into the year
MONTH(NOW()), -- number of month into the year
WEEK(NOW()), -- number of week into the year
DAY(NOW()), -- number of day into the month
DAYNAME(NOW()), -- mon, tue, wed, etc.
HOUR(NOW()), -- hour into the day i.e. out of 24 hrs
MINUTE(NOW()), -- minute into the hour i.e. out of 60 mins
SECOND(NOW()); -- second into the minute i.e. out of 60 s

/* convert input date to specific output format using DATE_FORMAT() */
SELECT DATE_FORMAT('2022-08-14 22:30:34', '%W %M %Y'),
DATE_FORMAT('2022-08-14 22:30:34', '%d %b %Y %T %f'),
DATE_FORMAT('2020-10-05 11:22:00', '%b %d %Y %h:%i %p');

/* create flow control functions */
-- using CASE for different scenarios functions
SET @var = -2;

SELECT
	CASE @var
		WHEN 1 THEN 'one'
        WHEN 2 THEN 'two'
        ELSE 'higher than 2'
	END AS TheNumberIs;

SET @var1 = 13;
SET @var2 = 14;

SELECT
	CASE
		WHEN (@var1 = 13 AND @var2 = 14) THEN 'one'
        WHEN @var2 = 14 THEN 'two'
		ELSE '2+'
        END AS TheNumberIs;
        
/* testing IF functions */

/* below statement returns '2' if the statement is TRUE adn returns '3' 
if statement is FALSE the statement being '1 > 2' which is FALSE */
SELECT IF(1 > 2, 2, 3);

-- is 1 less than two?
SELECT IF(1 < 2 , 'yes', 'no');

-- is the current year equal to 2020?
SELECT IF( YEAR(NOW() ) = 2020, 'YES', 'NO') AS 'RESULT';

/* testing IFNULL functions */
/* IFNULL(expression, alt_value) where 'expression' is the expression we are 
testing to see if it's null and alt_value is the value to put if it IS NULL */
SELECT IFNULL(1,0); -- returns one because expression is NOT NULL would return 0 if expression IS NULL

SELECT IFNULL(NULL, 0);

SELECT 1 / 0; -- interesting ...

SELECT IFNULL(1/0, 'YES');

/* testing NULLIF function */
/* returns NULL if both expressions are equal */
/* if not equal returns the first expression in writing */
SELECT NULLIF(1,1);
SELECT NULLIF(5,2);

/* testing numeric functions */
-- RAND() returns random floating-point value
SELECT RAND() AS RandomValue;

-- CEILING() returns smallest integer value greater than or equal to what is the brackets
-- or returns smallest integer value not less than the inside or bracket or not less than the 'argument'
-- CEILING() rounds UP to nearest integer (never rounds down)
-- LEFT(string, number_of_chars) extracts a number of characters from the string in this case 1 character from the string
SELECT LEFT(CEILING(RAND() * 888), 1) AS RANDOMVALUE;
SELECT CEILING(12.34), CEILING(-12.34);

-- ABS() returns absolute value
SELECT ABS(-5), ABS(5);

-- DEGREES() converts radians to degrees
SELECT DEGREES(PI());
SELECT DEGREES( PI() / 2 );

-- FLOOR() rounds DOWN to nearest integer (always rounds down nevers rounds up)
SELECT FLOOR(12.34), FLOOR(-12.34);

-- returns PI() to return value of pi
SELECT PI();
SELECT PI() + 0.000000000000000000000000000000; -- this is a method to show numbers with lots of decimals

-- POW(X,Y) or POWER(X,Y) returns X argument raised to a specific power Y
SELECT POW(3,2);
SELECT POWER(8,-1);

-- SQRT() returns square root of argument
SELECT SQRT(4);
SELECT SQRT(16);
SELECT SQRT(256);

-- example of functions using bakery database
USE BAKERY;

/* shows all the different types of functions and how it can be used for the bakery database */
SELECT price,
	ROUND(price) AS price, -- round prices  to nearest integer 
    price - 0.10, -- deduct from original prices
    CAST(price - 0.10 AS DECIMAL(3,2)), -- convert original price to decimals with two d.p.
    -- CAST() is another way of converting datatypes
    ROUND(price - 0.10, 2) -- round price to two d.p.
    -- ROUND(number, decimals) rounds number to how ever many decimal places
FROM bakery.sweet;

-- LENGTH() returns length of string in bytes
-- CHAR_LENGTH() returns length of string in characters
SELECT LENGTH('Tricia Tan');
SELECT CHAR_LENGTH('Tricia Tan');

-- CONCAT() returns concantenated string i.e. joins string together 
-- no spaces unless you add spaces
SELECT CONCAT('Code ', 'First', ' Girls') AS 'Concatenated result';

-- LCASE() or LOWER() return arguments or inputs in lowercase
SELECT LCASE('STOP!'), LOWER('STOP IT');

-- UCASE() or UPPER() returns argument or input in uppercase
SELECT UCASE('go away!'), UPPER('go away!');

-- LEFT(text, number ) returns left side 'number' of specified characters
SELECT LEFT('Tricia Tan', 3);

-- RIGHT(text, number) returns right side 'number of specified characters
SELECT RIGHT('Tricia Tan', 3);

-- RTRIM() remmoves trailing blank spaces (at the end)
SELECT '         Tricia Tan          ',
	LENGTH('         Tricia Tan          '),
    RTRIM('         Tricia Tan          '),
	LENGTH(RTRIM('         Tricia Tan          '));

-- LTRIM() removes leading blank spaces (at start)
SELECT '         Tricia Tan          ',
	LENGTH('         Tricia Tan          '),
    LTRIM('         Tricia Tan          '),
	LENGTH(LTRIM('         Tricia Tan          '));

-- TRIM() removes leading and trailing spaces
SELECT TRIM('         Tricia Tan          '),
	LENGTH(TRIM('         Tricia Tan          '));

/* STRCMP() returns 0 if strings are same length
returns -1 if first argument is smaller than second argument
returns 1 if first argument is larger than second argument */
SELECT STRCMP('Tan', 'Tricia'),
	STRCMP('tricia', 'tricia'),
    STRCMP('tricia', 'tan');
    
-- REVERSE() reverses characters in a string
SELECT REVERSE('Tricia Tan');

-- practice these functions on a real table
USE BANK;

SELECT * FROM ACCOUNTS;

SELECT
	CONCAT(AccountFirstName, ' ', AccountSurname) AS FullName,
    REVERSE(CONCAT(AccountFirstName, ' ', AccountSurname)) AS ReverseFullName
FROM Aaccounts;