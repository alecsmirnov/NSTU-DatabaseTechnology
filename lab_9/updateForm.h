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
	TADOConnection *ADOConnection1;
	TADOQuery *ADOQuery1;
	TDataSource *DataSource1;
	TDBGrid *DBGrid1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TEdit* Edit1;
	TButton *Button1;
	TGroupBox *GroupBox1;
	TLabel *Label1;

	void __fastcall ADOQuery1AfterScroll(TDataSet *DataSet);

private:
};

extern PACKAGE TForm2* Form2;

#endif
