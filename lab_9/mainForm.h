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

#include <vector>


class TForm1 : public TForm {
__published:
	void __fastcall FormShow(TObject* Sender);
	void __fastcall Button1Click(TObject* Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall RadioButton1Click(TObject *Sender);
	void __fastcall RadioButton2Click(TObject *Sender);
	void __fastcall RadioButton3Click(TObject *Sender);

__published:
	TADOConnection* ADOConnection1;
	TADOQuery* ADOQuery1;
    TDataSource* DataSource1;
	TDBGrid* DBGrid1;

	TButton* Button1;
	TButton* Button2;
	TRadioButton* RadioButton1;
	TRadioButton* RadioButton2;
	TRadioButton* RadioButton3;
	TGroupBox* GroupBox1;

	TEdit* Edit1;
	TEdit* Edit2;
	TLabel* Label1;

public:
	__fastcall TForm1(TComponent* Owner);

private:
	void resizeForm(int new_width, int new_height);
	void viewSelect();
	void viewInput(String edit1_hint, String edit2_hint);
	void warningMessage(String text);
    void resultMessage(String text);

	int processTable(const std::vector<String>& table_headers);
	void selectQuery(String query_text, const std::vector<String>& table_headers);

	void task1();
	void task2();
	void task3();
};

extern PACKAGE TForm1* Form1;

#endif
