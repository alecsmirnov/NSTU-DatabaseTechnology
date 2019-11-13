#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctions.hec";

#define ARGS_COUNT 4				// Количество входных параметров				

// Выполнить SELECT запрос для динамического условия
static void selectFromTable(const char* query_text) {
	if (isEmptyTable(query_text, EMPTY_STRING))
		printf("Table is empty!\n");
	else {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		int avg_deliveries;
		EXEC SQL END DECLARE SECTION;

		EXEC SQL PREPARE query FROM :sql_query_text;

		EXEC SQL EXECUTE query INTO :avg_deliveries;
		printf("avg\n%d\n", avg_deliveries);
	}
}

// Получить число поставок для каждого поставщика и найти их среднее.
static void task1() {
	const char* query_text = "SELECT ROUND(AVG(posts.p_count)) AS average\
							  FROM (SELECT COUNT(spj.n_post) AS p_count\
									FROM spj\
									GROUP BY spj.n_post\
								   ) posts";

	selectFromTable(query_text);
}

int main(int argc, char* argv[]) {
	if (argc != ARGS_COUNT)
		fprintf(stderr, "Invalid count of command line items!\n");
	else {
		char* user_login    = dynamicStrCpy(argv[1]);
		char* user_password = dynamicStrCpy(argv[2]);
		char* user_scheme   = dynamicStrCpy(argv[3]);

		// Подключение к базе данных и схеме
		connectToDatabase(user_login, user_password);
		connectToScheme(user_scheme);

		task1();

		free(user_login);
		free(user_password);
		free(user_scheme);
	}

	return 0;
}