#include <vcl.h>
#pragma hdrstop

#include "updateForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TForm2* Form2;

static const std::vector<String> GRID1_HEADERS = {"Номер поставки", "Номер поставщика", "Номер детали",
												  "Номер изделия", "Кол-во", "Дата", "Цена детали"};


__fastcall TForm2::TForm2(TComponent* Owner) : TForm(Owner) {
	selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label2, GRID1_HEADERS);
}

void __fastcall TForm2::ADOQuery1AfterScroll(TDataSet *DataSet) {
	Label1->Caption = ADOQuery1->FieldByName("n_spj")->AsString;
	Edit1->Text = ADOQuery1->FieldByName("cost")->AsString;
}

