#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TForm1* Form1;

// Верхняя граница процентов по умолчанию (по условию задания)
static constexpr int DEFAULT_PERCENTAGE = 50;

// Названия заголовков для таблицы из запроса 1
static const std::vector<String> GRID1_HEADERS = {"Год", "Номер изделия", "Максимальная поставка",
												  "Сумма поставок", "Процент"};
// Названия заголовков для таблицы из запроса 2
static const std::vector<String> GRID2_HEADERS = {"Номер поставки", "Сумма", "Разность"};

// Названия параметров для 2-го запроса
static const std::vector<String> QUERY2_PARAMS = {"year", "name"};


__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
	high_percentage = DEFAULT_PERCENTAGE;

	selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label1, GRID1_HEADERS);
}

// Закраска строк DBGrid в зависимости от условия (Процент продаж не меньше указанного значения)
void __fastcall TForm1::DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect,
											  int DataCol, TColumn* Column, TGridDrawState State) {
	if (high_percentage <= Form1->ADOQuery1->FieldByName("percent")->AsInteger) {
		DBGrid1->Canvas->Brush->Color = clRed;
		DBGrid1->Canvas->Font->Color = clWhite;

		DBGrid1->Canvas->TextRect(Rect, Rect.Left, Rect.Top, Column->Field->DisplayText);
	}
}

// Осуществление выборки 2-го запроса по текущей строке 1-го запроса
void __fastcall TForm1::ADOQuery1AfterScroll(TDataSet* DataSet) {
	selectQuery(ADOConnection2, ADOQuery2, DBGrid2, Label2, GRID2_HEADERS, QUERY2_PARAMS, ADOQuery1);
}

// Изменение значения процента, по которому происходит выделение строк
void __fastcall TForm1::Edit1Change(TObject* Sender) {
	high_percentage = DEFAULT_PERCENTAGE;

	if (isIntValue(Edit1->Text)) {
		high_percentage = StrToInt(Edit1->Text);

		selectQuery(ADOConnection1, ADOQuery1, DBGrid1, Label1, GRID1_HEADERS);
	}
	else {
		Edit1->Text = IntToStr(high_percentage);

        warningMessage("Процент может быть только положительным целым числом!");
	}
}

// Отображение формы для запроса 3
void __fastcall TForm1::Button1Click(TObject* Sender) {
	Form2->Show();
}
