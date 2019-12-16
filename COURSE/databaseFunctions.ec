#include "databaseFunctions.h"

#include <stdlib.h>
#include <string.h>

enum USER_INFO {
	USER_INFO_LOGIN,
	USER_INFO_PASSWORD,
	USER_INFO_SCHEME,
	USER_INFO_SIZE
};

// Отлов ошибок и вывода информации на экран
void errorHandle(const char* error_name) {
	if (sqlca.sqlcode != ECPG_NO_ERROR && sqlca.sqlcode != ECPG_NOT_FOUND) {
		fprintf(stderr, "Error: %s\n", error_name);
		fprintf(stderr, "Code %d: %s\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
		
		EXEC SQL ROLLBACK WORK;

		exit(EXIT_FAILURE);
	}
}

// Подключение к базе данных по указанному логину и паролю
void connectToDatabase(const char* login, const char* password) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_login = login;
	const char* sql_password = password;
	const char* server = SERVER;
	EXEC SQL END DECLARE SECTION;

	EXEC SQL CONNECT TO :server USER :sql_login USING :sql_password;
	errorHandle("database connection");
}

// Подключение к указанной схеме бд
void connectToScheme(const char* scheme_name) {
	EXEC SQL BEGIN DECLARE SECTION;
	const char* sql_scheme_name = scheme_name;
	EXEC SQL END DECLARE SECTION;

	EXEC SQL SET search_path TO :sql_scheme_name;
	errorHandle("scheme connection");
}

// Подключение к бд при помощи файла пользователя: логин, пароль, схема
void dbConnect(const char* user_filename) {
	size_t lines_count = 0;
	char** data = readData(user_filename, &lines_count);

	if (data != NULL && lines_count == USER_INFO_SIZE) {
		connectToDatabase(data[USER_INFO_LOGIN], data[USER_INFO_PASSWORD]);
		connectToScheme(data[USER_INFO_SCHEME]);

		for (size_t i = 0; i != lines_count; ++i)
			free(data[i]);
		free(data);
	}
}