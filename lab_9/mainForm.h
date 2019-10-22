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
	void __fastcall FormActivate(TObject* sender);

	// Закраска строк таблицы в зависимости от верхней границы процента
	void __fastcall task1_gridDrawColumnCell(TObject* sender, const TRect &rect, int data_col,
											 TColumn* column, TGridDrawState state);
    // Осуществление выборки 2-го запроса по текущей строке 1-го запроса
	void __fastcall task1_queryAfterScroll(TDataSet* data_set);
    // Изменение значения процента для выделения строк
	void __fastcall percent_editChange(TObject* sender);

	// Отображение формы для 3-го запроса
	void __fastcall update_form_show_buttonClick(TObject* sender);

private:
    // Текущее значение граничного значения процентов
	int high_percentage;

__published:
	TADOQuery* task1_query;
	TDataSource* task1_data_source;
	TDBGrid* task1_grid;
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
