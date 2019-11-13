#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctions.hec";

#define ARGS_COUNT 5				// Количество входных параметров

#define FIELD_LEN  40				// Длина поля для информаци						

// Проверка существования детали с указанным номером
static bool isPExistItem(const char* item) {
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
		EXEC SQL DECLARE exist_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		EXEC SQL OPEN exist_cursor USING :sql_item;
		errorHandle("cursor opening");

		if (sqlca.sqlcode == ECPG_NO_ERROR)
			EXEC SQL FETCH exist_cursor INTO :count;

		EXEC SQL CLOSE exist_cursor;
		errorHandle("cursor close");
	}

	return count;
}

// Выполнить SELECT запрос для динамического условия с аргументом
static void selectFromTable(const char* query_text, const char* query_arg) {
	if (isPExistItem(query_arg)) {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_query_arg = query_arg;

		char town[FIELD_LEN + 1];
		int count;
		int total;
		double percent;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE table_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		EXEC SQL OPEN table_cursor USING :sql_query_arg, :sql_query_arg;
		errorHandle("cursor opening");

		printf("town count total percent\n");
		while (sqlca.sqlcode == ECPG_NO_ERROR) {
			EXEC SQL FETCH table_cursor INTO :town, :count, :total, :percent;

			if (sqlca.sqlcode == ECPG_NO_ERROR)
				printf("%s %d %d %lf\n", town, count, total, percent);
		}
		errorHandle("table output");

		EXEC SQL CLOSE table_cursor;
		errorHandle("cursor close");
	}
	else 
		printf("Item doesn't exist!\n");
}

// Ввести номер детали P*. Найти города, в которые поставлялась деталь P*, и определить, какой процент 
// составляют поставки в каждый город от общего числа поставок детали P*. Вывести город, число поставок 
// деталей в этот город, общее число поставок детали P*, процент.
static void task3(const char* query_arg) {
	const char* query_text = "SELECT towns.town, towns.count, total.count, ROUND(towns.count * 100 / total.count, 2)\
							  FROM (SELECT DISTINCT j.town, COUNT(spj.n_post) AS count\
							  		FROM spj\
							  		JOIN j ON spj.n_izd = j.n_izd\
							  		WHERE spj.n_det = ?\
							  		GROUP BY j.town\
							  	   ) towns\
							  CROSS JOIN (SELECT COUNT(spj.n_post) AS count\
										  FROM spj\
										  WHERE spj.n_det = ?\
										 ) total";

	selectFromTable(query_text, query_arg);
}

int main(int argc, char* argv[]) {
	if (argc != ARGS_COUNT)
		fprintf(stderr, "Invalid count of command line items!\n");
	else {
		char* user_login    = dynamicStrCpy(argv[1]);
		char* user_password = dynamicStrCpy(argv[2]);
		char* user_scheme   = dynamicStrCpy(argv[3]);
		char* query_arg     = dynamicStrCpy(argv[4]);

		// Подключение к базе данных и схеме
		connectToDatabase(user_login, user_password);
		connectToScheme(user_scheme);

		task3(query_arg);

		free(user_login);
		free(user_password);
		free(user_scheme);
		free(query_arg);
	}

	return 0;
}