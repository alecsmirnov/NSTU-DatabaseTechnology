#include <stdio.h>

#include "databaseFunctions.h"
#include "sqlFunctions.h"

// Выбрать поставщиков, не поставивших ни одной из деталей, поставляемых для изделий из Парижа.
static void task4() {
	const char* query_text = "SELECT s.*\
							  FROM s\
		 					  WHERE s.n_post IN (SELECT s.n_post\
		                    					 FROM s\
		                    					 EXCEPT\
		                    					 SELECT DISTINCT spj.n_post\
		                    					 FROM spj\
		                   						 WHERE spj.n_det IN (SELECT DISTINCT spj.n_det\
		                                        					 FROM spj\
		                                        					 WHERE spj.n_izd IN (SELECT j.n_izd\
		                                                            					 FROM j\
		                                                            					 WHERE j.town = 'Париж')))";

	selectALLFromSTable(query_text);
}

int main(int argc, char* argv[]) {
	sqlExec(argc, argv, task4);

	return 0;
}