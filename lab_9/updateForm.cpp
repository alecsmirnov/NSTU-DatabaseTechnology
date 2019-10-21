#include <vcl.h>
#pragma hdrstop

#include "updateForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TUpdateFormObj* UpdateFormObj;

// �������� ���������� ��� 3-�� �������
static const std::vector<String> QUERY_PARAMS = {"n_spj", "cost"};


__fastcall TUpdateFormObj::TUpdateFormObj(TComponent* owner) : TForm(owner) {
	selectQuery(fpmi_connection, select_query, grid, row_count_label);
}

// ����� ������ �������� � ���� ������ �� ������� ������ ������� ��������
void __fastcall TUpdateFormObj::select_queryAfterScroll(TDataSet* data_set) {
	n_post_label->Caption = select_query->FieldByName(QUERY_PARAMS[0])->AsString;
	det_cost_edit->Text = select_query->FieldByName(QUERY_PARAMS[1])->AsString;
}

// ���������� ������� �� ���������� ���� ������ ��������� ��������
void __fastcall TUpdateFormObj::update_buttonClick(TObject* sender) {
	if (isIntValue(det_cost_edit->Text)) {
		updateQuery(fpmi_connection, update_query, QUERY_PARAMS, {n_post_label->Caption, det_cost_edit->Text});

		selectQuery(fpmi_connection, select_query, grid, row_count_label);
	}
	else
		warningMessage("���� ����� ���� ������ ������������� ����� ������!");
}
