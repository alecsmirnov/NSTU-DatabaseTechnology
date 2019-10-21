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


class TMainFormObj : public TForm {
public:
	__fastcall TMainFormObj(TComponent* owner);

__published:
	// �������� ����� DBGrid � ����������� �� �������
	void __fastcall task1_gridDrawColumnCell(TObject* sender, const TRect &rect, int data_col,
											 TColumn* column, TGridDrawState state);
    // ������� DBGrid ��� �������� �� ����� ������ � ������
	void __fastcall task1_queryAfterScroll(TDataSet* data_set);
    // ��������� �������� �������� ��� ��������� �����
	void __fastcall percent_editChange(TObject* sender);

	// ����������� ����� ��� ������� 3
	void __fastcall update_form_show_buttonClick(TObject* sender);
	void __fastcall FormActivate(TObject* sender);

private:
    // ������� �������� ���������� �������� ���������
	int high_percentage;

__published:
	TADOQuery* task1_query;				// ������������ ������� � ��
	TDataSource* task1_data_source;		// ���������� DBGrid � ������������ ��
	TDBGrid* task1_grid;				// ��������� ����������� ������
	TLabel* task1_row_count_label;

	TADOQuery* task2_query;
	TDataSource* task2_data_source;
	TDBGrid* task2_grid;
	TLabel* task2_row_count_label;

	TLabel* percent_text_label;
	TEdit* percent_edit;

	TButton* update_form_show_button;
};

extern PACKAGE TMainFormObj* MainFormObj;

#endif
