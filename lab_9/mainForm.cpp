#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TMainFormObj* MainFormObj;

// Верхняя граница процентов по умолчанию (по условию задания)
static constexpr int DEFAULT_PERCENTAGE = 50;

// Названия параметров для 2-го запроса
static const std::vector<String> SELECT_PARAMS = {"Год", "Номер изделия"};


__fastcall TMainFormObj::TMainFormObj(TComponent* owner) : TForm(owner) {
	high_percentage = DEFAULT_PERCENTAGE;
}

void __fastcall TMainFormObj::FormActivate(TObject* sender) {
	selectQuery(UpdateFormObj->fpmi_connection, task1_query, task1_grid, task1_row_count_label);
}

// Закраска строк DBGrid в зависимости от условия (Процент продаж не меньше указанного значения)
void __fastcall TMainFormObj::task1_gridDrawColumnCell(TObject* sender, const TRect &rect, int data_col,
													   TColumn* column, TGridDrawState state) {
	if (high_percentage <= task1_query->FieldByName("Процент")->AsInteger) {
		task1_grid->Canvas->Brush->Color = clRed;
		task1_grid->Canvas->Font->Color = clWhite;

		task1_grid->Canvas->TextRect(rect, rect.Left, rect.Top, column->Field->DisplayText);
	}
}

// Осуществление выборки 2-го запроса по текущей строке 1-го запроса
void __fastcall TMainFormObj::task1_queryAfterScroll(TDataSet* data_set) {
	selectQuery(UpdateFormObj->fpmi_connection, task2_query, task2_grid, task2_row_count_label, task1_query, SELECT_PARAMS);
}

// Изменение значения процента, по которому происходит выделение строк
void __fastcall TMainFormObj::percent_editChange(TObject* sender) {
	if (isIntValue(percent_edit->Text)) {
		high_percentage = StrToInt(percent_edit->Text);

		selectQuery(UpdateFormObj->fpmi_connection, task1_query, task1_grid, task1_row_count_label);
	}
	else {
		percent_edit->Text = IntToStr(DEFAULT_PERCENTAGE);

		warningMessage("Процент может быть только положительным целым числом!");
	}
}

// Отображение формы для запроса 3
void __fastcall TMainFormObj::update_form_show_buttonClick(TObject* sender) {
	UpdateFormObj->Show();
}
