#include <vcl.h>
#pragma hdrstop

#include "mainForm.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

#include <string>
#include <cctype>

TForm1* Form1;

// Погрешность размера DBGrid относительно формы
static constexpr auto DBGRID_CELL_FAULT  = 5;     
static constexpr auto DBGRID_TABLE_FAULT = 45; 

// Ширина и высота рамок вокруг DBGrid
static constexpr auto BORDER_WIDTH  = 47;
static constexpr auto BORDER_HEIGHT = 150;

// Минимальные размеры окна формы
static constexpr auto WINDOW_WIDTH_MIN  = 459;
static constexpr auto WINDOW_HEIGHT_MIN = 124;

// Позиции объектов пермещения
static constexpr auto OBJ_POSITION_1 = 159;
static constexpr auto OBJ_POSITION_2 = 262;

// Верхняя граница процентов для первой задачи (task1)
static constexpr auto HIGH_PERCENTAGE = 30;


__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
	DBGrid1->Hide();
	
	resizeForm(WINDOW_WIDTH_MIN, WINDOW_HEIGHT_MIN);
}

void __fastcall TForm1::FormShow(TObject* Sender) {
	// Открываем соединение с бд перед демонстрацией формы
	ADOConnection1->Open();
}

// Выполнение запроса в зависимости от выбора (чекбокса)
void __fastcall TForm1::Button1Click(TObject* Sender) {
	if (Form1->RadioButton1->Checked)
		task1();

	if (Form1->RadioButton2->Checked)
		task2();
		
	if (Form1->RadioButton3->Checked)
		task3();
}

// Очистка полей для ввода аргументов запроса
void __fastcall TForm1::Button2Click(TObject* Sender) {
	Form1->Edit1->Clear();
	Form1->Edit2->Clear();
}

// Выобор первого запроса и смена отображения для получения данных
void __fastcall TForm1::RadioButton1Click(TObject* Sender) {
	viewSelect();
}

// Выбор второго запроса и смена отображения для ввода и получения данных
void __fastcall TForm1::RadioButton2Click(TObject* Sender) {
	viewInput("Изделие", "Год");
}

// Выбор третьего запроса и смена отображения для ввода и получения данных
void __fastcall TForm1::RadioButton3Click(TObject* Sender) {
	viewInput("№ поставки", "Цена");
}

// Изменение размера формы
void TForm1::resizeForm(int new_width, int new_height) {
	Form1->Width = new_width;
	Form1->Height = new_height;
}

// Вид отображение формы для получения данных
void TForm1::viewSelect() {
	Form1->Edit1->Hide();
	Form1->Edit2->Hide();
	Form1->Button2->Hide();

	Form1->ADOQuery1->Close();
	DBGrid1->Hide();
	resizeForm(WINDOW_WIDTH_MIN, WINDOW_HEIGHT_MIN);
	
	Form1->Button1->Left = OBJ_POSITION_1;
}

// Вид отображение формы для ввода и получения данных
void TForm1::viewInput(String edit1_hint, String edit2_hint) {
	Form1->Edit1->Show();
	Form1->Edit2->Show();
	Form1->Button2->Show();
	
	// Названия вводимых данных
	Form1->Edit1->TextHint = edit1_hint;
	Form1->Edit2->TextHint = edit2_hint;

	Form1->ADOQuery1->Close();	
	DBGrid1->Hide();
	resizeForm(WINDOW_WIDTH_MIN, WINDOW_HEIGHT_MIN);
	
	// Добавление на форму элементов для ввода
	Form1->Edit1->Left = OBJ_POSITION_1;
	Form1->Edit2->Left = OBJ_POSITION_1;
	Form1->Button1->Left = OBJ_POSITION_2;
}

// Вывод окна сообщения об ощибках
void TForm1::errorMessage(String text) {
	Application->MessageBox(text.c_str(), L"Ошибка", MB_ICONERROR);
}

// Вывод окна сообщения с предупреждением
void TForm1::warningMessage(String text) {
	Application->MessageBox(text.c_str(), L"Внимание", MB_ICONWARNING);
}

// Вывод окна сообщения с результатом
void TForm1::resultMessage(String text) {
	Application->MessageBox(text.c_str(), L"Результат", NULL);
}

// Проверка строки на целое число
bool TForm1::isIntValue(String string) {
	AnsiString ansi_str(string.c_str());
	std::string s(ansi_str.c_str());

	auto it = s.cbegin();
	while (it != s.end() && std::isdigit(*it)) 
		++it;

	return !s.empty() && it == s.end();
}

// Закраска строк DBGrid в зависимости от условия (Процент продаж не меньше значения HIGH_PERCENTAGE) 
void __fastcall TForm1::DBGrid1DrawColumnCell(TObject* Sender, const TRect &Rect,
											  int DataCol, TColumn* Column, TGridDrawState State) {
	if (Form1->RadioButton1->Checked && HIGH_PERCENTAGE <= Form1->ADOQuery1->FieldByName("percent")->AsInteger) {	
		DBGrid1->Canvas->Brush->Color = clRed;
		DBGrid1->Canvas->Font->Color = clWhite;
		
		DBGrid1->Canvas->TextRect(Rect, Rect.Left, Rect.Top, Column->Field->DisplayText);
	}
}

// Обработка таблицы, полученной в результате запроса
int TForm1::processTable(const std::vector<String>& table_headers) {
	// Получение размера шрифта таблицы
	static const auto DBGRID_FONT_SIZE = DBGrid1->Canvas->Font->Size;			
	
	// Количество обработанных строк
	int rows_processed = 0;
	// Максимальная ширана столбцов
	std::vector<int> columns_width(table_headers.size(), 0);
	
	// Перемещение указателя текущей записи
	Form1->ADOQuery1->First();
	while (!Form1->ADOQuery1->Eof) {
		for (auto i = 0; i < table_headers.size(); ++i) {
			// Ширина столбца текущей колонки
			auto column_len = Form1->ADOQuery1->Fields->Fields[i]->AsString.Length();
			
			// Поиск максимальной ширины
			if (columns_width[i] < column_len)
				columns_width[i] = column_len;
		}
		
		// Перевод указателя к следующей записи
		Form1->ADOQuery1->Next();
		
		// Подсчёт количества обработанных записей
		++rows_processed;
	}
	
	// Формирование ширины каждого столбца
	auto dbgrid_width = 0;
	for (auto i = 0; i < table_headers.size(); ++i) {
		DBGrid1->Columns->Items[i]->Title->Caption = table_headers[i];

		auto cur_column_width = columns_width[i];
		if (columns_width[i] < table_headers[i].Length())
			 cur_column_width = table_headers[i].Length();

		auto cell_size = cur_column_width * DBGRID_FONT_SIZE + DBGRID_CELL_FAULT;
		DBGrid1->Columns->Items[i]->Width = cell_size;
		dbgrid_width += cell_size;
	}
	
	// Расчёт ширины таблицы по размерам колонок
	DBGrid1->Width = dbgrid_width + DBGRID_TABLE_FAULT;

	// Изменение размера формы под ширину таблицы
	auto new_width = DBGrid1->Width + BORDER_WIDTH;
	auto new_height = DBGrid1->Height + BORDER_HEIGHT;
	if (DBGrid1->Width + BORDER_WIDTH < WINDOW_WIDTH_MIN )
		 new_width = WINDOW_WIDTH_MIN;
	
	resizeForm(new_width, new_height);

	return rows_processed;
}

// Выполнение SELECT запросов
void TForm1::selectQuery(String query_text, const std::vector<String>& table_headers) {	
	try {
		// Начало транзакции
		Form1->ADOConnection1->BeginTrans();
		
		// Прекращение работы запроса
		Form1->ADOQuery1->Close();
		
		// Очистка и формирование нового SQL запроса
		Form1->ADOQuery1->SQL->Clear();
		Form1->ADOQuery1->SQL->Text = query_text;
		
		// Установка связи между запросом и DataSet для отображения в DBGrid
		Form1->DataSource1->DataSet = Form1->ADOQuery1;
		// Открытие запроса
		Form1->ADOQuery1->Open();
		
		// Формирование таблицы и получения кол-ва обработанных строк
		auto row_processed = processTable(table_headers);
		
		// Подтверждаем транзакцию (сделанные изменения)
		Form1->ADOConnection1->CommitTrans();
		
		// Вывести результат выполнения запроса 
		if (0 < row_processed) {
			DBGrid1->Show();
			Label1->Caption = "Записей обработано: " + IntToStr(row_processed);
		}
		else {
			DBGrid1->Hide();
			resizeForm(WINDOW_WIDTH_MIN, WINDOW_HEIGHT_MIN);
			resultMessage("Записей обработано: 0");
		}
	} 
	catch (Exception &exception) {
		// Откатываем транзакцию в случае неудачи
		Form1->ADOConnection1->RollbackTrans();
		// Разрываем соединение
		Form1->ADOConnection1->Close();

		errorMessage("Произошла ошибка при выполнении запроса!");
	}
}

// 1) Для каждого изделия на конец каждого года получить:
//    * размер максимальной поставки;
//    * сумму, на которую выполнены поставки для изделия;
//    * процент этой суммы от общей суммы по всем изделиям за год.
// Упорядочить по году и проценту. Выделить строки, где процент не меньше 30.
void TForm1::task1() {
	auto query_text = "SELECT izd.year, izd.n_izd, izd.max_post, izd.total_sum_post, ROUND(izd.total_sum_post * 100 / total.sum::numeric, 2) AS percent\
					   FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, pmib6706.spj.n_izd, MAX(pmib6706.spj.kol * pmib6706.p.ves) AS max_post, SUM(pmib6706.spj.kol * pmib6706.spj.cost) AS total_sum_post\
							 FROM pmib6706.spj\
							 JOIN pmib6706.p ON pmib6706.spj.n_det = pmib6706.p.n_det\
							 GROUP BY year, pmib6706.spj.n_izd\
							) izd\
					   JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, SUM(pmib6706.spj.kol * pmib6706.spj.cost) AS sum\
							 FROM pmib6706.spj\
							 GROUP BY year\
							) total\
					   ON izd.year = total.year\
					   ORDER BY izd.year, percent";
	
	// Названия заголовков таблицы
	std::vector<String> table_headers = {"Год", "Номер изделия", "Максимальная поставка", "Сумма поставок", "Процент"};
	
	selectQuery(query_text, table_headers);
}

// 2) Для указанных изделия и года по каждой поставке вывести:
//    * сумму поставки;
//    * разницу между ценой детали в поставке и средней ценой детали за год.
void TForm1::task2() {
	auto izd_name = Form1->Edit1->Text;
	auto year = Form1->Edit2->Text;

	// Проверка корректности вводимых данных
	if (!izd_name.IsEmpty() && !year.IsEmpty())
		if (isIntValue(year)) {
			auto query_text = "SELECT post.n_spj, post.sum, ABS(post.cost - avg.avg_price) AS difference\
							   FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, pmib6706.spj.n_izd, pmib6706.spj.n_spj, SUM(pmib6706.spj.kol * pmib6706.spj.cost), pmib6706.spj.cost\
									 FROM pmib6706.spj\
									 WHERE EXTRACT(year FROM pmib6706.spj.date_post) = \'" + year + "\'\
									 AND pmib6706.spj.n_izd = (SELECT pmib6706.j.n_izd\
															   FROM pmib6706.j\
															   WHERE pmib6706.j.name = \'" + izd_name + "\')\
									 GROUP BY year, pmib6706.spj.n_izd, pmib6706.spj.n_spj, pmib6706.spj.cost\
									) post\
							   JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, pmib6706.spj.n_izd, ROUND(AVG(pmib6706.spj.cost), 2) AS avg_price\
									 FROM pmib6706.spj\
									 GROUP BY year, pmib6706.spj.n_izd\
									) avg\
							   ON post.year = avg.year AND post.n_izd = avg.n_izd";
			
			// Названия заголовков таблицы
			std::vector<String> table_headers = {"Номер поставки", "Сумма", "Разность"};

			selectQuery(query_text, table_headers);
		}
		else 
			errorMessage("Указанный год не является числом!");
	else 
		warningMessage("Значение поля для ввода не может быть пустым!");
}

// 3) Изменить цену детали в поставке.
void TForm1::task3() {
	auto n_post = Form1->Edit1->Text;
	auto price = Form1->Edit2->Text;

	// Проверка корректности вводимых данных
	if (!n_post.IsEmpty() && !price.IsEmpty())
		if (isIntValue(price)) {
			auto query_text = "UPDATE pmib6706.spj\
							   SET cost = " + price + "\
							   WHERE pmib6706.spj.n_spj = \'" + n_post + "\'";
			
			try {
				// Начало транзакции
				Form1->ADOConnection1->BeginTrans();
	
				// Прекращение работы запроса
				Form1->ADOQuery1->Close();
				
				// Очистка и формирование нового SQL запроса
				Form1->ADOQuery1->SQL->Clear();
				Form1->ADOQuery1->SQL->Text = query_text;
				
				// Установка связи между запросом и DataSet для отображения в DBGrid
				Form1->DataSource1->DataSet = Form1->ADOQuery1;
				// Выполнение запроса на модификацию данных
				Form1->ADOQuery1->ExecSQL();
				
				// Подтверждаем транзакцию (сделанные изменения)
				Form1->ADOConnection1->CommitTrans();
			
				resultMessage("Записей обработано: " + IntToStr(Form1->ADOQuery1->RowsAffected));
            } 
			catch (Exception &exception) {
				// Откатываем транзакцию в случае неудачи
				Form1->ADOConnection1->RollbackTrans();
				// Разрываем соединение
				Form1->ADOConnection1->Close();
		
				errorMessage("Произошла ошибка при выполнении запроса!");
			}
		}
		else 
			errorMessage("Указанная цена не является числом!");
	else 
		warningMessage("Значение поля для ввода не может быть пустым!");
}
