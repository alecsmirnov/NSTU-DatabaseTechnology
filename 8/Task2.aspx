<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task2.aspx.cs" Inherits="DB_queries.Task2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Запрос 2</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <form id="task2Form" runat="server">
        <asp:SqlDataSource ID="vDataSource" runat="server" ConnectionString="Dsn=PostgreSQL30;database=students;server=students.ami.nstu.ru;
            port=5432;uid=pmi-b6706;pwd=Ickejev3;sslmode=disable;readonly=0;protocol=7.4;fakeoidindex=0;showoidcolumn=0;rowversioning=0;
            showsystemtables=0;fetch=100;socket=4096;unknownsizes=0;maxvarcharsize=255;maxlongvarcharsize=8190;debug=0;commlog=0;optimizer=0;
            ksqo=1;usedeclarefetch=0;textaslongvarchar=1;unknownsaslongvarchar=0;boolsaschar=1;parse=0;cancelasfreestmt=0;extrasystableprefixes=dd_;
            lfconversion=1;updatablecursors=1;disallowpremature=0;trueisminus1=0;bi=0;byteaaslongvarbinary=0;useserversideprepare=0;
            lowercaseidentifier=0;xaopt=1" ProviderName="System.Data.Odbc" SelectCommand="SELECT pmib6706.v.n_v, 
            pmib6706.v.n_izd, pmib6706.j.name, pmib6706.v.date_begin, pmib6706.v.cost FROM pmib6706.v JOIN pmib6706.j ON pmib6706.v.n_izd = pmib6706.j.n_izd
            WHERE pmib6706.v.n_izd IN (SELECT pmib6706.q.n_izd FROM pmib6706.q WHERE pmib6706.q.n_det = ?) 
            ORDER BY pmib6706.v.n_izd, pmib6706.v.date_begin;">
            <SelectParameters>
                <asp:ControlParameter ControlID="pDropDownList" DefaultValue="P1" Name="n_det" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="pDataSource" runat="server" ConnectionString="Dsn=PostgreSQL30;database=students;server=students.ami.nstu.ru;
            port=5432;uid=pmi-b6706;pwd=Ickejev3;sslmode=disable;readonly=0;protocol=7.4;fakeoidindex=0;showoidcolumn=0;rowversioning=0;
            showsystemtables=0;fetch=100;socket=4096;unknownsizes=0;maxvarcharsize=255;maxlongvarcharsize=8190;debug=0;commlog=0;optimizer=0;
            ksqo=1;usedeclarefetch=0;textaslongvarchar=1;unknownsaslongvarchar=0;boolsaschar=1;parse=0;cancelasfreestmt=0;extrasystableprefixes=dd_;
            lfconversion=1;updatablecursors=1;disallowpremature=0;trueisminus1=0;bi=0;byteaaslongvarbinary=0;useserversideprepare=0;
            lowercaseidentifier=0;xaopt=1" ProviderName="System.Data.Odbc" SelectCommand="SELECT pmib6706.p.n_det, 
            pmib6706.p.n_det || ' - ' || pmib6706.p.name AS det_name FROM pmib6706.p;">
        </asp:SqlDataSource>
        
        <h1 class="title">Рекомендованная цена</h1>
        <div class="view task2">
            <div class="box">
                <div class="interface_block">
                    <div>Деталь:</div>
                    <asp:DropDownList ID="pDropDownList" runat="server" AutoPostBack="True" DataSourceID="pDataSource" DataTextField="det_name" DataValueField="n_det">
                    </asp:DropDownList>
                </div>
                <div>Цены на изделия, входящие в состав детали:</div>
                <asp:GridView ID="vGridView" runat="server" DataSourceID="vDataSource" AutoGenerateColumns="false" HorizontalAlign="Center">
                    <Columns>
                        <asp:BoundField DataField="n_v" HeaderText="Номер цены" />
                        <asp:BoundField DataField="n_izd" HeaderText="Номер изделия" />
                        <asp:BoundField DataField="name" HeaderText="Название" />
                        <asp:BoundField DataField="date_begin" HeaderText="Дата начала" DataFormatString="{0:MM/dd/yyyy}" htmlencode="false" />
                        <asp:BoundField DataField="cost" HeaderText="Цена" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="button_block">
                <asp:Button ID="execButton" runat="server" OnClick="execButton_Click" Text="Уменьшить последнюю дату изделия на 1 месяц" />
            </div><br />
            <div class="box">
                <asp:Label ID="infoLabel" runat="server" Text="Выберите деталь!"></asp:Label>
            </div>
            <div class="button_block">
                <asp:Button ID="task1Button" runat="server" OnClick="task1Button_Click" Text="Запрос 1" />
            </div><br />
        </div>
    </form>
</body>
</html>
