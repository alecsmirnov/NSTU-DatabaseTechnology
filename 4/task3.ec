#include <stdio.h>

#include "databaseFunctions.h"
#include "sqlFunctions.h"

// Найти детали, имеющие поставки, объем которых не превышает
// половину максимального объема поставки этой детали поставщиком из Парижа.
static void task3() {
	const char* query_text = "SELECT p.*\
            							  FROM p\
            							  WHERE p.n_det IN (SELECT DISTINCT spj.n_det\
                                              FROM spj\
                                              JOIN (SELECT spj.n_det, MAX(spj.kol)\
                                                    FROM spj\
                                                    JOIN s ON spj.n_post = s.n_post\
                                                    WHERE s.town = 'Париж'\
                                                    GROUP BY spj.n_det\
                                                  ) max_post ON spj.n_det = max_post.n_det\
                                              WHERE spj.kol <= max_post.max / 2)";

	selectALLFromPTable(query_text);
}

int main(int argc, char* argv[]) {
	sqlExec(argc, argv, task3);

	return 0;
}
