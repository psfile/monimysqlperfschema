SELECT 
	IF(ISNULL(performance_schema.threads.PROCESSLIST_ID),
		SUBSTRING_INDEX(performance_schema.threads.NAME,
				'/',
				-(1)),
		CONCAT(performance_schema.threads.PROCESSLIST_USER,
				'@',
				performance_schema.threads.PROCESSLIST_HOST)) AS user,
	SUM(performance_schema.events_waits_summary_by_thread_by_event_name.COUNT_STAR)/1000000 AS total_sec,
	SUM(performance_schema.events_waits_summary_by_thread_by_event_name.SUM_TIMER_WAIT)/1000000 AS total_latency_sec,
	MIN(performance_schema.events_waits_summary_by_thread_by_event_name.MIN_TIMER_WAIT)/1000000 AS min_latency_sec,
	AVG(performance_schema.events_waits_summary_by_thread_by_event_name.AVG_TIMER_WAIT)/1000000 AS avg_latency_sec,
	MAX(performance_schema.events_waits_summary_by_thread_by_event_name.MAX_TIMER_WAIT)/1000000 AS max_latency_sec
FROM
	(performance_schema.events_waits_summary_by_thread_by_event_name
	LEFT JOIN performance_schema.threads ON ((performance_schema.events_waits_summary_by_thread_by_event_name.THREAD_ID = performance_schema.threads.THREAD_ID)))
WHERE
	((performance_schema.events_waits_summary_by_thread_by_event_name.EVENT_NAME LIKE 'wait/io/file/%')
		AND (performance_schema.events_waits_summary_by_thread_by_event_name.SUM_TIMER_WAIT > 0))
GROUP BY user
ORDER BY SUM(performance_schema.events_waits_summary_by_thread_by_event_name.SUM_TIMER_WAIT) DESC;