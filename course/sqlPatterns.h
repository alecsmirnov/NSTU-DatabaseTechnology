#ifndef SQLPATTERNS_H
#define SQLPATTERNS_H

#include <stdlib.h>
#include <string.h>

#define QUERY_QUOTE(...) #__VA_ARGS__

// Шаблоны динамических запросов 
const char* DB_INSERT_PATTERN = QUERY_QUOTE(
	INSERT INTO %s(n, name, operation, operation_date)
	VALUES (default, ?, ?, DATE_TRUNC('second', NOW()))
);

const char* DB_UPDATE_PATTERN = QUERY_QUOTE(
	UPDATE %s
    SET name = ?, operation = ?, operation_date = DATE_TRUNC('second', NOW())
    WHERE n = (SELECT n
    	       FROM %s
    	       ORDER BY n
    	       LIMIT 1)
);

const char* DB_DELETE_PATTERN = QUERY_QUOTE(
	DELETE FROM %s
	WHERE n = (SELECT n
			   FROM %s
               ORDER BY n DESC
               LIMIT 1)
);

const char* LOG_INSERT_PATTERN = QUERY_QUOTE(
	INSERT INTO log(db_name, db_priority, operation, operation_date, n_data, old_data, new_data)
	SELECT '%s', %d, '%s', operation_date, n, %s, '%s'
	FROM %s
	WHERE n = %s
);

// Условия для записи в журнал
const char* LOG_INSERT_CONDITION = QUERY_QUOTE(
	LASTVAL()
);

const char* LOG_UPDATE_CONDITION = QUERY_QUOTE(
	(SELECT n
     FROM %s
     ORDER BY n
     LIMIT 1)
);

const char* LOG_DELETE_CONDITION = QUERY_QUOTE(
	(SELECT n
	 FROM %s
	 ORDER BY n DESC
	 LIMIT 1)
);

#endif