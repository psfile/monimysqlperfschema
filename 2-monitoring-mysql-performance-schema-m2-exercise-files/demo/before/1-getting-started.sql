SELECT VERSION();

SHOW VARIABLES LIKE 'performance_schema';

SELECT * 
FROM INFORMATION_SCHEMA.ENGINES
	WHERE ENGINE='PERFORMANCE_SCHEMA';

SHOW TABLES FROM performance_schema;    

USE performance_schema;

SELECT * 
FROM setup_timers;


-- Find Query with High Execution Time
SELECT DIGEST_TEXT AS query,
       COUNT_STAR AS exec_count,
       SEC_TO_TIME(SUM_TIMER_WAIT/1000000000000) AS exec_time_total,
       SEC_TO_TIME(MAX_TIMER_WAIT/1000000000000) AS exec_time_max,
       (AVG_TIMER_WAIT/1000000000) AS exec_time_avg_ms,
       SUM_ROWS_SENT AS rows_sent,
       SUM_ROWS_EXAMINED AS rows_scanned
  FROM performance_schema.events_statements_summary_by_digest
ORDER BY SUM_TIMER_WAIT DESC