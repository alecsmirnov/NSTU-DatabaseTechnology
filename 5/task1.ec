#include <stdio.h>

#include "databaseFunctions.h"
#include "sqlFunctions.h"

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
	sqlExec(argc, argv, task1);

	return 0;
}