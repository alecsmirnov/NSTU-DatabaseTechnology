#ifndef SQLFUNCTIONS_H
#define SQLFUNCTIONS_H

#include <stdbool.h>

#define ARGS_COUNT_MIN 4
#define ARGS_COUNT_MAX 5

#define NUMBER_LEN 6				// Длина поля для номеров
#define FIELD_LEN  20				// Длина поля для информаци	

#define EMPTY_STRING ""

enum USER {
	USER_LOGIN    = 1,
	USER_PASSWORD = 2,
	USER_SCHEME   = 3,
};

enum QUERY_ARG {
	QUERY_ARG1    = 4
};

typedef void (*func_ptr_t)();

extern void connectToDatabase(const char* login, const char* password);
extern void connectToScheme(const char* scheme_name);

// Выполнить функцию с входными параметрами
static inline void sqlExec(int argc, char* argv[], func_ptr_t func) {
	if (argc < ARGS_COUNT_MIN)
		fprintf(stderr, "Invalid count of command line items!\n");
	else {
		// Подключение к базе данных и схеме
		connectToDatabase(argv[USER_LOGIN], argv[USER_PASSWORD]);
		connectToScheme(argv[USER_SCHEME]);

		switch (argc) {
			case ARGS_COUNT_MIN: func();                 break;
			case ARGS_COUNT_MAX: func(argv[QUERY_ARG1]); break;
		}
	}
}

// Проверка таблицы на пустоту
bool isEmptyTable(const char* query_text, const char* query_arg);					

// Проверка существования изделия с указанным городом
bool isJExistTown(const char* town);

// Проверка существования детали с указанным номером
bool isPExistItem(const char* item);

#endif