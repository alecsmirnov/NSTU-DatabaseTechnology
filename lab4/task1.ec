#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctionExec.hec";

// Выдать число деталей, поставлявшихся для изделий, у которых есть поставки с весом от 5000 до 6000.
static void task1() {
	EXEC SQL BEGIN DECLARE SECTION;
	int count;
	EXEC SQL END DECLARE SECTION;

	EXEC SQL BEGIN WORK;

	EXEC SQL SELECT COUNT(DISTINCT spj.n_det) INTO :count
             FROM spj
             WHERE spj.n_izd IN (SELECT spj.n_izd
                                 FROM spj
                                 JOIN p ON spj.n_det = p.n_det
                                 WHERE spj.kol * p.ves BETWEEN 5000 AND 6000);

    errorHandle("task 1");

	EXEC SQL COMMIT WORK;

	printf("count: %d\n", count);
}

int main(int argc, char* argv[]) {
	functionExec(argc, argv, task1);

	return 0;
}
