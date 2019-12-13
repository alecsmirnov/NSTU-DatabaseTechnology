#ifndef SQLFUNCTION_H
#define SQLDUNCTION_H

#include "sqlPatterns.h"

#include <stdbool.h>

#define TABLE_LIST_SIZE 4

// Перечень таблиц и приоритетов в схеме репликаций 
const char* table_list[TABLE_LIST_SIZE]    = {"product_cdb", "product_pdb1", "product_pdb2", "product_pdb3"};
const int   priority_list[TABLE_LIST_SIZE] = {0, 1, 2, 3};

static inline int getPriority(const char* table_name) {
	int priority = priority_list[0];

	int i = 1;
	bool found = false;
	for (; i != TABLE_LIST_SIZE && !found; ++i)
		if (strcmp(table_name, table_list[i]) == 0) {
			priority = priority_list[i];

			found = true;
		}

	return priority;
}

// Вставка данных для таблиц product_pdbi, product_cdb
void dbTableInsert(const char* table_name, const char* name, const char* operation) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	const char* sql_name = name;
	const char* sql_operation = operation;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (strlen(table_name) + strlen(DB_INSERT_PATTERN) + 1));
	sprintf(sql_text, DB_INSERT_PATTERN, table_name);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query USING :sql_name, :sql_operation;
	errorHandle("insert data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

// Обновление данных для таблиц product_pdbi, product_cdb
void dbTableUpdate(const char* table_name, const char* name, const char* operation) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	const char* sql_name = name;
	const char* sql_operation = operation;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (2 * strlen(table_name) + strlen(DB_UPDATE_PATTERN) + 1));
	sprintf(sql_text, DB_UPDATE_PATTERN, table_name, table_name);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query USING :sql_name, :sql_operation;
	errorHandle("update data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

// Удаление данных для таблиц product_pdbi, product_cdb
void dbTableDelete(const char* table_name) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (2 * strlen(table_name) + strlen(DB_DELETE_PATTERN) + 1));
	sprintf(sql_text, DB_DELETE_PATTERN, table_name, table_name);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query;
	errorHandle("delete data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

// Вставка данныех в журнал
void logTableInsert(const char* table_name, int db_priority, const char* operation, const char* n_condition, const char* old_data, const char* new_data) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (strlen(table_name) + 3 + strlen(operation) + strlen(n_condition)  + strlen(old_data) + 
											 strlen(new_data) + strlen(LOG_INSERT_PATTERN) + 1));
	sprintf(sql_text, LOG_INSERT_PATTERN, table_name, db_priority, operation, old_data, new_data, table_name, n_condition);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query;
	errorHandle("insert log data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

// Вставка данных с записью в журнал
static inline void dbTableInsertLog(const char* table_name, const char* name, const char* operation) {
	dbTableInsert(table_name, name, operation);
	logTableInsert(table_name, getPriority(table_name), operation, LOG_INSERT_CONDITION, "''", name);
}

// Обновление данных с записью в журнал
static inline void dbTableUpdateLog(const char* table_name, const char* name, const char* operation) {
	char* log_condition = (char*)malloc(sizeof(char) * (strlen(LOG_UPDATE_CONDITION) + strlen(table_name) + 1));
	sprintf(log_condition, LOG_UPDATE_CONDITION, table_name);

	logTableInsert(table_name, getPriority(table_name), operation, log_condition, "name", name);
	dbTableUpdate(table_name, name, operation);

	free(log_condition);
}

// Удаление данных с записью в журнал
static inline void dbTableDeleteLog(const char* table_name, const char* operation) {
	char* log_condition = (char*)malloc(sizeof(char) * (strlen(LOG_DELETE_CONDITION) + strlen(table_name) + 1));
	sprintf(log_condition, LOG_DELETE_CONDITION, table_name);

	logTableInsert(table_name, getPriority(table_name), operation, log_condition, "name", "");
	dbTableDelete(table_name);

	free(log_condition);
}

#endif