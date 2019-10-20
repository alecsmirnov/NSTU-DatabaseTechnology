#ifndef DBFUNCTIONS_H
#define DBFUNCTIONS_H

#include <Data.Win.ADODB.hpp>
#include <Vcl.DBGrids.hpp>

#include <vector>


// Вывод окна сообщения с предупреждением
static inline void warningMessage(String text) {
	Application->MessageBox(text.c_str(), L"Внимание", MB_ICONWARNING);
}

// Вывод окна сообщения с результатом
static inline void resultMessage(String text) {
	Application->MessageBox(text.c_str(), L"Результат", NULL);
}

// Проверка строки на целое число
bool isIntValue(String string);

// Выполнение SELECT запросов
void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
				 const std::vector<String>& headers,
				 const std::vector<String>& parameters = std::vector<String>(),
				 TADOQuery* source_query = nullptr);

// Выполнение UPDATE запросов
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values);

#endif
