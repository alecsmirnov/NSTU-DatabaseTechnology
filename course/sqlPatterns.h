#ifndef SQLPATTERNS_H
#define SQLPATTERNS_H

#include <stdlib.h>
#include <string.h>

#define QUERY_QUOTE(...) #__VA_ARGS__

enum OPERATION_NUM {
	INSERT_OPERATION_NUM,
	UPDATE_OPERATION_NUM,
	DELETE_OPERATION_NUM
};

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
	INSERT INTO log(db_name, db_priority, n_data, operation, operation_date, old_data, new_data)
	SELECT '%s', %d, n, '%s', operation_date, %s, '%s'
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

// Получить условие для журнала по таблице
char* makeLogCondition(int operation_num, const char* table_name) {
	char* log_condition = NULL;

	switch (operation_num) {
		case INSERT_OPERATION_NUM: {
			log_condition = (char*)malloc(sizeof(char) * (strlen(LOG_INSERT_CONDITION) + strlen(table_name) + 1));
			strcpy(log_condition, LOG_INSERT_CONDITION);

			break;
		} 
		case UPDATE_OPERATION_NUM: {
			log_condition = (char*)malloc(sizeof(char) * (strlen(LOG_UPDATE_CONDITION) + strlen(table_name) + 1));
			sprintf(log_condition, LOG_UPDATE_CONDITION, table_name);

			break;
		}
		case DELETE_OPERATION_NUM: {
			log_condition = (char*)malloc(sizeof(char) * (strlen(LOG_DELETE_CONDITION) + strlen(table_name) + 1));
			sprintf(log_condition, LOG_DELETE_CONDITION, table_name);

			break;
		}
	}

	return log_condition;
}

#endif