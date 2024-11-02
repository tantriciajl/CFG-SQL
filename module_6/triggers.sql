/* write a trigger that activates before the INSERT statement on inserted values */

USE BAKERY;

SELECT * FROM bakery.sweet;

-- change delimiter temporarily
DELIMITER //

-- create trigger
CREATE TRIGGER SweetItem_Before_Insert
BEFORE INSERT ON sweet -- turn on trigger before new row insert into sweet table
FOR EACH ROW -- activate trigger before each new row
BEGIN
	SET NEW.item_name = CONCAT(UPPER(SUBSTRING(NEW.item_name,1,1)), -- NEW. indicates new of whatever column that follows
		-- SUBSTRING extracts first letter of new item_name
        -- UPPER capitalises first letter
        LOWER(SUBSTRING(NEW.item_name FROM 2)));
        -- SUBSTRING takes rest of letters in word
        -- and lowers it
        -- CONCAT wraps around entire variable and puts them together
        -- notice we didn't use @ because we are not setting a new variable
END//

-- change delimiter back
DELIMITER ;

-- test trigger by inserting new rows into table
INSERT INTO sweet (id, item_name, price)
VALUES (123, 'apple_pie', 1.2);

INSERT INTO sweet (id, item_name, price)
VALUES (456, 'caramel slice', 0.9);

INSERT INTO sweet (id, item_name, price)
VALUES (789, 'YUM YUM', 0.65);

SELECT *
FROM bakery.sweet;

/* write one function, one stored procedure, one trigger and one event 
for any of the DBs in our portfolio (trigger and event are optional). */
USE PIZZA;

SELECT * FROM orders;
SELECT * FROM customers;

/* create event to add a new row to orders table every 3 minutes */
SET GLOBAL event_scheduler = ON;

DELIMITER //

ALTER EVENT order_update
ON SCHEDULE EVERY 30 SECOND
STARTS NOW()
DO BEGIN
	INSERT INTO orders(orderdetails, customerid, orderid, orderdate, ordertime)
    VALUES (NULL, NULL, NULL, DATE(NOW), TIME(NOW()));
END//

CHANGE DELIMITER ;

/* create trigger to adjust format of info for every customer input */
DELIMITER //

CREATE TRIGGER new_customer
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
	SET NEW.FirstName = CONCAT( 
    UPPER(SUBSTRING( NEW.FirstName, 1, 1)),
	/* SET NEW.Firstname to set a new variable that is a new row of the FirstName column
    NEW.FirstName to indicate it's the new row insert that we want to edit
    
    (1,1) indicates it's the first character of the column FirstName

    SUBSTRING() function selects a subsection of the string in the chosen column and row
    NEW. to indicate the row about to be added
    FirstName to indicate the column
    
    UPPER() capitalises the first character (1,1) of the string
    
	CONCAT() wraps around the UPPER() and LOWER() string parts to combine them both together */
    LOWER(SUBSTRING(NEW.FirstName FROM 2))
    /* LOWER() lowercases all string characters positioned from 2 onwards 'FROM 2'
    
    SUBSTRING() function selects a subset of the string in the NEW row added to the FirstName column
    
    NEW.FirstName indicates to apply these changes to the newest row  addition to the FirstName column
    
	FROM 2 indicates to apply changes only to the string characters positioned in 2 and onwards */
    );
END//

DELIMITER ;

SELECT * FROM customers;

INSERT INTO customers
(FirstName, LastName, CustomerID, PhoneNumber, Email)
VALUES
('jodie', 'smith', 3, 222222222, 'jodiesmith@gmail.com');

UPDATE customers
SET LastName = 'Smith'
WHERE FirstName = 'jodie';

SELECT * FROM customers;
SELECT * FROM orders;

/* create procedure that quickly adds new row insert into orders to streamline orders row inserts */
DELIMITER //

CREATE PROCEDURE
	quickorder (
    OrderDetails VARCHAR(120),
    CustomerID INT,
    OrderID INT
    )
BEGIN
	INSERT INTO Orders(OrderDetails, CustomerID, OrderDate, OrderTime, OrderID)
    VALUES (OrderDetails, CustomerID, DATE(NOW()), TIME(NOW()), OrderID);
    
    SELECT * FROM orders;
END//

DELIMITER ;

CALL quickorder('cheese', 1, 104);

CREATE TABLE inventory(
item VARCHAR(120),
quantity INT
);

SELECT * FROM inventory;

INSERT INTO inventory(item, quantity)
VALUES
	('hawaiian', 40),
    ('pepperoni', 60),
    ('cheese', 120);
    
/* create function to check if we have enough stock of each pizza for the next day */
DELIMITER //

CREATE FUNCTION inventory_check(quantity INT)
	RETURNS VARCHAR(20)
    DETERMINISTIC
    
	BEGIN
		DECLARE inventory_status VARCHAR(20);
        IF (quantity > 100)
			THEN SET inventory_status = 'high';
		ELSEIF (quantity > 50 AND quantity < 100)
			THEN SET inventory_status = 'medium';
		ELSEIF (quantity <= 50)
			THEN SET inventory_status = 'low';
		END IF;
        
        RETURN CONCAT(inventory_status, ' stock');
	END//
    
DELIMITER ;

SELECT * FROM inventory;

SELECT
	item,
    inventory_check(quantity)
FROM
	inventory
WHERE item = 'hawaiian';
	