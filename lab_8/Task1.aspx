<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task1.aspx.cs" Inherits="DB_queries.Task1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Запрос 1</title>
    <style type="text/css">
        #form1 {
            height: 567px;
            margin-bottom: 364px;
        }
    </style>
</head>
<body>
    <form id="task1Form" runat="server">
        <h1 class="title">Цена на изделие</h1>
        <div>Название изделия:</div> 
        <asp:SqlDataSource ID="izdSelectDataSource" runat="server" ConnectionString="Dsn=PostgreSQL30;database=students;server=students.ami.nstu.ru;
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
                <asp:ControlParameter ControlID="izdDropDownList" Name="n_izd" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="beginDateCalendar" Name="date_begin" PropertyName="SelectedDate" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DropDownList ID="izdDropDownList" runat="server" DataSourceID="izdSelectDataSource" DataTextField="name" DataValueField="n_izd">
        </asp:DropDownList>
        <div>Дата начала действия цены:</div> 
        <asp:Calendar ID="beginDateCalendar" runat="server"></asp:Calendar>
        <asp:Button ID="execButton" runat="server" OnClick="execButton_Click" Text="Найти" /><br /><br />
        <asp:Label ID="infoLabel" runat="server" Text="Выберети изделие и дату действия цены!"></asp:Label>
        <asp:GridView ID="task1GridView" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Номер изделия" HeaderText="Номер изделия" />
                <asp:BoundField DataField="Дата начала" HeaderText="Дата начала" DataFormatString="{0:MM/dd/yyyy}" htmlencode="false" />
                <asp:BoundField DataField="Цена" HeaderText="Цена" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
