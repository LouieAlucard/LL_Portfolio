<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!DOCTYPE html>
<!--#include file="/conn/conn.aspx"-->
<script language="vb" runat="server">

	Public TheFullName As String
	Public TheInvoiceNumber(1) As Integer
	Public TheInvoiceDate(1) As String
	Public TheInvoiceStatus(1) As String
	Public TheInvoiceTotal(1) As Single
	Public TheInvoiceCurrency(1) As String
	Public III As Integer
	Public NumRows As Integer
	Public TheError As String = ""

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("http://www.b12cream.com/index.aspx")
	End Sub

    Protected Function SqlEnc(ByVal a As String) As String
	
        Dim TempS As String = ""
		
        If Not a Is DBNull.Value Then
            TempS = Trim(Replace(a, "'", "''"))
            TempS = Replace(TempS, vbCrLf, "")
        End If
        Return TempS
    End Function
	
 
	Sub Page_Load()
        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
        Dim II As Integer
		Dim TempStr(2) As String
		
        If Session("ClientID") < 1 Then
            Response.Redirect("06_login.aspx")
        End If
 		
        conn.Open()

        sql = New SqlCommand("SELECT COUNT(*) As NumRows FROM Invoice WHERE Site = " & Session("TheCurrentSite") & " AND Deleted = 0 AND ClientID = " & Session("ClientID"), conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
            NumRows = dr("NumRows")
        Else
            NumRows = 0
        End If
        dr.Close()

 

        If NumRows > 0 Then
			ReDim TheInvoiceNumber(NumRows)
			ReDim TheInvoiceDate(NumRows)
			ReDim TheInvoiceStatus(NumRows)
			ReDim TheInvoiceTotal(NumRows)
 			ReDim TheInvoiceCurrency(NumRows)
                
				sql = New SqlCommand("SELECT Invoice,[Date],Fulfill,Grandtotal,GrandtotalC, InCDN FROM Invoice WHERE Site = " & Session("TheCurrentSite") & " AND Deleted = 0 AND ClientID = " & Session("ClientID") & " ORDER BY [Date] DESC", conn)
            
            dr = sql.ExecuteReader()

            II = -1
            While dr.Read
                II = II + 1
                If NOT IsDBNull(dr("Grandtotal")) Then
					If dr("InCDN") <> 0 Then
						TheInvoiceTotal(II) = dr("GrandtotalC")
						TheInvoiceCurrency(II) = " CAD"
					Else
						TheInvoiceTotal(II) = dr("Grandtotal")
						TheInvoiceCurrency(II) = " USD"
					End If
	                TempStr = Split(dr("Date")," ")
					TheInvoiceDate(II) = TempStr(0)
	                TheInvoiceStatus(II) = dr("Fulfill")
					TheInvoiceNumber(II) = dr("Invoice")
				End If
            End While
            dr.Close()
            conn.Close()
            dr = Nothing
            conn = Nothing

        End If
              
	End Sub

</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Order History | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Customer order history list">

	<!-- Bootstrap -->
	<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- custom css -->
	<link href="css/grid.css" type="text/css" rel="stylesheet">
	<link href="css/main.css" type="text/css" rel="stylesheet">

</head>

<body>
	<!--#include file="header.aspx"-->

	<div class="grid" id="pageHistory">
		<div class="col-12of14">
			<h2>My Account</h2>
			<a href="06_account.aspx"><button class="buy">Back to Profile</button></a>
		</div>
		<div class="col-12of14 profile">
			<h5>Order History</h5>
			<div class="col-3of12">
				<h3><strong>Invoice</strong></h3>
			</div>
			<div class="col-3of12">
				<h3><strong>Date</strong></h3>
			</div>
			<div class="col-3of12">
				<h3><strong>Total</strong></h3>
			</div>
			<div class="col-3of12">
				<h3><strong>Status</strong></h3>
			</div>

			<% For III = 0 To NumRows - 1 
			%>
	    		<div class="col-3of12">
					<h3><a href="06_invoice.aspx?I=<%= TheInvoiceNumber(III) %>"><%= TheInvoiceNumber(III) %></a></h3>
				</div>
				<div class="col-3of12">
					<h3><%= TheInvoiceDate(III) %></h3>
				</div>
				<div class="col-3of12">
					<h3><%= FormatCurrency(TheInvoiceTotal(III),2) & TheInvoiceCurrency(III) %></h3>
				</div>
				<div class="col-3of12">
					<h3><%= TheInvoiceStatus(III) %></h3>
				</div>
			<% Next %>
		</div>
	</div>


	<!--#include file="footer.aspx"-->

<script src="js/ios_doubleTap_disable.js"></script>
<script src="js/sticky-footer.js"></script>
</body>
</html>