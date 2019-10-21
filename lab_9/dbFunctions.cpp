#include "dbFunctions.h"

#include <string>
#include <cctype>


// Проверка строки на целое положительное число
bool isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it))
		++it;

	return !s.empty() && it == s.end();
}

// Выполнение запроса на выборку данных
void selectQuery(TADOConnection* connection, TADOQuery* query,
				 TDBGrid* grid, TLabel* label,
				 const std::vector<String>& parameters,
				 TADOQuery* source_query) {
	try {
		query->Close();     				// Прекращение работы запроса
		for (std::vector<String>::size_type i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = source_query->FieldByName(parameters[i])->AsString;
		query->Open();      				// Открытие запроса

		label->Caption = "Записей обработано: " + IntToStr(grid->DataSource->DataSet->RecordCount);
	}
	catch (Exception& exception) {
		connection->Close();    			// Разрыв соединения

		exceptionMessage(exception);
	}
}

// Выполнение запроса на модификацию данных
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values) {
	try {
		connection->BeginTrans();           // Начало транзакции

		query->Close();                     // Прекращение работы запроса
		for (std::vector<String>::size_type i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = values[i];
		query->ExecSQL();                   // Выполнение запроса

		connection->CommitTrans();          // Подтверждение транзакции

		resultMessage("Записей обработано: " + IntToStr(query->RowsAffected));
	}
	catch (Exception &exception) {
		connection->RollbackTrans();		// Откат транзакции
		connection->Close();            	// Разрыв соединения

   		exceptionMessage(exception);
	}
}
