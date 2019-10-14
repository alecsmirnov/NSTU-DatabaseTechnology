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
	
__published:
	void __fastcall FormShow(TObject* Sender);
	
	// Выполнение запроса в зависимости от выбора
	void __fastcall Button1Click(TObject* Sender);
	// Очистка полей для ввода аргументов запроса
	void __fastcall Button2Click(TObject* Sender);
	
	// Выобор первого запроса и смена отображения для получения данных
	void __fastcall RadioButton1Click(TObject* Sender);
	// Выбор второго запроса и смена отображения для ввода и получения данных
	void __fastcall RadioButton2Click(TObject* Sender);
	// Выбор третьего запроса и смена отображения для ввода и получения данных
	void __fastcall RadioButton3Click(TObject* Sender);
	
	// Закраска строк DBGrid в зависимости от условия
	void __fastcall DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect, int DataCol,
										  TColumn* Column, TGridDrawState State);

private:
	// Изменение размера формы
	void resizeForm(int new_width, int new_height);
	// Вид отображение формы для получения данных
	void viewSelect();
	// Вид отображение формы для ввода и получения данных
	void viewInput(String edit1_hint, String edit2_hint);
	
	// Вывод окна сообщения об ощибках
    void errorMessage(String text);
	// Вывод окна сообщения с предупреждением
	void warningMessage(String text);
	// Вывод окна сообщения с результатом
	void resultMessage(String text);
	
	// Проверка строки на целое число
    bool isIntValue(String string);

	// Обработка таблицы, полученной в результате запроса
	int processTable(const std::vector<String>& table_headers);
	// Выполнение SELECT запросов
	void selectQuery(String query_text, const std::vector<String>& table_headers);

	// Запросы
	void task1();
	void task2();
	void task3();
	
__published:
	// Связь приложения с Бд
	TADOConnection* ADOConnection1;
	// Формирование запроса к Бд
	TADOQuery* ADOQuery1;
	// Соединение DBGrid и подключенной Бд
    TDataSource* DataSource1;
	// Табличное отображение данных
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
};

extern PACKAGE TForm1* Form1;

#endif
