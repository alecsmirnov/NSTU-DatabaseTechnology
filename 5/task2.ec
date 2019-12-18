#include <stdio.h>

#include "databaseFunctions.h"
#include "sqlFunctions.h"

static void selectFromTable(const char* query_text, const char* query_arg) {
	if (isJExistTown(query_arg)) {
		EXEC SQL BEGIN DECLARE SECTION;
		const char* sql_query_text = query_text;
		const char* sql_query_arg = query_arg;

		char n_izd[2 * NUMBER_LEN + 1];
		char izd_name[2 * FIELD_LEN + 1];
		char n_det[2 * NUMBER_LEN + 1];
		char det_name[2 * FIELD_LEN + 1];
		char cvet[2 * FIELD_LEN + 1];
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
	sqlExec(argc, argv, task2);

	return 0;
}