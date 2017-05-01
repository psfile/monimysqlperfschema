-- Select Instruments
SELECT * 
FROM performance_schema.setup_instruments;
-- Select Consumers
SELECT * 
FROM performance_schema.setup_consumers;

-- Setup Instruments
SELECT * 
FROM performance_schema.setup_instruments 
WHERE NAME LIKE 'statement/%' ;

UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE 'statement/%';

-- Set up Consumers 
SELECT * 
FROM performance_schema.setup_consumers 
WHERE NAME LIKE '%events%';

UPDATE performance_schema.setup_consumers 
SET ENABLED = 'YES'
WHERE NAME LIKE '%events%';


