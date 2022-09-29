SELECT VARIABLE_VALUE INTO @baseline 
FROM performance_schema.global_status
	WHERE VARIABLE_NAME = 'INNODB_OS_LOG_WRITTEN';

SELECT SLEEP(60 * 60);

SELECT VARIABLE_VALUE INTO @afteronehour
 FROM performance_schema.global_status WHERE VARIABLE_NAME = 'INNODB_OS_LOG_WRITTEN';

SET @BytesWrittenToLog = @afteronehour - @baseline;

SELECT @BytesWrittenToLog / POWER(1024,2) AS MB_PER_HR;
