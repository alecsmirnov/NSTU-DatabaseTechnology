#ifndef DBFUNCTIONS_H
#define DBFUNCTIONS_H

#include <vector>
#include <string>
#include <cctype>


// Проверка строки на целое число
static inline bool isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it))
		++it;

	return !s.empty() && it == s.end();
}

// Вывод окна сообщения с предупреждением
static inline void warningMessage(String text) {
	Application->MessageBox(text.c_str(), L"Внимание", MB_ICONWARNING);
}

// Вывод окна сообщения с результатом
static inline void resultMessage(String text) {
	Application->MessageBox(text.c_str(), L"Результат", NULL);
}

// Выполнение SELECT запросов
void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
				 const std::vector<String>& headers,
				 const std::vector<String>& parameters = std::vector<String>(),
				 TADOQuery* source_query = nullptr) {
	try {
		// Начало транзакции
		connection->BeginTrans();

		// Прекращение работы запроса
		query->Close();

		if (!parameters.empty())
			for (auto i = 0; i != parameters.size(); ++i)
				query->Parameters->ParamValues[parameters[i]] = source_query->FieldByName(parameters[i])->AsString;

		// Открытие запроса
		query->Open();

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

		MessageDlg("Произошла ошибка: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

        // Разрываем соединение
		connection->Close();
	}
}

void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values) {
	try {
		// Начало транзакции
		connection->BeginTrans();

		// Прекращение работы запроса
		//query->Close();

        if (!parameters.empty())
			for (auto i = 0; i != parameters.size(); ++i)
				query->Parameters->ParamValues[parameters[i]] = values[i];

		// Открытие запроса
		//query->Open();

		// Выполнение запроса на модификацию данных
		query->ExecSQL();

		// Подтверждаем транзакцию (сделанные изменения)
		connection->CommitTrans();

		resultMessage("Записей обработано: " + IntToStr(query->RowsAffected));
	}
	catch (Exception &exception) {
		// Откатываем транзакцию в случае неудачи
		connection->RollbackTrans();

        MessageDlg("Произошла ошибка при обновлении: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

		// Разрываем соединение
		connection->Close();
	}
}

#endif
