#ifndef DBFUNCTIONS_H
#define DBFUNCTIONS_H

#include <Data.Win.ADODB.hpp>
#include <Vcl.DBGrids.hpp>

#include <vector>


// ����� ���� ��������� � ���������������
static inline void warningMessage(String text) {
	Application->MessageBox(text.c_str(), L"��������", MB_ICONWARNING);
}

// ����� ���� ��������� � �����������
static inline void resultMessage(String text) {
	Application->MessageBox(text.c_str(), L"���������", NULL);
}

// ����� ���� c ��������� ������
static inline void exceptionMessage(const Exception& exception) {
	MessageDlg("��������� ������ ��� ���������� �������: " + exception.Message,
			   mtError, TMsgDlgButtons() << mbOK, 0);
}

// �������� ������ �� ����� �����
bool isIntValue(String string);

// ���������� ������� �� ������� ������
void selectQuery(TADOConnection* connection, TADOQuery* query,
				 TDBGrid* grid, TLabel* label,
				 const std::vector<String>& parameters = std::vector<String>(),
				 TADOQuery* source_query = nullptr);

// ���������� ������� �� ����������� ������
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values);

#endif
