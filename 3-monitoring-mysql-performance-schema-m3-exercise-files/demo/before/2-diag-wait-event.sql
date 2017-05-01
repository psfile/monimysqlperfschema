-- Sample Query
-- Step 1 - Run Use Case
SELECT *
FROM sakila.actor;

-- Step 2 – Analyze the Root Cause
-- Show current user and connection
SELECT CURRENT_USER(), CONNECTION_ID();

-- Step 3 - Rule Out Benign Issues
-- Show all the processes
SHOW FULL PROCESSLIST;

-- Step 4 - Isolate Malign Issues
-- Show all thread_id of current connection
SELECT THREAD_ID, PROCESSLIST_ID
FROM performance_schema.threads 
WHERE PROCESSLIST_ID = CONNECTION_ID();

-- Select all the waits for current events
SELECT *
FROM performance_schema.events_waits_current;

-- Select only the event waits for current threads 
SELECT *
FROM performance_schema.events_waits_current e
INNER JOIN performance_schema.threads t ON e.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID();

-- Select only the event waits for current threads 
SELECT EVENT_NAME, 
		(TIMER_END-TIMER_START)/1000000000 as 'DURATION (ms)',
        OBJECT_NAME, OBJECT_TYPE, INDEX_NAME, OPERATION
FROM performance_schema.events_waits_current e
INNER JOIN performance_schema.threads t ON e.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID();

-- Turn off the logging
-- Step 5 – Take Appropriate Corrective Actions 
SET GLOBAL general_log = 'OFF';

-- Step 6 - Repeat the process
-- Go to Step 1

