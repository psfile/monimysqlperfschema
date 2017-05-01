SELECT 
	performance_schema.file_summary_by_instance.FILE_NAME AS file,
	performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_READ/1000000 AS total_read_mb,
	performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_WRITE/1000000 AS total_written_mb,
	(performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_READ + performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_WRITE)/1000000 AS total_mb,
	IFNULL(ROUND((100 - ((performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_READ / NULLIF((performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_READ + performance_schema.file_summary_by_instance.SUM_NUMBER_OF_BYTES_WRITE),
							0)) * 100)),
					2),
			0.00) AS write_pct
FROM
	performance_schema.file_summary_by_instance
ORDER BY write_pct DESC