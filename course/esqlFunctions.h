#ifndef ESQLFUNCTIONS_H
#define ESQLFUNCTIONS_H

#include <stdlib.h>
#include <string.h>

EXEC SQL DEFINE SERVER "students@fpm2.ami.nstu.ru";

#define TABLE_LIST_SIZE 4

// Перечень таблиц в схеме репликаций 
const char* table_list[TABLE_LIST_SIZE] = {"product_cdb", 
										   "product_pdb1", 
										   "product_pdb2", 
										   "product_pdb3"};

// Шаблоны динамических запросов 
const char* db_insert_pattern  = "INSERT INTO %s(n, name, operation, operation_date) \
                            	  VALUES (default, ?, ?, DATE_TRUNC('second', NOW()))";

const char* log_insert_pattern = "INSERT INTO log(db_name, db_priority, n_data, operation, operation_date, old_data, new_data) \
								  SELECT '%s', %d, n, operation, operation_date, '%s', '%s' \
								  FROM %s \
								  WHERE n = %s";

// Отлов ошибок и вывода информации на экран
static inline void errorHandle(const char* error_name) {
	if (sqlca.sqlcode != ECPG_NO_ERROR && sqlca.sqlcode != ECPG_NOT_FOUND) {
		fprintf(stderr, "Error: %s\n", error_name);
		fprintf(stderr, "Code %d: %s\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
		
		EXEC SQL ROLLBACK WORK;

		exit(EXIT_FAILURE);
	}
}

// Копирование строки в динамическую строку
static inline char* dynamicStrCpy(char* str) {
	char* new_str = (char*)malloc(sizeof(char) * strlen(str) + 1);
	strcpy(new_str, str);

	return new_str;
}


// Вставка данных для таблиц product_pdbi, product_cdb
void dbTableInsert(const char* table_name, const char* name, const char* operation) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	const char* sql_name = name;
	const char* sql_operation = operation;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (strlen(table_name) + strlen(db_insert_pattern)));
	sprintf(sql_text, db_insert_pattern, table_name);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query USING :sql_name, :sql_operation;
	errorHandle("insert data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

void logTableInsert(const char* table_name, int db_priority, const char* n_data, const char* old_data, const char* new_data) {
	EXEC SQL BEGIN DECLARE SECTION;
	char* sql_text = NULL;
	EXEC SQL END DECLARE SECTION;

	sql_text = (char*)malloc(sizeof(char) * (strlen(table_name) + strlen(n_data) + strlen(old_data) + 
											 strlen(new_data) + strlen(log_insert_pattern) + 1));
	sprintf(sql_text, log_insert_pattern, table_name, db_priority, old_data, new_data, table_name, n_data);

	EXEC SQL BEGIN WORK;

	EXEC SQL PREPARE query FROM :sql_text;
	EXEC SQL EXECUTE query;
	errorHandle("insert log data");

	EXEC SQL COMMIT WORK;

	free(sql_text);
}

void dbTableInsertLog(const char* table_name, const char* name, const char* operation) {
	int priority = 0;
	if (strcmp(table_name, table_list[1]) == 0) priority = 1;
	if (strcmp(table_name, table_list[2]) == 0) priority = 2;
	if (strcmp(table_name, table_list[3]) == 0) priority = 3;

	dbTableInsert(table_name, name, operation);
	logTableInsert(table_name, priority, "LASTVAL()", "", name);
}

// Подключение к базе данных по указанному логину и паролю
void connectToDatabase(const char* login, const char* password) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_login = login;
	const char* sql_password = password;
	EXEC SQL END DECLARE SECTION;

	EXEC SQL CONNECT TO SERVER USER :sql_login USING :sql_password;
	errorHandle("database connection");
}

// Подключение к указанной схеме бд
void connectToScheme(const char* scheme_name) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_scheme_name = scheme_name;
	EXEC SQL END DECLARE SECTION;

	EXEC SQL SET search_path TO :sql_scheme_name;
	errorHandle("scheme connection");
}

#endif