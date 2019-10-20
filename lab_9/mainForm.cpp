#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TForm1* Form1;

static constexpr int DEFAULT_PERCENTAGE = 50;

static const std::vector<String> GRID1_HEADERS = {"Год", "Номер изделия", "Максимальная поставка",
												  "Сумма поставок", "Процент"};
static const std::vector<String> GRID2_HEADERS = {"Номер поставки", "Сумма", "Разность"};

static const std::vector<String> QUERY2_PARAMS = {"year", "name"};


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
	selectQuery(ADOConnection2, ADOQuery2, DBGrid2, Label2, GRID2_HEADERS, QUERY2_PARAMS, ADOQuery1);
}

void __fastcall TForm1::Edit1Change(TObject* Sender) {
	high_percentage = DEFAULT_PERCENTAGE;

	if (isIntValue(Edit1->Text))
		high_percentage = StrToInt(Edit1->Text);
	else
		Edit1->Text = IntToStr(high_percentage);

	selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label1, GRID1_HEADERS);
}

void __fastcall TForm1::Button1Click(TObject* Sender) {
	Form2->Show();
}
