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

// Вывод окна c описанием ошибки
static inline void exceptionMessage(const Exception& exception) {
	MessageDlg("Произошла ошибка при выполнении запроса: " + exception.Message,
			   mtError, TMsgDlgButtons() << mbOK, 0);
}

// Проверка строки на целое число
bool isIntValue(String string);

// Выполнение запроса на выборку данных
void selectQuery(TADOConnection* connection, TADOQuery* query,
				 TDBGrid* grid, TLabel* label,
				 const std::vector<String>& parameters = std::vector<String>(),
				 TADOQuery* source_query = nullptr);

// Выполнение запроса на модификацию данных
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values);

#endif
