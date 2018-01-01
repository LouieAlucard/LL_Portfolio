<%@ Page Language="VB" %>
<!DOCTYPE html>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">
	Public TheFullName As String
	Public TheInvoiceNumber As Integer
	Public TheInvoiceDate As String
	Public TheInvoiceStatus As String

	Public III As Integer
	Public NumRows As Integer

    Public ThePrice(1) As Single
    Public TheDesc(1) As String
    Public TheID(1) As String
    Public TheQuantity(1) As String

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("http://www.b12cream.com/index.aspx")
	End Sub



    Protected Function SqlEnc(ByVal a As String) As String
	
        Dim TempS As String = ""
		Dim II As Integer
		
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
		Dim theAVSResult As String = ""
        If Session("ClientID") < 1 OR Session("Invoice") < 1 Then
            Response.Redirect("index.aspx")
        End If
		
		conn.Open()

		If Request.QueryString("P") = "P" Then
			 sql = New SqlCommand("Update Invoice SET TransactionID = 'PayPal',Paid=1 WHERE Invoice="  & Session("Invoice"), conn)
			    sql.ExecuteNonQuery()
		End If

		
		If Session("InCAD") = 0 Then
	        PSTDiv.Visible = False
			GSTDiv.Visible = False
			sql = New SqlCommand("SELECT ShipFName,ShipLName,ShipAddress,ShipEmail,ShipCity,ShipState,ShipCountry,ShipZip,ShipPhone,ShipFax,BillFName,BillLName,BillAddress,BillCity,BillState,BillCountry,BillZip,BillPhone,BillFax, Invoice,Fulfill,[Date],ShipType,ShipPrice,Grandtotal,PST,GST,AVSResult FROM Invoice WHERE ClientID = " & Session("ClientID") & " AND Invoice = " & SqlEnc(Session("Invoice")), conn)
		Else
	        PSTDiv.Visible = True
			GSTDiv.Visible = True
	        sql = New SqlCommand("SELECT ShipFName,ShipLName,ShipAddress,ShipEmail,ShipCity,ShipState,ShipCountry,ShipZip,ShipPhone,ShipFax,BillFName,BillLName,BillAddress,BillCity,BillState,BillCountry,BillZip,BillPhone,BillFax, Invoice,Fulfill,[Date],ShipType,ShipPriceC As ShipPrice,GrandtotalC As Grandtotal,GSTC,PSTC,AVSResult FROM Invoice WHERE ClientID = " & Session("ClientID") & " AND Invoice = " & SqlEnc(Session("Invoice")), conn)
		End If			
        dr = sql.ExecuteReader()
        If dr.Read Then
			If NOT IsDBNull(dr("ShipFName")) Then
				If NOT IsDBNull(dr("AVSResult")) Then
					theAVSResult = dr("AVSResult")
				End If
				TheFullName = dr("ShipFName") & " " & dr("ShipLName") 
				TheInvoiceStatus = dr("Fulfill")
				TheInvoiceDate = dr("Date")
				TheInvoiceNumber = dr("Invoice")
 				UserFirst.Text = dr("ShipFName")
 				UserLast.Text = dr("ShipLName")
 				UserAddress.Text = dr("ShipAddress")
 				UserCity.Text = dr("ShipCity")
 				UserState.Text = dr("ShipState")
 				UserZip.Text = dr("ShipZip")
 				UserPhone.Text = dr("ShipPhone")
 				UserFax.Text = dr("ShipFax")
 				UserCountry.Text = dr("ShipCountry")
 				UserEmail.Text = dr("ShipEmail")
 				BillFirst.Text = dr("BillFName")
 				BillLast.Text = dr("BillLName")
 				BillAddress.Text = dr("BillAddress")
 				BillCity.Text = dr("BillCity")
 				BillState.Text = dr("BillState")
 				BillZip.Text = dr("BillZip")
 				BillPhone.Text = dr("BillPhone")
 				BillFax.Text = dr("BillFax")
 				BillCountry.Text = dr("BillCountry")
				ShippingType.Text = dr("ShipType")
				ShippingTotal.Text = FormatCurrency(dr("ShipPrice"),2)
				OrderTotal.Text = FormatCurrency(dr("Grandtotal"),2)
				If Session("InCAD") <> 0 Then
					OrderTotal.Text = OrderTotal.Text & " CAD"
				Else
					OrderTotal.Text = OrderTotal.Text & " USD"				
				End If
     			If dr("BillCountry") = "CA" Then
					If Session("InCAD") <> 0 Then
						GSTTotal.Text = FormatCurrency(dr("GSTC"),2)
						PSTTotal.Text = FormatCurrency(dr("PSTC"),2)
					Else		
						GSTTotal.Text = FormatCurrency(dr("GST"),2)
						PSTTotal.Text = FormatCurrency(dr("PST"),2)
					End If		
				End If
   		End If
			
	    End If
        dr.Close()
        sql = New SqlCommand("SELECT COUNT(*) As NumRows FROM Item WHERE Invoice = " & SqlEnc(Session("Invoice")), conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
            NumRows = dr("NumRows")
        Else
            NumRows = 0
        End If
        dr.Close()
        If NumRows > 0 Then
            ReDim ThePrice(NumRows)
            ReDim TheDesc(NumRows)
            ReDim TheID(NumRows)
            ReDim TheQuantity(NumRows)
 
            If Session("InCAD") = 0 Then
                sql = New SqlCommand("SELECT Quantity,[Desc],Price,ID FROM Item WHERE Invoice = " & SqlEnc(Session("Invoice")), conn)
            Else
                sql = New SqlCommand("SELECT Quantity,[Desc],PriceC As Price,ID FROM Item WHERE Invoice = " & SqlEnc(Session("Invoice")), conn)
            End If
            
            dr = sql.ExecuteReader()
            II = -1
            While dr.Read
                II = II + 1
                ThePrice(II) = dr("Price")
                TheDesc(II) = dr("Desc")
                TheID(II) = dr("ID")
                TheQuantity(II) = dr("Quantity")
            End While
            dr.Close()
            'HidOrderTotal.Text = TheOrderTotal
        End If        

		If InStr("do not match",theAVSResult) > 0 OR InStr("does not match",theAVSResult) > 0 Then
			sql = New SqlCommand("INSERT INTO Fulfillment (Invoice,Type,Date,Note) VALUES (" & Session("Invoice") & ",'Warning','" & Now & "','Automated: AVS Warning: " & sqlEnc(theAVSResult) & "'", conn)
			Try
			sql.ExecuteNonQuery()
			Catch Ex As Exception
			End Try
		End If

		'Dim IPAddr As String = Request.ServerVariables("REMOTE_ADDR")
		'Dim FullURL As String = "BiosensePharmacy.com" & Request.ServerVariables("URL") & "?" & Request.ServerVariables("QUERY_STRING")
		'Dim UserAgent As String = Request.ServerVariables("HTTP_USER_AGENT")
		'Dim TSql As String  = "INSERT INTO WebLogs ([Date],[Referer],[IP],[URL],[UserAgent],[NewSession],[Engine],[Country],[Notes]) VALUES ('" & Now & "','" & SqlEnc(Session("Referer")) & "','" & IPAddr & "','" & SqlEnc(FullURL) & "','" & SqlEnc(UserAgent) & "'," & Session("NewSession") & ",'" & Session("SearchEngine") & "','" & Session("Country") & "','" & SqlEnc(UserFirst.Text & " " & UserLast.Text) & "')"
		'sql = New SqlCommand(TSql, conn)
		'sql.ExecuteNonQuery()
		'Session("NewSession") = 0

		conn.Close
		dr = nothing
		sql = nothing
		conn = nothing
		Session.Abandon()
	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Thank you | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Thank you page that also contains the summary information of customer's order including purchased products. shipping and billing information ">

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

	<div class="grid module-frame" id="pageOrdered">
		<div class="col-14of14 header">
			<h5>Order Confirmed</h5>
			<h4>Thank you for purchasing our product. Please <a class="facebook-like" href="https://www.facebook.com/pages/B12-Cream/1617578868455223?fref=ts" target="_blank">LIKE</a> us on Facebook for future special and free giveways!</h4>
			<div class="social-media">
				<ul>
					<li><a href="https://www.facebook.com/pages/B12-Cream/1617578868455223?fref=ts" target="_blank" title="B12 Plus+ cream Facebook page">
						<img src="img/media_facebook.png" alt="" title="Facebook icon">
					</a></li>
					<li><a href="https://instagram.com/b12cream/" target="_blank" title="B12 Plus+ cream Instagram account">
						<img src="img/media_instagram.png" alt="" title="Instagram icon">
					</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="grid">


		<div class="col-12of14 profile info">
			<p>The following is the invoice for your order. please print this page for your records. This invoice has also been sent to your email address. Credit card charges will appear as Biosense Compounding Pharmacy.</p>
			<h3><strong>Invoice #<%= TheInvoiceNumber %></strong></h3>
        </div>
		<div class="col-12of14 profile info">
			
			<h5>Shipping Information</h5>
			<div class="col-4of12">
				<p>First Name</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserFirst" Columns="40" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Last Name</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserLast" Columns="40" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Address</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserAddress" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>City</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserCity" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Province</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserState" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Postal Code</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserZip" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Country</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserCountry" Columns="60" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Phone</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserPhone" Columns="20" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Fax</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserFax" Columns="20" runat="server" />&nbsp;</p>
			</div>
			<div class="col-4of12">
				<p>Email</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserEmail" Columns="60" runat="server"  /></p>
			</div>
		</div>

		<div class="col-12of14 profile">
			<h3><strong>Order Date: <%= TheInvoiceDate %></strong></h3>
		</div>

		<div class="col-12of14 profile info">
			<h5>Billing Information</h5>
			<div class="col-4of12">
				<p>First Name</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillFirst" Columns="40" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Last Name</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillLast" Columns="40" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Address</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillAddress" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>City</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillCity" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Province</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillState" Columns="60" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Postal Code</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillZip" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Country</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillCountry" Columns="60" runat="server" /></p>
			</div>
			<div class="col-4of12">
				<p>Phone</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillPhone" Columns="20" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Fax</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillFax" Columns="20" runat="server" />&nbsp;</p>
			</div>
		</div>

		<div class="col-12of14 profile info">
			<h5>Order Detail / Item Descriptions</h5>
			<% 
				If NumRows > 0 Then
				For III = 0 To NumRows - 1
			%>	
				<div class="col-10of12">
					<p><%= TheQuantity(III) & " " & TheDesc(III) %></p>
				</div>
				<div class="col-2of12">
					<p><%= FormatCurrency(ThePrice(III) * TheQuantity(III),2) %></p>
				</div>
			<% Next
			End If %>
		</div>

		<div class="col-12of14 profile info">
			<div class="col-6of12">
				<p>Shipping Type</p>
			</div>
			<div class="col-6of12">
				<p><asp:label id="ShippingType" runat="server"/></p>
			</div>
			<div class="col-6of12">
				<p>Shipping Price</p>
			</div>
			<div class="col-6of12">
				<p><asp:Label id="ShippingTotal" runat="server"/></p>
			</div>
			<div id="GSTDiv" runat="server">
	            <div class="col-6of12">
					<p>GST/HST</p>
				</div>
				<div class="col-6of12">
					<p><asp:Label id="GSTTotal" runat="server"/></p>
				</div>
            </div>
			<div id="PSTDiv" runat="server">
	            <div class="col-6of12">
					<p>PST</p>
				</div>
				<div class="col-6of12">
					<p><asp:Label id="PSTTotal" runat="server"/></p>
				</div>
            </div>
			<div class="col-6of12">
				<p>Grand Total</p>
			</div>
			<div class="col-6of12">
				<p><asp:Label id="OrderTotal" runat="server" /></p>
			</div>
		</div>

		<div class="col-12of14 profile">
			<p>Please allow for sufficient time for the delivery of your package due to increased security and unexpected delays at customs. if you have questions about your order, please email us at contact@b12cream.com with your invoice number.</p>
		</div>
	</div>


	<!--#include file="footer.aspx"-->

<script src="js/ios_doubleTap_disable.js"></script>
</body>
</html>