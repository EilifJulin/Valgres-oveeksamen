<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="valgres.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fylkesvalg Resultat 2025</title>
    <style>
        .header {
            background-color: #004080;
            padding: 30px;
            text-align: center;
            color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .header h1 {
            font-size: 48px;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            letter-spacing: 1px;
        }

        .votetable {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .votetable asp\:DropDownList,
        .votetable asp\:TextBox,
        .votetable asp\:Button {
            margin: 10px 0;
            width: 80%;
            padding: 8px;
            font-size: 16px;
        }

        .votetable asp\:Label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        .votetable input[type="submit"] {
            background-color: #004080;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .votetable input[type="submit"]:hover {
            background-color: #0066cc;
        }

        .styled-grid {
            margin: 20px auto;
            width: 100%;
            border-collapse: collapse;
            font-family: 'Segoe UI', sans-serif;
        }

        .styled-grid th {
            background-color: #004080;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .styled-grid td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }

        .styled-grid tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Fylkesvalg resultat 2025</h1>
    </div>
    <form id="form1" runat="server">
        <div class="votetable">
            <asp:GridView ID="GridView1" runat="server" CssClass="styled-grid"></asp:GridView>

            <asp:DropDownList ID="ddlValg" runat="server"></asp:DropDownList>
            <br />
            <asp:DropDownList ID="ddlRegion" runat="server"></asp:DropDownList>
            <br />
            <asp:TextBox ID="txtVotes" runat="server" placeholder="Antall stemmer"></asp:TextBox>
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Oppdater" OnClick="btnUpdate_Click" />
            <br />
            <asp:Label ID="lblStatus" runat="server" ForeColor="Green" />
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="true" CssClass="styled-grid" />
        </div>
    </form>
</body>
</html>
