#include <stdio.h>

#include "databaseFunctions.h"
#include "sqlFunctions.h"

// Поменять местами вес деталей из Рима и из Парижа, т. е. деталям из Рима 
// установить вес детали из Парижа, а деталям из Парижа установить вес детали из Рима. 
// Если деталей несколько, брать наименьший вес.
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

    printf("\nRows processed: %d\n", sqlca.sqlerrd[2]);
	errorHandle("task 2");

	EXEC SQL COMMIT WORK;

	printf("\nTable p after update\n");
	selectALLFromPTable("SELECT * FROM p");
}

int main(int argc, char* argv[]) {
	sqlExec(argc, argv, task2);

	return 0;
}