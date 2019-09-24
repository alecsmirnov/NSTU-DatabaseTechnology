#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctions.hec";

#define ARGS_COUNT 5				// Количество входных параметров

#define NUMBER_LEN 12				// Длина поля для номеров
#define FIELD_LEN  40				// Длина поля для информаци						

// Проверка существования изделия с указанным городом
static bool isJExistTown(const char* town) {
	EXEC SQL BEGIN DECLARE SECTION;
	int count = 0;
	EXEC SQL END DECLARE SECTION;

	const char* query_text = "SELECT COUNT(*)\
							  FROM j\
							  WHERE j.town = ?";

	// Проверка таблицы на пустоту
	if (isEmptyTable(query_text, town))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_town = town;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE exist_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		// Открываем курсор с аргументом
		EXEC SQL OPEN exist_cursor USING :sql_town;
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
	if (isJExistTown(query_arg)) {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_query_arg = query_arg;

		char n_izd[NUMBER_LEN + 1];
		char izd_name[FIELD_LEN + 1];
		char n_det[NUMBER_LEN + 1];
		char det_name[FIELD_LEN + 1];
		char cvet[FIELD_LEN + 1];
		int sum;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;
		EXEC SQL DECLARE table_cursor CURSOR FOR query;
		errorHandle("cursor declaration");

		// Открываем курсор с аргументом
		EXEC SQL OPEN table_cursor USING :sql_query_arg;
		errorHandle("cursor opening");

		printf("n_izd name n_det name cvet sum\n");
		while (sqlca.sqlcode == ECPG_NO_ERROR) {
			EXEC SQL FETCH table_cursor INTO :n_izd, :izd_name, :n_det, :det_name, :cvet, :sum;

			if (sqlca.sqlcode == ECPG_NO_ERROR)
				printf("%s %s %s %s %s %d\n", n_izd, izd_name, n_det, det_name, cvet, sum);
		}
		errorHandle("table output");

		EXEC SQL CLOSE table_cursor;
		errorHandle("cursor close");
	}
	else 
		printf("Town or item doesn't exist!\n");
}

// Для каждого изделия из указанного города найти суммарный объем поставок по каждой детали, 
// для него поставлявшейся. Вывести номер изделия, название изделия, номер детали, название детали, 
// цвет детали, суммарный объем поставок детали для изделия.
static void task2(const char* query_arg) {
	const char* query_text = "SELECT j.n_izd, j.name, p.n_det, p.name, p.cvet, SUM(spj.kol * p.ves)\
							  FROM spj\
							  JOIN p ON spj.n_det = p.n_det\
							  JOIN j ON spj.n_izd = j.n_izd\
							  WHERE j.town = ?\
							  GROUP BY j.n_izd, p.n_det";

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

		task2(query_arg);

		free(user_login);
		free(user_password);
		free(user_scheme);
		free(query_arg);
	}

	return 0;
}