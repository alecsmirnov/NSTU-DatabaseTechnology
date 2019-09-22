#include <stdio.h>

EXEC SQL INCLUDE "esqlFunctionExec.hec";

void fifthTask() {
	const char* query_text = "SELECT p.*\
							  FROM p\
							  WHERE p.n_det IN (SELECT spj.n_det\
	                  							FROM spj\
	                  							WHERE spj.n_post IN (SELECT s.n_post\
	                                       							 FROM s\
	                                       							 WHERE s.town = 'Афины')\
	                  							EXCEPT\
	                  							SELECT spj.n_det\
	                 							FROM spj\
	                  							WHERE NOT spj.n_post IN (SELECT s.n_post\
	                                           							 FROM s\
	                                           							 WHERE s.town = 'Афины'))";

	selectALLFromPTable(query_text);
}

int main(int argc, char* argv[]) {
	functionExec(argc, argv, fifthTask);

	return 0;
}