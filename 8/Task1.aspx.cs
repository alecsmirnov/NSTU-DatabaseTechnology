using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_queries {
    public partial class Task1 : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            Response.Write(Request.QueryString["Task1"]);
        }

        protected void execButton_Click(object sender, EventArgs e) {
            // Обновляем значение GridView
            task1GridView.DataSource = task1DataSource;
            task1GridView.DataBind();

            // Проверям результат запроса и выводи информацию
            infoLabel.Text = "Рекомендованная цена:";
            if (task1GridView.Rows.Count == 0)
                infoLabel.Text = "Нет результатов, удовлетворяющих условиям!";
        }

        protected void task2Button_Click(object sender, EventArgs e) {
            // Перенаправление на адрес запроса 2
            Response.Redirect("Task2");
        }
    }
}