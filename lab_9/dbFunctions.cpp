#include "dbFunctions.h"

#include <string>
#include <cctype>

// Проверка строки на целое число
bool isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it))
		++it;

	return !s.empty() && it == s.end();
}

// Выполнение SELECT запросов
void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
				 const std::vector<String>& headers,
				 const std::vector<String>& parameters,
				 TADOQuery* source_query) {
	try {
		// Начало транзакции
		connection->BeginTrans();

		// Прекращение работы запроса
		query->Close();

		// Установка параметров
		for (auto i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = source_query->FieldByName(parameters[i])->AsString;

		// Открытие запроса
		query->Open();

        // Установка заголовков таблицы
		for (auto i = 0; i != headers.size(); ++i)
			grid->Columns->Items[i]->Title->Caption = headers[i];

		// Вывести результат выполнения запроса
		label->Caption = "Записей обработано: " + IntToStr(grid->DataSource->DataSet->RecordCount);

		// Подтверждаем транзакцию (сделанные изменения)
		connection->CommitTrans();
	}
	catch (Exception& exception) {
		// Откатываем транзакцию в случае неудачи
		connection->RollbackTrans();

		// Вывод сообщения об ошибке
		MessageDlg("Произошла ошибка: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

        // Разрываем соединение
		connection->Close();
	}
}

// Выполнение UPDATE запросов
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values) {
	try {
		// Начало транзакции
		connection->BeginTrans();

		// Прекращение работы запроса
		query->Close();

        // Установка параметров
		for (auto i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = values[i];

		// Выполнение запроса на модификацию данных
		query->ExecSQL();

		// Подтверждаем транзакцию (сделанные изменения)
		connection->CommitTrans();

		resultMessage("Записей обработано: " + IntToStr(query->RowsAffected));
	}
	catch (Exception &exception) {
		// Откатываем транзакцию в случае неудачи
		connection->RollbackTrans();

        // Вывод сообщения об ошибке
        MessageDlg("Произошла ошибка при обновлении: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

		// Разрываем соединение
		connection->Close();
	}
}
