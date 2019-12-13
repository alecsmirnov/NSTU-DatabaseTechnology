#include <stdio.h>
#include <stdint.h>

EXEC SQL INCLUDE "databaseFunctions.h";	
EXEC SQL INCLUDE "sqlFunctions.h";	

#define USER_FILE  "input/user.txt"
#define INPUT_FILE "input/input_data.txt"

static void dbInit(const char* input_filename) {
	size_t lines_count = 0;
	char** data = readData(INPUT_FILE, &lines_count);

	if (data != NULL) {
		printf("Идёт инициализация...\n");

		uint8_t i = 0;
		for (; i != TABLE_LIST_SIZE; ++i) {
			size_t j = 0;
			for (; j != lines_count; ++j)
				dbTableInsertLog(table_list[i], data[j], "Начальная вставка");
		}

		i = 0;
		for (; i != lines_count; ++i)
			free(data[i]);
		free(data);

		printf("Инициализация завершена!\n");
	}
}

int main(int argc, char* argv[]) {
	dbConnect(USER_FILE);
	dbInit(INPUT_FILE);

	return 0;
}