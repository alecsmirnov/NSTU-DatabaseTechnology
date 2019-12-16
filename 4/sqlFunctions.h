#ifndef SQLFUNCTIONS_H
#define SQLFUNCTIONS_H

#define ARGS_COUNT 4

enum USER {
	USER_LOGIN    = 1,
	USER_PASSWORD = 2,
	USER_SCHEME   = 3
};

typedef void (*func_ptr_t)();

extern void connectToDatabase(const char* login, const char* password);
extern void connectToScheme(const char* scheme_name);

// Выполнить функцию с входными параметрами
static inline void sqlExec(int argc, char* argv[], func_ptr_t func) {
	if (argc != ARGS_COUNT)
		fprintf(stderr, "Invalid count of command line items!\n");
	else {
		// Подключение к базе данных и схеме
		connectToDatabase(argv[USER_LOGIN], argv[USER_PASSWORD]);
		connectToScheme(argv[USER_SCHEME]);

		func();
	}
}

// Выполнить SELECT * запрос таблицы p для динамического условия
void selectALLFromPTable(const char* query_text);

// Выполнить SELECT * запрос таблицы s для динамического условия
void selectALLFromSTable(const char* query_text);

#endif