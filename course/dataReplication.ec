#include <stdio.h>

EXEC SQL INCLUDE "databaseFunctions.h";	
#define TABLES_GLOBAL
EXEC SQL INCLUDE "sqlFunctions.h";	

#define USER_FILE "input/user.txt"

int main(int argc, char* argv[]) {
	dbConnect(USER_FILE);
	dbReplication();
	
	printf("Репликация данных завершена!\n");
	
	return 0;
}