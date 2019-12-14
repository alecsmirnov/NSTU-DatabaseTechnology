#ifndef SQLPATTERNS_H
#define SQLPATTERNS_H

#include <stdlib.h>
#include <string.h>

#define QUERY_QUOTE(...) #__VA_ARGS__

const char* CLEAR_TABLE_PATTERN = QUERY_QUOTE(
	TRUNCATE %1$s
);

const char* CLEAR_SEQUENCE_PATTERN = QUERY_QUOTE(
	ALTER SEQUENCE %1$s_n_seq RESTART WITH 1
);


// Шаблоны динамических запросов 
const char* DB_INSERT_PATTERN = QUERY_QUOTE(
	INSERT INTO %1$s(n, name, operation, operation_date)
	VALUES (default, ?, ?, DATE_TRUNC('second', NOW()))
);

const char* DB_UPDATE_PATTERN = QUERY_QUOTE(
	UPDATE %1$s
    SET name = ?, operation = ?, operation_date = DATE_TRUNC('second', NOW())
    WHERE n = (SELECT n
    	       FROM %1$s
    	       ORDER BY n
    	       LIMIT 1)
);

const char* DB_DELETE_PATTERN = QUERY_QUOTE(
	DELETE FROM %1$s
	WHERE n = (SELECT n
			   FROM %1$s
               ORDER BY n DESC
               LIMIT 1)
);

/*
const char* DB_TABLE_COPY_PATTERN = QUERY_QUOTE(
	INSERT INTO %2$s
	SELECT * FROM %1$s
);
*/

const char* LOG_INSERT_PATTERN = QUERY_QUOTE(
	INSERT INTO log(db_name, db_priority, operation, operation_date, n_data, old_data, new_data)
	SELECT '%1$s', %2$d, '%3$s', DATE_TRUNC('second', NOW()), n, %4$s, '%5$s'
	FROM %1$s
	WHERE n = %6$s
);

// Условия для записи в журнал
const char* LOG_INSERT_CONDITION = QUERY_QUOTE(
	LASTVAL()
);

const char* LOG_UPDATE_CONDITION = QUERY_QUOTE(
	(SELECT n
     FROM %1$s
     ORDER BY n
     LIMIT 1)
);

const char* LOG_DELETE_CONDITION = QUERY_QUOTE(
	(SELECT n
	 FROM %1$s
	 ORDER BY n DESC
	 LIMIT 1)
);

#endif