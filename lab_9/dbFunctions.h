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

// �������� ������ �� ����� �����
bool isIntValue(String string);

// ���������� SELECT ��������
void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
				 const std::vector<String>& headers,
				 const std::vector<String>& parameters = std::vector<String>(),
				 TADOQuery* source_query = nullptr);

// ���������� UPDATE ��������
void updateQuery(TADOConnection* connection, TADOQuery* query,
				 const std::vector<String>& parameters,
				 const std::vector<String>& values);

#endif
