#include <vcl.h>
#pragma hdrstop

#include "updateForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TUpdateFormObj* UpdateFormObj;

// Названия параметров для 3-го запроса
static const std::vector<String> QUERY_PARAMS = {"n_spj", "cost"};


__fastcall TUpdateFormObj::TUpdateFormObj(TComponent* owner) : TForm(owner) {
	selectQuery(fpmi_connection, select_query, grid, row_count_label);
}

// Выбор номера поставки и цены детали по текущей строке таблицы поставок
void __fastcall TUpdateFormObj::select_queryAfterScroll(TDataSet* data_set) {
	n_post_label->Caption = select_query->FieldByName(QUERY_PARAMS[0])->AsString;
	det_cost_edit->Text = select_query->FieldByName(QUERY_PARAMS[1])->AsString;
}

// Выполнение запроса на обновление цены детали выбранной поставки
void __fastcall TUpdateFormObj::update_buttonClick(TObject* sender) {
	if (isIntValue(det_cost_edit->Text)) {
		updateQuery(fpmi_connection, update_query, QUERY_PARAMS, {n_post_label->Caption, det_cost_edit->Text});

		selectQuery(fpmi_connection, select_query, grid, row_count_label);
	}
	else
		warningMessage("Цена может быть только положительным целым числом!");
}
