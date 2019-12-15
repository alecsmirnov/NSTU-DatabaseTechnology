#include "fileFunctions.h"

#include <stdio.h>

// Прочитать строковые данные из файла
char** readData(const char* filename, size_t* lines_count) {
	char** data = NULL;
	*lines_count = 0;

	FILE* fp = NULL;
	if ((fp = fopen(filename, "r")) != NULL) {
		*lines_count = 1;

		int symbol = EOF;
		while ((symbol = fgetc(fp)) != EOF)
			if (symbol == '\n')
				++*lines_count;

		fseek(fp, 0, SEEK_SET);

		data = (char**)malloc(sizeof(char*) * *lines_count);

		char temp_data[2 * DATA_LEN_MAX + 1];
		for (size_t i = 0; fgets(temp_data, sizeof temp_data, fp); ++i) {
			data[i] = (char*)malloc(sizeof(char*) * strlen(temp_data));

			removeNewline(temp_data);
			strcpy(data[i], temp_data);
		}

		fclose(fp);
	}
	else {
		printf("Не удалось открыть файл \'%s\'!\n", filename);
		exit(EXIT_FAILURE);
	}

	return data;
}