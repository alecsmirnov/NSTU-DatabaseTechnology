#include "dbFunctions.h"

#include <string>
#include <cctype>

// �������� ������ �� ����� �����
bool isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it))
		++it;

	return !s.empty() && it == s.end();
}

// ���������� SELECT ��������
void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
				 const std::vector<String>& headers,
				 const std::vector<String>& parameters,
				 TADOQuery* source_query) {
	try {
		// ������ ����������
		connection->BeginTrans();

		// ����������� ������ �������
		query->Close();

		// ��������� ����������
		for (auto i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = source_query->FieldByName(parameters[i])->AsString;

		// �������� �������
		query->Open();

        // ��������� ���������� �������
		for (auto i = 0; i != headers.size(); ++i)
			grid->Columns->Items[i]->Title->Caption = headers[i];

		// ������� ��������� ���������� �������
		label->Caption = "������� ����������: " + IntToStr(grid->DataSource->DataSet->RecordCount);

		// ������������ ���������� (��������� ���������)
		connection->CommitTrans();
	}
	catch (Exception& exception) {
		// ���������� ���������� � ������ �������
		connection->RollbackTrans();

		// ����� ��������� �� ������
		MessageDlg("��������� ������: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

        // ��������� ����������
		connection->Close();
	}
}

// ���������� UPDATE ��������
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values) {
	try {
		// ������ ����������
		connection->BeginTrans();

		// ����������� ������ �������
		query->Close();

        // ��������� ����������
		for (auto i = 0; i != parameters.size(); ++i)
			query->Parameters->ParamValues[parameters[i]] = values[i];

		// ���������� ������� �� ����������� ������
		query->ExecSQL();

		// ������������ ���������� (��������� ���������)
		connection->CommitTrans();

		resultMessage("������� ����������: " + IntToStr(query->RowsAffected));
	}
	catch (Exception &exception) {
		// ���������� ���������� � ������ �������
		connection->RollbackTrans();

        // ����� ��������� �� ������
        MessageDlg("��������� ������ ��� ����������: " + exception.Message, mtError, TMsgDlgButtons() << mbOK, 0);

		// ��������� ����������
		connection->Close();
	}
}
