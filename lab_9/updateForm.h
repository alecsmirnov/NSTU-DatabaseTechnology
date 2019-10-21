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


class TUpdateFormObj : public TForm {
public:
	__fastcall TUpdateFormObj(TComponent* owner);

__published:
	// Событие DBGrid при переходе от одной строки к другой
	void __fastcall select_queryAfterScroll(TDataSet* data_set);
	// Выполнение запроса на обновление цены детали выбранной поставки
	void __fastcall update_buttonClick(TObject* sender);

__published:
	TADOConnection* fpmi_connection;		// Связь приложения с Бд

	TADOQuery* select_query;				// Формирование запроса к Бд
	TDataSource* fpmi_data_source;			// Соединение DBGrid и подключенной Бд
	TDBGrid* grid;							// Табличное отображение данных

	TADOQuery* update_query;
	TLabel* n_post_label;
	TEdit* det_cost_edit;
	TButton* update_button;

	TLabel* row_count_label;

	TLabel* n_post_text_label;
	TLabel* det_cost_text_edit;
	TGroupBox* group_box;
};

extern PACKAGE TUpdateFormObj* UpdateFormObj;

#endif
