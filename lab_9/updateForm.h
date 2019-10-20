#ifndef UPDATEFORM_H
#define UPDATEFORM_H

#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Data.DB.hpp>
#include <Data.Win.ADODB.hpp>
#include <Vcl.DBGrids.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Vcl.Mask.hpp>

#include "dbFunctions.h"


class TForm2 : public TForm {
public:
	__fastcall TForm2(TComponent* Owner);

__published:
	// Событие DBGrid при переходе от одной строки к другой
	void __fastcall ADOQuery1AfterScroll(TDataSet* DataSet);
    // Выполнение запроса на обновление цены детали выбранной поставки
	void __fastcall Button1Click(TObject* Sender);

__published:
    // Связь приложения с Бд
	TADOConnection* ADOConnection1;
    // Формирование запроса к Бд
	TADOQuery* ADOQuery1;
    // Соединение DBGrid и подключенной Бд
	TDataSource* DataSource1;
    // Табличное отображение данных
	TDBGrid* DBGrid1;

	TADOConnection* ADOConnection2;
	TADOQuery* ADOQuery2;
	TDataSource* DataSource2;

	TLabel* Label1;
	TEdit* Edit1;
	TButton* Button1;

	TLabel* Label2;

	TLabel* Label3;
	TLabel* Label4;
	TGroupBox* GroupBox1;
};

extern PACKAGE TForm2* Form2;

#endif
