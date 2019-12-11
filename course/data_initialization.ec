#include <stdio.h>
#include <stdint.h>

EXEC SQL INCLUDE "esqlFunctions.h";	

#define DATA_SIZE 10

static void dbInit() {
	const char* data[DATA_SIZE] = {"Жёсткий диск",
								   "Перфоратор", 
								   "Считыватель", 
								   "Принтер",
								   "Флоппи-диск", 
								   "Терминал",
								   "Лента", 
								   "Кулер",
								   "Процессор", 
								   "Блок питания"};

	const char* operation = "Начальная вставка";

	uint8_t i = 0;
	for (; i != TABLE_LIST_SIZE; ++i) {
		uint8_t j = 0;
		for (; j != DATA_SIZE; ++j)
			dbTableInsertLog(table_list[i], data[j], operation);
	}
}

int main(int argc, char* argv[]) {
	const char* user_login    = "pmi-b6706"; 
	const char* user_password = "Ickejev3";
	const char* user_scheme   = "pmib6706";

	connectToDatabase(user_login, user_password);
	connectToScheme(user_scheme);

	dbInit();

	return 0;
}