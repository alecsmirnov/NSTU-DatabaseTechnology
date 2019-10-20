#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

#include <string>
#include <cctype>

TForm1* Form1;

static constexpr int DEFAULT_PERCENTAGE = 50;

static const std::vector<String> GRID1_HEADERS = {"���", "����� �������", "������������ ��������",
												  "����� ��������", "�������"};
static const std::vector<String> GRID2_HEADERS = {"����� ��������", "�����", "��������"};


__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
	high_percentage = DEFAULT_PERCENTAGE;

	selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label1, GRID1_HEADERS);
}

void __fastcall TForm1::DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect,
											  int DataCol, TColumn* Column, TGridDrawState State) {
	if (high_percentage <= Form1->ADOQuery1->FieldByName("percent")->AsInteger) {
		DBGrid1->Canvas->Brush->Color = clRed;
		DBGrid1->Canvas->Font->Color = clWhite;

		DBGrid1->Canvas->TextRect(Rect, Rect.Left, Rect.Top, Column->Field->DisplayText);
	}
}

void __fastcall TForm1::ADOQuery1AfterScroll(TDataSet* DataSet) {
	selectQuery(ADOConnection2, ADOQuery2, DBGrid2, Label2, GRID2_HEADERS, {"year", "name"});
}

// ���������� SELECT ��������
void TForm1::selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
						 const std::vector<String>& headers,
						 const std::vector<String>& parameters) {
	try {
		// ������ ����������
		connection->BeginTrans();

		// ����������� ������ �������
		query->Close();

		if (!parameters.empty())
			for (auto i = 0; i != parameters.size(); ++i)
				query->Parameters->ParamValues[parameters[i]] = ADOQuery1->FieldByName(parameters[i])->AsString;

		// �������� �������
		query->Open();

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
		// ��������� ����������
		connection->Close();
	}
}

void __fastcall TForm1::Edit1Change(TObject* Sender) {
	high_percentage = DEFAULT_PERCENTAGE;
	if (isIntValue(Edit1->Text))
		high_percentage = StrToInt(Edit1->Text);
	else
        Edit1->Text = IntToStr(high_percentage);

	selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label1, GRID1_HEADERS);
}

// �������� ������ �� ����� �����
bool TForm1::isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it))
		++it;

	return !s.empty() && it == s.end();
}
