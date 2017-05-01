SELECT
	performance_schema.events_statements_summary_by_digest.DIGEST_TEXT AS query,
	IF(((performance_schema.events_statements_summary_by_digest.SUM_NO_GOOD_INDEX_USED > 0)
			OR (performance_schema.events_statements_summary_by_digest.SUM_NO_INDEX_USED > 0)),
		'Full Scan',
		'') AS full_scan,
	performance_schema.events_statements_summary_by_digest.COUNT_STAR AS exec_count,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_ROWS_SENT / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS rows_sent_avg,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_ROWS_EXAMINED / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS rows_examined_avg,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_ROWS_AFFECTED / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS rows_affected_avg,
	performance_schema.events_statements_summary_by_digest.SUM_TIMER_WAIT AS total_latency,
    performance_schema.events_statements_summary_by_digest.MAX_TIMER_WAIT AS max_latency,
    performance_schema.events_statements_summary_by_digest.AVG_TIMER_WAIT AS avg_latency,
	performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES AS tmp_tables,
	performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_DISK_TABLES AS tmp_disk_tables,
	performance_schema.events_statements_summary_by_digest.SUM_SORT_ROWS AS rows_sorted,
	performance_schema.events_statements_summary_by_digest.LAST_SEEN AS last_seen
FROM
	performance_schema.events_statements_summary_by_digest
ORDER BY MAX_TIMER_WAIT DESC