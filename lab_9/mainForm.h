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
public:
	__fastcall TForm1(TComponent* Owner);

private:
	void selectQuery(TADOConnection* connection, TADOQuery* query, TDBGrid* grid, TLabel* label,
					 const std::vector<String>& headers,
					 const std::vector<String>& parameters = std::vector<String>());

	bool isIntValue(String string);

__published:
	TLabel *Label3;
	void __fastcall DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect, int DataCol,
										  TColumn* Column, TGridDrawState State);
	void __fastcall ADOQuery1AfterScroll(TDataSet* DataSet);
	void __fastcall Edit1Change(TObject* Sender);

private:
	int high_percentage;

__published:
	TADOConnection* ADOConnection1;
	TADOQuery* ADOQuery1;
    TDataSource* DataSource1;
	TDBGrid* DBGrid1;
	TLabel* Label1;
	TEdit* Edit1;

	TADOConnection* ADOConnection2;
	TADOQuery* ADOQuery2;
	TDataSource* DataSource2;
	TDBGrid* DBGrid2;
	TLabel* Label2;
};

extern PACKAGE TForm1* Form1;

#endif
