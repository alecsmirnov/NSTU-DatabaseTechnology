using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Odbc;

namespace DB_queries {
    public partial class Task2 : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            Response.Write(Request.QueryString["Task2"]);
        }

        protected void task1Button_Click(object sender, EventArgs e) {
            // Перенаправление на адрес запроса 1
            Response.Redirect("Task1");
        }

        protected void execButton_Click(object sender, EventArgs e) {
            // Создание объекта подключения
            OdbcConnection connection = new OdbcConnection();
            // Задание параметра подключения – имя ODBC-источника
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["amiConnection"].ConnectionString;
            // Подключение к базе данных
            connection.Open();

            string query_text = "UPDATE pmib6706.v " +
                                "SET date_begin = date_begin - interval '1 month' " +
                                "WHERE pmib6706.v.n_v IN (SELECT (SELECT pmib6706.v.n_v " +
                                                                 "FROM pmib6706.v " +
                                                                 "WHERE pmib6706.v.n_izd = out_v.n_izd " +
                                                                 "ORDER BY pmib6706.v.date_begin DESC " +
                                                                 "LIMIT 1) " +
                                                         "FROM (SELECT DISTINCT pmib6706.q.n_izd " +
                                                               "FROM pmib6706.q " +
                                                               "WHERE pmib6706.q.n_det = ? " +
                                                               ") out_v);";
        
            // Создание объекта запроса
            OdbcCommand command = new OdbcCommand(query_text, connection);

            // Создание параметра запроса
            OdbcParameter parameter = new OdbcParameter();
            parameter.ParameterName = "@n_det";
            parameter.OdbcType = OdbcType.Text;
            parameter.Value = pDropDownList.SelectedItem.Value;
            // Добаавление параметра к запросу
            command.Parameters.Add(parameter);
 
            // Объявление объекта транзакции
            OdbcTransaction transaction = null;
   
            try {
                // Начало транзакции и извлечение объекта транзакции из объекта подключения
                transaction = connection.BeginTransaction();

                // Включение объекта SQL-команды в транзакцию
                command.Transaction = transaction;
                // Выполнение SQL-команды и получение количества обработанных записей
                infoLabel.Text = "Записей обработано: " + command.ExecuteNonQuery().ToString();

                // Подтверждение транзакции  
                transaction.Commit();
                // Обновление gridView
                vGridView.DataBind();
            }
            catch (Exception exception) {
                // Формирование и вывод сообщения об ошибке
                infoLabel.Text = exception.Message;

                // Откатывание транзакции
                transaction.Rollback();
            }

            // Завершение соединения
            connection.Close();
        }
    }
}