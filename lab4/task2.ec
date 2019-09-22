#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctionExec.h";

static void task2() {
	printf("Table p before update\n");
	selectALLFromPTable("SELECT * FROM p");

	EXEC SQL BEGIN WORK;

	EXEC SQL UPDATE p SET ves = (CASE WHEN p.town = 'Париж'
                                 THEN (SELECT MIN(p.ves)
                                       FROM p
                                       WHERE p.town = 'Рим')
                                 ELSE (SELECT MIN(p.ves)
                                       FROM p
                                       WHERE p.town = 'Париж')
                                 END)
             WHERE p.town IN ('Рим', 'Париж');

	errorHandle("task 2");

	EXEC SQL COMMIT WORK;

	printf("\nTable p after update\n");
	selectALLFromPTable("SELECT * FROM p");
}

int main(int argc, char* argv[]) {
	functionExec(argc, argv, task2);

	return 0;
}