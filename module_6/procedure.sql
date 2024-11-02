USE bakery;

/* when writing statements you use ; to separate statements so mySQL processes
queries one by one separated by the ; but changing the delimiter temporarily
allows for the multiple statements inside the procedure to be passed all at once */

-- change delimiter temporarily to pass multiple statements within procedure 
DELIMITER //

 -- define procedure inputs
CREATE PROCEDURE greetings (
	GreetingWorld VARCHAR(100), -- procedure takes in two VARCHAR inputs to run
    FirstName VARCHAR(100)
)

-- define what procedure does
BEGIN 
	DECLARE FullGreeting VARCHAR(200);
    SET FullGreeting = CONCAT( GreetingWorld, ' ', FirstName, '!' );
    
    SELECT FullGreeting;
END //

-- change delimiter back to default
DELIMITER ;

-- call the stored procedure we just created
CALL greetings('Bonjour', 'Tricia');
CALL greetings('Hola', 'Dora');

DROP PROCEDURE InsertValue;

SELECT * FROM sweet;

-- change delimiter temporarily
DELIMITER $$

-- create stored procedure
CREATE PROCEDURE InsertValue ( -- using existing column names from table for inputs
	IN id INT, -- we are saying to insert these inputs into their respective columns
    IN SweetItem VARCHAR(100),
    IN price FLOAT
)
BEGIN -- define what procedure does
	INSERT INTO sweet(id, item_name, price) -- 
    VALUES (id, sweetItem, price);
    
END $$ -- same delimiter as the one we temporarily changed

-- change delimiter back to default
DELIMITER ;

CALL InsertValue (11, 'cherry_cake', 5);

SELECT * FROM sweet; -- should see new row at bottom

DROP PROCEDURE InsertValue;