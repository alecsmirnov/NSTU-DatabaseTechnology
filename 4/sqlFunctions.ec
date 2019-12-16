#include "sqlFunctions.h"

#include <stdlib.h>
#include <stdbool.h>

#define NUMBER_LEN 6				// Длина поля для номеров
#define FIELD_LEN  20				// Длина поля для информаци

// Объявление структур таблиц
EXEC SQL BEGIN DECLARE SECTION;
typedef struct PTable {					// Таблица деталей
	char n_det[2 * NUMBER_LEN + 1];		// Номер
	char name[2 * FIELD_LEN + 1];		// Назавние
	char cvet[2 * FIELD_LEN + 1];		// Цвет
	int  ves;							// Вес
	char town[FIELD_LEN + 1];			// Город производства
} PTable;

typedef struct STable {					// Таблица поставщиков
	char n_post[2 * NUMBER_LEN + 1];	// Номер
	char name[2 * FIELD_LEN + 1];		// Имя
	int  reiting;						// Рейтинг
	char town[2 * FIELD_LEN + 1];		// Город
} STable;
EXEC SQL END DECLARE SECTION;

extern void errorHandle(const char* error_name);

// Проверка таблицы на пустоту
static bool isEmptyTable(const char* query_text) {
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
		errorHandle("cursor declaration");

		EXEC SQL OPEN p_cursor;									// Открыть курсор
		errorHandle("cursor opening");

		printf("n_det name cvet ves town\n");
		while (sqlca.sqlcode == ECPG_NO_ERROR) {										// Пока не конец всех записей
			EXEC SQL FETCH p_cursor INTO :p.n_det, :p.name, :p.cvet, :p.ves, :p.town;	// Первая выборка в отношении курсора

			if (sqlca.sqlcode == ECPG_NO_ERROR)
				printf("%s %s %s %d %s\n", p.n_det, p.name, p.cvet, p.ves, p.town);
		}
		errorHandle("p table output");

		EXEC SQL CLOSE p_cursor;								// Закрыть курсор
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