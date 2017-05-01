SELECT 
	performance_schema.events_statements_summary_by_digest.DIGEST_TEXT AS query,
	IF(((performance_schema.events_statements_summary_by_digest.SUM_NO_GOOD_INDEX_USED > 0)
		OR (performance_schema.events_statements_summary_by_digest.SUM_NO_INDEX_USED > 0)),
	'Full Scan',
	'') AS full_scan,
	performance_schema.events_statements_summary_by_digest.COUNT_STAR AS exec_count,
	performance_schema.events_statements_summary_by_digest.SUM_TIMER_WAIT AS total_latency,
	performance_schema.events_statements_summary_by_digest.AVG_TIMER_WAIT AS avg_latency,
	performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES AS memory_tmp_tables,
	performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_DISK_TABLES AS disk_tmp_tables,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS avg_tmp_tables_per_query,
	ROUND((IFNULL((performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_DISK_TABLES / NULLIF(performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES,
							0)),
					0) * 100),
			0) AS tmp_tables_to_disk_pct,
	performance_schema.events_statements_summary_by_digest.LAST_SEEN AS last_seen
FROM
	performance_schema.events_statements_summary_by_digest
WHERE
	(performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES > 0)
ORDER BY performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_DISK_TABLES DESC, 
			performance_schema.events_statements_summary_by_digest.SUM_CREATED_TMP_TABLES DESC