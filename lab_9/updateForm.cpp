#include <vcl.h>
#pragma hdrstop

#include "updateForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TForm2* Form2;

// Названия параметров для 3-го запроса
static const std::vector<String> QUERY_PARAMS = {"n_spj", "cost"};


__fastcall TForm2::TForm2(TComponent* Owner) : TForm(Owner) {
    selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label2);
}

// Выбор номера поставки и цены детали по текущей строке таблицы поставок
void __fastcall TForm2::ADOQuery1AfterScroll(TDataSet* DataSet) {
	Label1->Caption = ADOQuery1->FieldByName(QUERY_PARAMS[0])->AsString;
	Edit1->Text = ADOQuery1->FieldByName(QUERY_PARAMS[1])->AsString;
}

// Выполнение запроса на обновление цены детали выбранной поставки
void __fastcall TForm2::Button1Click(TObject* Sender) {
	if (isIntValue(Edit1->Text)) {
		updateQuery(ADOConnection1, ADOQuery2, QUERY_PARAMS, {Label1->Caption, Edit1->Text});

		selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label2);
	}
	else
		warningMessage("Цена может быть только положительным целым числом!");
}
