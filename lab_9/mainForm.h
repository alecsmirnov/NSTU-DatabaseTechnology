#ifndef MAINFORM_H
#define MAINFORM_H

#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Data.DB.hpp>
#include <Data.Win.ADODB.hpp>
#include <Vcl.DBGrids.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Menus.hpp>

#include "dbFunctions.h"
#include "updateForm.h"


class TForm1 : public TForm {
public:
	__fastcall TForm1(TComponent* Owner);

__published:
	// Закраска строк DBGrid в зависимости от условия
	void __fastcall DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect, int DataCol,
										  TColumn* Column, TGridDrawState State);
    // Событие DBGrid при переходе от одной строки к другой
	void __fastcall ADOQuery1AfterScroll(TDataSet* DataSet);
    // Изменение значения процента для выделения строк
	void __fastcall Edit1Change(TObject* Sender);

	// Отображение формы для запроса 3
	void __fastcall Button1Click(TObject* Sender);

private:
    // Текущее значение граничного значения процентов
	int high_percentage;

__published:
	// Связь приложения с Бд
	TADOConnection* ADOConnection1;
    // Формирование запроса к Бд
	TADOQuery* ADOQuery1;
    // Соединение DBGrid и подключенной Бд
	TDataSource* DataSource1;
    // Табличное отображение данных
	TDBGrid* DBGrid1;
	TLabel* Label1;

	TADOConnection* ADOConnection2;
	TADOQuery* ADOQuery2;
	TDataSource* DataSource2;
	TDBGrid* DBGrid2;
	TLabel* Label2;

	TLabel* Label3;
	TEdit* Edit1;

	TButton* Button1;
};

extern PACKAGE TForm1* Form1;

#endif
