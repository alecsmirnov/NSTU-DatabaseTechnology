#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TMainFormObj* MainFormObj;

// ������� ������� ��������� �� ��������� (�� ������� �������)
static constexpr int DEFAULT_PERCENTAGE = 50;

// �������� ���������� ��� 2-�� �������
static const std::vector<String> SELECT_PARAMS = {"���", "����� �������"};


__fastcall TMainFormObj::TMainFormObj(TComponent* owner) : TForm(owner) {
	high_percentage = DEFAULT_PERCENTAGE;
}

void __fastcall TMainFormObj::FormActivate(TObject* sender) {
	selectQuery(UpdateFormObj->fpmi_connection, task1_query, task1_grid, task1_row_count_label);
}

// �������� ����� DBGrid � ����������� �� ������� (������� ������ �� ������ ���������� ��������)
void __fastcall TMainFormObj::task1_gridDrawColumnCell(TObject* sender, const TRect &rect, int data_col,
													   TColumn* column, TGridDrawState state) {
	if (high_percentage <= task1_query->FieldByName("�������")->AsInteger) {
		task1_grid->Canvas->Brush->Color = clRed;
		task1_grid->Canvas->Font->Color = clWhite;

		task1_grid->Canvas->TextRect(rect, rect.Left, rect.Top, column->Field->DisplayText);
	}
}

// ������������� ������� 2-�� ������� �� ������� ������ 1-�� �������
void __fastcall TMainFormObj::task1_queryAfterScroll(TDataSet* data_set) {
	selectQuery(UpdateFormObj->fpmi_connection, task2_query, task2_grid, task2_row_count_label, task1_query, SELECT_PARAMS);
}

// ��������� �������� ��������, �� �������� ���������� ��������� �����
void __fastcall TMainFormObj::percent_editChange(TObject* sender) {
	if (isIntValue(percent_edit->Text)) {
		high_percentage = StrToInt(percent_edit->Text);

		selectQuery(UpdateFormObj->fpmi_connection, task1_query, task1_grid, task1_row_count_label);
	}
	else {
		percent_edit->Text = IntToStr(DEFAULT_PERCENTAGE);

		warningMessage("������� ����� ���� ������ ������������� ����� ������!");
	}
}

// ����������� ����� ��� ������� 3
void __fastcall TMainFormObj::update_form_show_buttonClick(TObject* sender) {
	UpdateFormObj->Show();
}
