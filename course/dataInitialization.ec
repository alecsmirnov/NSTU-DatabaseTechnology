#include <stdio.h>
#include <stdint.h>

#include "databaseFunctions.h"
#define TABLES_GLOBAL
#include "sqlFunctions.h"

#define USER_FILE  "input/user.txt"
#define INPUT_FILE "input/init_data.txt"

static void dbClear() {
	printf("Идёт очистка данных...\n");

	for (uint8_t i = 0; i != LOG_LIST_SIZE; ++i) {
		dbClearTable(log_list[i]);
		dbClearSequence(log_list[i]);
	}

	for (uint8_t i = 0; i != TABLE_LIST_SIZE; ++i) {
		dbClearTable(table_list[i]);
		dbClearSequence(table_list[i]);
	}

	printf("Очистка данных завершена!\n");
}

static void dbInit(const char* input_filename) {
	size_t lines_count = 0;
	char** data = readData(INPUT_FILE, &lines_count);

	if (data != NULL) {
		dbClear();

		printf("Идёт инициализация данных...\n");

		for (uint8_t i = 0; i != TABLE_LIST_SIZE; ++i) {
			printf("Инициализация %s\n", table_list[i]);

			for (size_t j = 0; j != lines_count; ++j)
				dbTableInsertLog(table_list[i], data[j], "Начальная вставка");
		}

		for (uint8_t i = 0; i != lines_count; ++i)
			free(data[i]);
		free(data);

		printf("Инициализация данных завершена!\n");
	}
}

int main(int argc, char* argv[]) {
	dbConnect(USER_FILE);
	dbInit(INPUT_FILE);

	return 0;
}