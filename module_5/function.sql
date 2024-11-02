/*  in the bank DB write a stored function that accepts customer account’s 
balance as a parameter and is assessing whether he/she is eligible for a credit */

USE BANK;

-- set temporary delimiter
DELIMITER //

-- create function
CREATE FUNCTION
	is_eligible (balance INT) -- function name and required inputs
RETURNS 
	VARCHAR(20) -- datatype of what the function returns
DETERMINISTIC -- makes sure to return same result for same input parameters

BEGIN
	DECLARE CustomerStatus VARCHAR(20); -- declare variable name and data type
    IF balance > 100 THEN
		SET CustomerStatus = 'YES';
	ELSEIF (balance >=50 AND balance <= 100) THEN
		SET CustomerStatus = 'MAYBE';
	ELSEIF balance < 50 THEN
		SET CustomerStatus = 'NO';
	END IF; -- no more if statements to read

	RETURN (CustomerStatus);
END //

-- change delimiter back to default
DELIMITER ;

SELECT * FROM ACCOUNTS;

SELECT
	accountfirstname,
    accountsurname,
    balance,
    is_eligible(balance)
FROM
	accounts;