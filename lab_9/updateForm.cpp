#include <vcl.h>
#pragma hdrstop

#include "updateForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TUpdateFormObj* UpdateFormObj;

// �������� ���������� ��� 3-�� �������
static const std::vector<String> UPDATE_PARAMS = {"����� ��������", "���� ������"};


__fastcall TUpdateFormObj::TUpdateFormObj(TComponent* owner) : TForm(owner) {}

void __fastcall TUpdateFormObj::FormShow(TObject* sender) {
	selectQuery(fpmi_connection, select_query, grid, row_count_label);
}

// ������� ������ �������� � ���� �� SELECT ������� ���� �������
void __fastcall TUpdateFormObj::select_queryAfterScroll(TDataSet* data_set) {
	n_post_label->Caption = select_query->FieldByName(UPDATE_PARAMS[0])->AsString;
	det_cost_edit->Text = select_query->FieldByName(UPDATE_PARAMS[1])->AsString;
}

// ���������� 3-�� ������� (���������� ���� ������ ��������� ��������)
void __fastcall TUpdateFormObj::update_buttonClick(TObject* sender) {
	if (isIntValue(det_cost_edit->Text)) {
		std::vector<String> update_values = {n_post_label->Caption, det_cost_edit->Text};

		updateQuery(fpmi_connection, update_query, UPDATE_PARAMS, update_values);
		selectQuery(fpmi_connection, select_query, grid, row_count_label);
	}
	else
		warningMessage("���� ����� ���� ������ ������������� ����� ������!");
}
