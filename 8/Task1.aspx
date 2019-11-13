<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task1.aspx.cs" Inherits="DB_queries.Task1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Запрос 1</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <form id="task1Form" runat="server">
        <asp:SqlDataSource ID="jDataSource" runat="server" ConnectionString="Dsn=PostgreSQL30;database=students;server=students.ami.nstu.ru;
            port=5432;uid=pmi-b6706;pwd=Ickejev3;sslmode=disable;readonly=0;protocol=7.4;fakeoidindex=0;showoidcolumn=0;rowversioning=0;
            showsystemtables=0;fetch=100;socket=4096;unknownsizes=0;maxvarcharsize=255;maxlongvarcharsize=8190;debug=0;commlog=0;optimizer=0;
            ksqo=1;usedeclarefetch=0;textaslongvarchar=1;unknownsaslongvarchar=0;boolsaschar=1;parse=0;cancelasfreestmt=0;extrasystableprefixes=dd_;
            lfconversion=1;updatablecursors=1;disallowpremature=0;trueisminus1=0;bi=0;byteaaslongvarbinary=0;useserversideprepare=0;
            lowercaseidentifier=0;xaopt=1" ProviderName="System.Data.Odbc" SelectCommand="SELECT pmib6706.j.n_izd, pmib6706.j.name FROM pmib6706.j">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="task1DataSource" runat="server" ConnectionString="Dsn=PostgreSQL30;database=students;server=students.ami.nstu.ru;
            port=5432;uid=pmi-b6706;pwd=Ickejev3;sslmode=disable;readonly=0;protocol=7.4;fakeoidindex=0;showoidcolumn=0;rowversioning=0;
            showsystemtables=0;fetch=100;socket=4096;unknownsizes=0;maxvarcharsize=255;maxlongvarcharsize=8190;debug=0;commlog=0;optimizer=0;
            ksqo=1;usedeclarefetch=0;textaslongvarchar=1;unknownsaslongvarchar=0;boolsaschar=1;parse=0;cancelasfreestmt=0;extrasystableprefixes=dd_;
            lfconversion=1;updatablecursors=1;disallowpremature=0;trueisminus1=0;bi=0;byteaaslongvarbinary=0;useserversideprepare=0;
            lowercaseidentifier=0;xaopt=1" ProviderName="System.Data.Odbc" SelectCommand="SELECT pmib6706.v.n_izd AS &quot;Номер изделия&quot;, 
            pmib6706.v.date_begin AS &quot;Дата начала&quot;, pmib6706.v.cost AS &quot;Цена&quot; 
            FROM pmib6706.v WHERE pmib6706.v.n_izd = ? AND pmib6706.v.date_begin &lt;= ? ORDER BY pmib6706.v.date_begin DESC LIMIT 1;">
            <SelectParameters>
                <asp:ControlParameter ControlID="jDropDownList" Name="n_izd" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="beginDateCalendar" Name="date_begin" PropertyName="SelectedDate" />
            </SelectParameters>
        </asp:SqlDataSource>

        <h1 class="title">Цена на изделие</h1>
        <div class="view task1">
            <div class="box">
                <div class="interface_block">
                    <div>Название изделия:</div> 
                    <asp:DropDownList ID="jDropDownList" runat="server" DataSourceID="jDataSource" DataTextField="name" DataValueField="n_izd">
                    </asp:DropDownList>
                </div>
                <div>Дата начала действия цены:</div> 
                <div class="calendar_block">
                    <asp:Calendar ID="beginDateCalendar" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" Width="350px">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#B03B21" ForeColor="White" />
                        <TitleStyle BackColor="White" BorderColor="#CCCCCC" BorderWidth="1px" Font-Bold="True" Font-Size="12pt" ForeColor="#B03B21" />
                        <TodayDayStyle BackColor="White" Wrap="True" />
                    </asp:Calendar>
                </div>
            </div>
            <div class="button_block">
                <asp:Button ID="execButton" runat="server" OnClick="execButton_Click" Text="Найти" />
            </div><br />
            <div class="box">
                <asp:Label ID="infoLabel" runat="server" Text="Выберети изделие и дату действия цены!"></asp:Label>
                <asp:GridView ID="task1GridView" runat="server" AutoGenerateColumns="false" HorizontalAlign="Center">
                    <Columns>
                        <asp:BoundField DataField="Номер изделия" HeaderText="Номер изделия" />
                        <asp:BoundField DataField="Дата начала" HeaderText="Дата начала" DataFormatString="{0:MM/dd/yyyy}" htmlencode="false" />
                        <asp:BoundField DataField="Цена" HeaderText="Цена" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="button_block">
                <asp:Button ID="task2Button" runat="server" Text="Запрос 2" OnClick="task2Button_Click" />
            </div><br />
        </div>
    </form>
</body>
</html>