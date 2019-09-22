#ifndef ESQLDEFINES_HEC
#define ESQLDEFINES_HEC

// Адрес сервера 
EXEC SQL DEFINE SERVER "students@fpm2.ami.nstu.ru";

#define NUMBER_LEN 6				// Длина поля для номеров
#define FIELD_LEN  20				// Длина поля для информаци

// Объявление структур таблиц
EXEC SQL BEGIN DECLARE SECTION;
// Таблица деталей
typedef struct PTable {
	char n_det[NUMBER_LEN + 1];		// Номер
	char name[FIELD_LEN + 1];		// Назавние
	char cvet[FIELD_LEN + 1];		// Цвет
	int  ves;						// Вес
	char town[FIELD_LEN + 1];		// Город производства
} PTable;

// Таблица поставщиков
typedef struct STable {
	char n_post[NUMBER_LEN + 1];	// Номер
	char name[FIELD_LEN + 1];		// Имя
	int  reiting;					// Рейтинг
	char town[FIELD_LEN + 1];		// Город
} STable;
EXEC SQL END DECLARE SECTION;

#endif