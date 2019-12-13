#include <stdint.h>
#include <unistd.h>

EXEC SQL INCLUDE "databaseFunctions.h";	
EXEC SQL INCLUDE "sqlFunctions.h";			

#define USER_FILE   "input/user.txt"
#define UPDATE_FILE "input/update_data.txt"

#define ARGS_COUNT 3

#define DEFAULT_OPERATION_COUNT      10
#define DEFAULT_OPERATION_SLEEP_TIME 2

#define OPERATION_LIST_SIZE 3

const char* operation_list[OPERATION_LIST_SIZE] = {"Вставка в таблицу ", 
												   "Обновление в таблице ", 
												   "Удаление из таблицы "};

static char* makeTableOperation(int table_num, int operation_num) {
	char* operation = (char*)malloc(sizeof(char) * (strlen(operation_list[operation_num]) + 
		                                            strlen(table_list[table_num]) + 1));

	strcpy(operation, operation_list[operation_num]);
	strcat(operation, table_list[table_num]);

	return operation;
}

static void systemStart(const char* update_filename, uint32_t operation_count, uint32_t operation_sleep_time) {
	size_t lines_count = 0;
	char** data = readData(update_filename, &lines_count);

	if (data != NULL) {
		printf("Идёт имитация работы системы...\n");

		uint32_t i = 0;
		for (; i != operation_count; ++i) {
			int table_num = rand() % TABLE_LIST_SIZE;
			int operation_num = rand() % OPERATION_LIST_SIZE;

			int data_num = rand() % lines_count;

			char* operation = makeTableOperation(table_num, operation_num);
			
			switch (operation_num) {
				case INSERT_OPERATION_NUM: dbTableInsertLog(table_list[table_num], data[data_num], operation); break;
				case UPDATE_OPERATION_NUM: dbTableUpdateLog(table_list[table_num], data[data_num], operation); break;
				case DELETE_OPERATION_NUM: dbTableDeleteLog(table_list[table_num], operation); break;
			}

			printf("%d. %s\n", i, operation);

			free(operation);
			sleep(operation_sleep_time);
		}

		i = 0;
		for (; i != lines_count; ++i)
			free(data[i]);
		free(data);

		printf("Имитация работы системы завершена!\n");
	}
}

int main(int argc, char* argv[]) {
	srand(time(NULL));

	uint32_t operation_count = DEFAULT_OPERATION_COUNT;
	uint32_t operation_sleep_time = DEFAULT_OPERATION_SLEEP_TIME;

	switch (argc) {
		case 3: operation_sleep_time = atoi(argv[2]);
		case 2: operation_count = atoi(argv[1]); break;
	}

	dbConnect(USER_FILE);
	systemStart(UPDATE_FILE, operation_count, operation_sleep_time);

	return 0;
}