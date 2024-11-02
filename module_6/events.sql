/* write a one off event and recurring event that log timestamp values in a table 
(similar to a scheduler) */

SET GLOBAL event_scheduler = ON; 	-- sets the event_scheduler to run dynamically at runtime

									-- resets event next time server restarts
                                    -- event_scheduler is an existing variable of the global variable type

/* create a one-time event */
CREATE DATABASE events; -- create database

CREATE TABLE event_monitor -- create table
(
ID 		INT 		NOT NULL 	AUTO_INCREMENT,
last_update	TIMESTAMP,

PRIMARY KEY (ID) -- set ID as primary key
);

-- create event
DELIMITER // -- temporarily change delimiter
CREATE EVENT one_time_event
ON SCHEDULE AT NOW() + INTERVAL 1 MINUTE -- scheduled event to happen one minute from when this is created
DO BEGIN
	INSERT INTO event_monitor(last_update) -- adds one (1) new time row to last_update table
    VALUES (NOW());
END//
DELIMITER ; -- change delimiter back to default

USE events;
SELECT * FROM event_monitor; -- should see one (1) after a minute where new time is added

/* create a reccuring event every 30 seconds */
CREATE TABLE event_monitor2
(
ID			INT			NOT NULL	AUTO_INCREMENT,
last_update	TIMESTAMP,

PRIMARY KEY (ID)
);

DELIMITER // -- need gap after setting delimiter

CREATE EVENT reocurring_event
ON SCHEDULE EVERY 30 SECOND
STARTS NOW()
DO BEGIN -- to indicate when event details/procedure starts
	INSERT INTO event_monitor2(last_update)
    VALUES(NOW());
END//

CHANGE DELIMITER ;

SELECT * FROM event_monitor2
ORDER BY ID DESC;

DROP TABLE event_monitor2;
DROP EVENT reocurring_event;
DROP DATABASE events;