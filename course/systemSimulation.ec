#include <stdint.h>
#include <unistd.h>
#include <time.h>

EXEC SQL INCLUDE "databaseFunctions.h";	
EXEC SQL INCLUDE "sqlFunctions.h";			

#define USER_FILE   "input/user.txt"
#define UPDATE_FILE "input/update_data.txt"

#define ARGS_COUNT 3

#define DEFAULT_OPERATION_COUNT      10
#define DEFAULT_OPERATION_SLEEP_TIME 1

enum OPERATION {
	OPERATION_INSERT, 
	OPERATION_UPDATE, 
	OPERATION_DELETE, 
	OPERATION_LIST_SIZE
};

static inline int getRandomVal(int base) {
	return rand() % base;
}

static void systemStart(const char* update_filename, uint32_t operation_count, uint32_t operation_sleep_time) {
	size_t lines_count = 0;
	char** data = readData(update_filename, &lines_count);

	if (data != NULL) {
		const char* operation_list[OPERATION_LIST_SIZE] = {"Вставка", "Обновление", "Удаление"};

		printf("Идёт имитация работы системы...\n");

		for (uint32_t i = 0; i != operation_count; ++i) {
			int table_num = getRandomVal(TABLE_LIST_SIZE - 1);
			int operation_num = getRandomVal(OPERATION_LIST_SIZE);
			int data_num = getRandomVal(lines_count);
			
			switch (operation_num) {
				case OPERATION_INSERT: dbTableInsertLog(table_list[table_num], data[data_num], operation_list[operation_num]); break;
				case OPERATION_UPDATE: dbTableUpdateLog(table_list[table_num], data[data_num], operation_list[operation_num]); break;
				case OPERATION_DELETE: dbTableDeleteLog(table_list[table_num], operation_list[operation_num]); break;
			}

			printf("%d. %s в таблице %s\n", i + 1, operation_list[operation_num], table_list[table_num]);
			sleep(operation_sleep_time);
		}

		for (uint32_t i = 0; i != lines_count; ++i)
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