#ifndef SQLFUNCTION_H
#define SQLDUNCTION_H

#include "sqlPatterns.h"

typedef enum LOG_LIST {
	LOG_LIST_GENERAL,
	LOG_LIST_LOG,
	LOG_LIST_SIZE
} LOG_LIST;

typedef enum TABLE_LIST {
	TABLE_LIST_PDB1,
	TABLE_LIST_PDB2,
	TABLE_LIST_PDB3,
	TABLE_LIST_CDB,
	TABLE_LIST_SIZE
} TABLE_LIST;


#ifdef TABLES_GLOBAL
	extern const char* log_list[LOG_LIST_SIZE];
	extern const char* table_list[TABLE_LIST_SIZE];
#else

	// Перечень таблиц и приоритетов в схеме репликаций 
	const char* log_list[LOG_LIST_SIZE]   = {"general_log", "log"};
	const char* table_list[TABLE_LIST_SIZE] = {"product_pdb1", "product_pdb2", "product_pdb3", "product_cdb"};
#endif

// Очистка таблиц product_pdbi, product_cdb
void dbClearTable(const char* table_name);

// Очистка последовательностей таблиц product_pdbi, product_cdb
void dbClearSequence(const char* table_name);

// Вставка данных с записью в журнал
void dbTableInsertLog(const char* table_name, const char* name, const char* operation);

// Обновление данных с записью в журнал
void dbTableUpdateLog(const char* table_name, const char* name, const char* operation);

// Удаление данных с записью в журнал
void dbTableDeleteLog(const char* table_name, const char* operation);

// Репликация данных
void dbReplication();

#endif