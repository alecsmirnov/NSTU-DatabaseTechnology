#ifndef FILEFUNCTIONS_H
#define FILEFUNCTIONS_H

#include <stdlib.h>
#include <string.h>

#define DATA_LEN_MAX 20

// Удаление символов новой строки
static inline void removeNewline(char* string) {
	size_t len = strlen(string);

	if (len && string[len - 1] == '\n')
		string[len - 1] = '\0';
}

// Прочитать строковые данные из файла
char** readData(const char* filename, size_t* lines_count);

#endif