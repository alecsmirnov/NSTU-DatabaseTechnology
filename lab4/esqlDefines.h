#ifndef ESQLDEFINES_HEC
#define ESQLDEFINES_HEC

EXEC SQL DEFINE SERVER "students@fpm2.ami.nstu.ru";

#define NUMBER_LEN 6
#define FIELD_LEN  20

EXEC SQL BEGIN DECLARE SECTION;
typedef struct PTable {
	char n_det[NUMBER_LEN + 1];
	char name[FIELD_LEN + 1];
	char cvet[FIELD_LEN + 1];
	int  ves;
	char town[FIELD_LEN + 1];
} PTable;

typedef struct STable {
	char n_post[NUMBER_LEN + 1];
	char name[FIELD_LEN + 1];
	int  reiting;
	char town[FIELD_LEN + 1];
} STable;
EXEC SQL END DECLARE SECTION;

#endif