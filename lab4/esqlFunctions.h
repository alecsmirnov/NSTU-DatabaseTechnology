#ifndef ESQLFUNCTIONS_HEC
#define ESQLFUNCTIONS_HEC

EXEC SQL INCLUDE "esqlDefines.h";

#include <stdbool.h>

// Отлов ошибок и вывода информации на экран
void errorHandle(const char* error_name) {
	if (sqlca.sqlcode != ECPG_NO_ERROR && sqlca.sqlcode != ECPG_NOT_FOUND) {
		fprintf(stderr, "Error: %s\n", error_name);
		fprintf(stderr, "Code %d: %s\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
		
		EXEC SQL ROLLBACK WORK;				// Откат транзакции на начало

		exit(EXIT_FAILURE);					// Прекращение работы
	}
}

// Проверка таблицы на пустоту
bool isEmptyTable(const char* query_text) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_query_text = query_text;
	EXEC SQL END DECLARE SECTION;

	bool result = false;

	EXEC SQL PREPARE query FROM :sql_query_text;
	EXEC SQL DECLARE check_cursor CURSOR FOR query;
	errorHandle("cursor declaration");

	EXEC SQL OPEN check_cursor;
	errorHandle("cursor opening");

	EXEC SQL FETCH check_cursor;

	if (sqlca.sqlcode == ECPG_NOT_FOUND)
		result = true;

	EXEC SQL CLOSE check_cursor;

	return result;
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

// Выполнить SELECT * запрос таблицы p для динамического условия
void selectALLFromPTable(const char* query_text) {
	if (isEmptyTable(query_text))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		PTable p;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;			// Приготовить динамический запрос
		EXEC SQL DECLARE p_cursor CURSOR FOR query;				// Определить курсор для динамического запроса
		//EXEC SQL DECLARE p_cursor SCROLL CURSOR FOR query;	// Определить скроллящий курсор
		errorHandle("cursor declaration");

		EXEC SQL OPEN p_cursor;								// Открыть курсор
		errorHandle("cursor opening");

		printf("n_det name cvet ves town\n");
		while (sqlca.sqlcode == ECPG_NO_ERROR) {												// Пока не конец всех записей
			EXEC SQL FETCH p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;			// Первая выборка в отношении курсора
			//EXEC SQL FETCH NEXT p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;	// Следующая строка активного множества
			//EXEC SQL FETCH PREVIOUS p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;// Предыдущая строка активного множества
			//EXEC SQL FETCH FIRST p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;	// Первая строка активного множества
			//EXEC SQL FETCH LAST p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;	// Последняя строка активного множества

			if (sqlca.sqlcode == ECPG_NO_ERROR)
				printf("%s %s %s %d %s\n", p.n_det, p.name, p.cvet, p.ves, p.town);
		}
		errorHandle("p table output");

		EXEC SQL CLOSE p_cursor;							// Закрыть курсор
		errorHandle("cursor close");
	}
}

// Выполнить SELECT * запрос таблицы s для динамического условия
void selectALLFromSTable(const char* query_text) {
	if (isEmptyTable(query_text))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		STable s;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE s_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		EXEC SQL OPEN s_cursor;
		errorHandle("cursor opening");

		printf("n_post name reiting town\n");
		while (sqlca.sqlcode == ECPG_NO_ERROR) {
			EXEC SQL FETCH s_cursor INTO :s.n_post, :s.name, :s.reiting, :s.town;

			if (sqlca.sqlcode == ECPG_NO_ERROR)
				printf("%s %s %d %s\n", s.n_post, s.name, s.reiting, s.town);
		}
		errorHandle("s table output");

		EXEC SQL CLOSE s_cursor;
		errorHandle("cursor close");
	}
}

#endif