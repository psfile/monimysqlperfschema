-- Run Various SQL Queries
SELECT *
FROM sakila.actor;

SELECT *
FROM sakila.actor
WHERE actor_id = 5;

EXPLAIN SELECT *
FROM sakila.actor
WHERE actor_id = 5;

SELECT *
FROM sakila.actor
WHERE first_name = 'JOHNNY';

EXPLAIN SELECT *
FROM sakila.actor
WHERE first_name = 'JOHNNY';

SELECT *
FROM sakila.actor
WHERE last_name = 'CAGE';

EXPLAIN SELECT *
FROM sakila.actor
WHERE last_name = 'CAGE';

-- Diagnosis
-- Select only the event waits for current threads 
SELECT *
FROM performance_schema.events_waits_current e
INNER JOIN performance_schema.threads t ON e.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID();

-- Select recent HISTORICAL wait events for the current threads 
SELECT *
FROM performance_schema.events_waits_history eh
INNER JOIN performance_schema.threads t ON eh.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID();

-- Select ALL HISTORICAL wait events for the current threads 
SELECT *
FROM performance_schema.events_waits_history_long ehl
INNER JOIN performance_schema.threads t ON ehl.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID()
ORDER BY END_EVENT_ID DESC;


-- Select ALL HISTORICAL event statement for the current threads
SELECT *
FROM performance_schema.events_statements_history_long esl
INNER JOIN performance_schema.threads t ON esl.THREAD_ID = t.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID() 
ORDER BY END_EVENT_ID DESC;

-- Run test case again 
SELECT *
FROM sakila.actor
WHERE first_name = 'REESE';

SELECT *
FROM sakila.actor
WHERE last_name = 'WEST';

-- Select ALL HISTORICAL wait events for the current threads
SELECT  DISTINCT esl.EVENT_NAME, (esl.TIMER_END-esl.TIMER_START)/1000000000 as 'DURATION (ms)',
		esl.SQL_Text, esl.ROWS_EXAMINED, esl.ROWS_AFFECTED, esl.ROWS_SENT,
        esl.NO_INDEX_USED, esl.SELECT_SCAN 
FROM performance_schema.events_statements_history_long esl
INNER JOIN performance_schema.threads t ON esl.THREAD_ID = t.THREAD_ID
INNER JOIN performance_schema.events_waits_history_long ehl ON ehl.THREAD_ID = esl.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID()  
 and esl.EVENT_NAME = 'statement/sql/select'
ORDER BY esl.TIMER_END DESC;

-- Create Index
CREATE INDEX idx_actor_first_name ON sakila.actor (first_name(45));

-- Run test case again 
SELECT *
FROM sakila.actor
WHERE first_name = 'REESE';

SELECT *
FROM sakila.actor
WHERE last_name = 'WEST';

-- Select ALL HISTORICAL wait events for the current threads
SELECT  DISTINCT esl.EVENT_NAME, (esl.TIMER_END-esl.TIMER_START)/1000000000 as 'DURATION (ms)',
		esl.SQL_Text, esl.ROWS_EXAMINED, esl.ROWS_AFFECTED, esl.ROWS_SENT,
        esl.NO_INDEX_USED, esl.SELECT_SCAN 
FROM performance_schema.events_statements_history_long esl
INNER JOIN performance_schema.threads t ON esl.THREAD_ID = t.THREAD_ID
INNER JOIN performance_schema.events_waits_history_long ehl ON ehl.THREAD_ID = esl.THREAD_ID
WHERE PROCESSLIST_ID = CONNECTION_ID()  
 and esl.EVENT_NAME = 'statement/sql/select'
ORDER BY esl.TIMER_END DESC;

-- Clean up
DROP INDEX idx_actor_first_name ON sakila.actor;

















