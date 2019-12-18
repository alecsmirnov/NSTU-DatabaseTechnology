#include "sqlFunctions.h"

extern void errorHandle(const char* error_name);

// Проверка строки на пустоту
static bool isEmptyString(const char* str) {
	return strcmp(str, EMPTY_STRING) == 0;
}

// Проверка таблицы на пустоту
bool isEmptyTable(const char* query_text, const char* query_arg) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_query_text = query_text;
	const char* sql_query_arg = query_arg;
	EXEC SQL END DECLARE SECTION;

	bool result = false;

	EXEC SQL PREPARE query FROM :sql_query_text;
	EXEC SQL DECLARE check_cursor CURSOR FOR query;
	errorHandle("cursor declaration");

	// Проверка таблицы по запросу с аргументом или без
	if (isEmptyString(query_arg))
		EXEC SQL OPEN check_cursor;
	else 
		EXEC SQL OPEN check_cursor USING :sql_query_arg;
	errorHandle("cursor opening");

	EXEC SQL FETCH check_cursor;

	if (sqlca.sqlcode == ECPG_NOT_FOUND)
		result = true;

	EXEC SQL CLOSE check_cursor;

	return result;
}

// Проверка существования изделия с указанным городом
bool isJExistTown(const char* town) {
	EXEC SQL BEGIN DECLARE SECTION;
	int count = 0;
	EXEC SQL END DECLARE SECTION;

	const char* query_text = "SELECT COUNT(*)\
							  FROM j\
							  WHERE j.town = ?";

	if (isEmptyTable(query_text, town))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_town = town;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE j_exist_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		// Открываем курсор с аргументом
		EXEC SQL OPEN j_exist_cursor USING :sql_town;
		errorHandle("cursor opening");

		if (sqlca.sqlcode == ECPG_NO_ERROR)
			EXEC SQL FETCH j_exist_cursor INTO :count;

		EXEC SQL CLOSE j_exist_cursor;
		errorHandle("cursor close");
	}

	return count;
}

// Проверка существования детали с указанным номером
bool isPExistItem(const char* item) {
	EXEC SQL BEGIN DECLARE SECTION;
	int count = 0;
	EXEC SQL END DECLARE SECTION;

	const char* query_text = "SELECT COUNT(*)\
							  FROM p\
							  WHERE p.n_det = ?";

	if (isEmptyTable(query_text, item))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_item = item;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE p_exist_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		EXEC SQL OPEN p_exist_cursor USING :sql_item;
		errorHandle("cursor opening");

		if (sqlca.sqlcode == ECPG_NO_ERROR)
			EXEC SQL FETCH p_exist_cursor INTO :count;

		EXEC SQL CLOSE p_exist_cursor;
		errorHandle("cursor close");
	}

	return count;
}