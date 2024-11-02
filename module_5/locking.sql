CREATE DATABASE locking;

USE locking;

/* create sample table to be locked */
CREATE TABLE ChatLogs (
	id 			INT 			NOT NULL 	AUTO_INCREMENT, -- AUTO INCREMENT does +1 to id when new row is added
	message 	VARCHAR(150) 	NOT NULL,
    author 		VARCHAR(25) 	NOT NULL,
    
    PRIMARY KEY (id)
);

/* add values to the table */
INSERT INTO 
	ChatLogs (message, author)
VALUES
	('hi everyone!', 'hobi');

SELECT * FROM CHATLOGS;

/* apply read lock to table */
LOCK TABLE chatlogs READ;

/* try inserting values into table *should fail* */
INSERT INTO chatlogs (message, author)
VALUES ('bye guys!', 'hobi'); -- returns read lock error message

/* drop all locks on all tables */
UNLOCK TABLES;

/* try inserting values into table *should work* */
INSERT INTO chatlogs (message, author)
VALUES ('bye guys!', 'hobi');

SELECT * FROM CHATLOGS;

/* note inserting message into chatlogs table from 
different session results in input being suspended 
and put into queue until lock is dropped */

/* apply write lock onto table */
LOCK TABLE chatlogs WRITE;

/* insert messages into chat logs *should work* */
INSERT INTO chatlogs(message, author)
VALUES ('This server has been suspended.', 'MOD');

SELECT * FROM CHATLOGS;

UNLOCK TABLES;

/* purpose of locking is so you can do your 
little updates without new data being added */

/* 
you can READ lock one table e.g. parent table, 
and WRITE lock another at the same time by doing

LOCK TABLES tables_name READ,
			table_name WRITE;					
*/

DROP DATABASE employee;