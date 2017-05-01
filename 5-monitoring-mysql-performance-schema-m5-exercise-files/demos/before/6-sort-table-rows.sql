SELECT 
	performance_schema.events_statements_summary_by_digest.DIGEST_TEXT AS query,
	performance_schema.events_statements_summary_by_digest.COUNT_STAR AS exec_count,
	performance_schema.events_statements_summary_by_digest.SUM_TIMER_WAIT AS total_latency,
    performance_schema.events_statements_summary_by_digest.AVG_TIMER_WAIT AS avg_latency,
	performance_schema.events_statements_summary_by_digest.SUM_SORT_MERGE_PASSES AS sort_merge_passes,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_SORT_MERGE_PASSES / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS avg_sort_merges,
	performance_schema.events_statements_summary_by_digest.SUM_SORT_SCAN AS sorts_using_scans,
	performance_schema.events_statements_summary_by_digest.SUM_SORT_RANGE AS sort_using_range,
	performance_schema.events_statements_summary_by_digest.SUM_SORT_ROWS AS rows_sorted,
	ROUND(IFNULL((performance_schema.events_statements_summary_by_digest.SUM_SORT_ROWS / NULLIF(performance_schema.events_statements_summary_by_digest.COUNT_STAR,
							0)),
					0),
			0) AS avg_rows_sorted,
	performance_schema.events_statements_summary_by_digest.LAST_SEEN AS last_seen
FROM
	performance_schema.events_statements_summary_by_digest
WHERE
	(performance_schema.events_statements_summary_by_digest.SUM_SORT_ROWS > 0)
ORDER BY performance_schema.events_statements_summary_by_digest.SUM_SORT_ROWS DESC