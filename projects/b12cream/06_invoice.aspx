<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!DOCTYPE html>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">
	Public TheFullName As String
	Public TheInvoiceNumber As Integer
	Public TheInvoiceDate As String
	Public TheInvoiceStatus As String

	Public III As Integer
	Public NumRows As Integer
	Public TotalItems As Integer
	
    Public ThePrice(1) As Single
    Public TheDesc(1) As String
    Public TheID(1) As String
    Public TheQuantity(1) As String

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("index.aspx")
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

	Sub DoReorder()
	
		ReorderButton.Enabled = False

		Dim TempStr As String
        Dim connA As New SqlConnection(ConnString)
        Dim drA As SqlDataReader
        Dim sqlA As New SqlCommand
		Dim sqlI As New SqlCommand
			Dim FullDesc As String
			Dim ThePrice1,ThePriceC1 As Single
			Dim IsOK As Boolean = True
			Dim TheQuantity As Integer = 1
		Dim TheCount As Integer = 0
		
		connA.Open
   		If Session("OrderID") = "0" Then
	        Dim RandomClass As New Random()
			TempStr = CStr(RandomClass.Next(100000000, 999999999)) & Request.ServerVariables("REMOTE_ADDR") & Now & CStr(RandomClass.Next(100000000, 999999999))
	
			sqlA = New SqlCommand("INSERT INTO [Temporder] (Temp,IP,Date,ClientID,Referer) VALUES ('" & TempStr & "','" & Request.ServerVariables("REMOTE_ADDR") & "','" & Now &"',0,'" & Session("Referer") & "')",connA)
			sqlA.ExecuteNonQuery()
			sqlA = New SqlCommand("SELECT OrderID FROM TempOrder WHERE Temp = '" & TempStr & "'",connA)
			drA = sqlA.ExecuteReader()
			If drA.Read Then
				Session("OrderID") = drA("OrderID")
			End If
			drA.Close
			
			sqlA = New SqlCommand("SELECT Rate FROM Exchange WHERE Currencies='CdnUS'",connA)
			drA = sqlA.ExecuteReader()
			If drA.Read Then
				Session("ExchangeCADUSD") = drA("Rate")
			End If
			drA.Close
		End If


        Dim ThePrice, TheCost, ThePriceC, TheCostC As String

        If Session("InCAD") <> 1 Then
            sqlA = New SqlCommand("SELECT Item.Quantity,Item.ProductID,Item.SSID,Products.Name,ProductDetails.Price,ProductDetails.CostC,ProductDetails.StrengthSize,ProductDetails.SalePrice,ProductDetails.SaleExpiry FROM Item INNER JOIN Products ON Products.ProductID = Item.ProductID INNER JOIN ProductDetails ON ProductDetails.SSID = Item.SSID WHERE Products.ActiveBioSensePharmacy <> 0 AND Item.Invoice = " & SqlEnc(Request.QueryString("I")), connA)
		Else
            sqlA = New SqlCommand("SELECT Item.Quantity,Item.ProductID,Item.SSID,Products.Name,ProductDetails.PriceC,ProductDetails.CostC,ProductDetails.StrengthSize,ProductDetails.SalePriceC,ProductDetails.SaleExpiry FROM Item INNER JOIN Products ON Products.ProductID = Item.ProductID INNER JOIN ProductDetails ON ProductDetails.SSID = Item.SSID WHERE Products.ActiveBioSensePharmacy <> 0 AND Item.Invoice = " & SqlEnc(Request.QueryString("I")), connA)
		End If
        drA = sqlA.ExecuteReader()
           
		While drA.Read
			IsOK = True
			If Session("InCAD") <> 1 Then					
				If NOT IsDBNull(drA("Name")) Then
    	            FullDesc = drA("Name") & " " & drA("StrengthSize")
					If drA("SalePrice") > 0 AND DateDiff("d",drA("SaleExpiry"),Now.Date) < 1 Then
		                ThePrice = drA("SalePrice")
					Else
		                ThePrice = drA("Price")
					End If
        	        TheCostC = drA("CostC")
            	    TheCost = Math.Round(TheCostC * Session("ExchangeCADUSD"), 2)

                	ThePriceC = Math.Round(ThePrice / Session("ExchangeCADUSD"), 2)
				Else
					IsOK = False
				End If

			Else

				If NOT IsDBNull(drA("Name")) Then
	                FullDesc = drA("Name") & " " & drA("StrengthSize")
					If drA("SalePriceC") > 0 AND DateDiff("d",drA("SaleExpiry"),Now.Date) < 1 Then
		                ThePriceC = drA("SalePriceC")
					Else
		                ThePriceC = drA("PriceC")
					End If
	                TheCostC = drA("CostC")
	                TheCost = Math.Round(TheCostC * Session("ExchangeCADUSD"), 2)
	                ThePrice = Math.Round(ThePriceC * Session("ExchangeCADUSD"), 2)
    			Else
					IsOK = False
				End If
			End If
			If ThePrice <= 0 Then
				IsOK = False
			End If
			
   			If IsOK Then
				TheCount = TheCount + 1
				sqlI = New SqlCommand("INSERT INTO TempItem ([Desc],[Quantity],[Price],[PriceC],[CostPrice],[CostPriceC],[ProductID],[OrderID],SSID) VALUES ('" & SqlEnc(FullDesc) & "'," & drA("Quantity") & "," & ThePrice & "," & ThePriceC & "," & TheCost & "," & TheCostC & "," & drA("ProductID") & "," & Session("OrderID") & "," & drA("SSID") & ")", connA)
    		    sqlI.ExecuteNonQuery()
			End If
		
		End While
		
       	sqlI = Nothing
        drA.Close()	
   	    connA.Close()
        drA = Nothing
        connA = Nothing
		If TotalItems <> TheCount Then
			Response.Redirect("04_cart.aspx?E=R")
		Else
			Response.Redirect("04_cart.aspx")
		End If
	End Sub


	Sub Page_Load()
        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
        Dim II As Integer
		Dim TheCurrency As String
        If Session("ClientID") < 1 Then
            Response.Redirect("06_login.aspx")
        End If

	
		conn.Open()
		
        sql = New SqlCommand("SELECT ShipFName,ShipLName,ShipAddress,ShipEmail,ShipCity,ShipState,ShipCountry,ShipZip,ShipPhone,ShipFax,BillFName,BillLName,BillAddress,BillCity,BillState,BillCountry,BillZip,BillPhone,BillFax, Invoice,Fulfill,[Date],ShipType,ShipPriceC,ShipPrice,GrandtotalC,Grandtotal,GSTC,PSTC,GST,PST,InCDN FROM Invoice WHERE Site = " & Session("TheCurrentSite") & " AND ClientID = " & Session("ClientID") & " AND Invoice = " & SqlEnc(Request.QueryString("I")), conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
			If NOT IsDBNull(dr("ShipFName")) Then
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
				If Not IsDBNull(dr("ShipType")) Then
					ShippingType.Text = dr("ShipType")
				End If
				If dr("InCDN") <> 0 Then
					ShippingTotal.Text = FormatCurrency(dr("ShipPriceC"),2)
					OrderTotal.Text = FormatCurrency(dr("GrandtotalC"),2) & " CAD"
					TheCurrency = " CAD"
				Else
					ShippingTotal.Text = FormatCurrency(dr("ShipPrice"),2)
					OrderTotal.Text = FormatCurrency(dr("Grandtotal"),2) & " USD"
					TheCurrency = " USD"
				End If
     			If dr("BillCountry") = "CA" Then
			        PSTDiv.Visible = True
					GSTDiv.Visible = True
					If dr("InCDN") <> 0 Then
						GSTTotal.Text = FormatCurrency(dr("GSTC"),2)
						PSTTotal.Text = FormatCurrency(dr("PSTC"),2)
					Else		
						GSTTotal.Text = FormatCurrency(dr("GST"),2)
						PSTTotal.Text = FormatCurrency(dr("PST"),2)
					End If		
				Else
			        PSTDiv.Visible = False
					GSTDiv.Visible = False
				End If
   			End If
		Else
			Response.Redirect("myaccount.aspx")	
	    
		End If
        dr.Close()
        sql = New SqlCommand("SELECT COUNT(*) As NumRows FROM Item WHERE Invoice = " & SqlEnc(Request.QueryString("I")), conn)
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
 
            If TheCurrency = " USD" Then
                sql = New SqlCommand("SELECT Quantity,[Desc],Price,ID FROM Item WHERE Invoice = " & SqlEnc(Request.QueryString("I")), conn)
            Else
                sql = New SqlCommand("SELECT Quantity,[Desc],PriceC As Price,ID FROM Item WHERE Invoice = " & SqlEnc(Request.QueryString("I")), conn)
            End If
            
            dr = sql.ExecuteReader()
            II = -1
			TotalItems = 0
            While dr.Read
                II = II + 1
                ThePrice(II) = dr("Price")
                TheDesc(II) = dr("Desc")
                TheID(II) = dr("ID")
                TheQuantity(II) = dr("Quantity")
				If dr("Price") > 0 Then
					TotalItems = TotalItems + 1
				End If
            End While
            dr.Close()
            'HidOrderTotal.Text = TheOrderTotal
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
	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Invoice | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Invoice detail that shows all purchase information">

	<!-- Bootstrap -->
	<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- custom css -->
	<link href="css/grid.css" type="text/css" rel="stylesheet">
	<link href="css/main.css" type="text/css" rel="stylesheet">

</head>

<body>
<form runat="server">
	
	<!--#include file="header.aspx"-->

	<div class="grid" id="pageInvoice">
		<div class="col-12of14">
			<h2>Invoice #<%= TheInvoiceNumber %><br/>Date: <%= TheInvoiceDate %></h2>
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
				<p><asp:label id="UserLast" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Email</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserEmail" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Address</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserAddress" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>City</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserCity" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Province</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserState" Columns="40" runat="server"  /></p>
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
				<p><asp:label id="UserCountry" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Phone</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserPhone" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Fax</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="UserFax" Columns="40" runat="server"  /></p>
			</div>
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
				<p><asp:label id="BillLast" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Address</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillAddress" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>City</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillCity" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Province</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillState" Columns="40" runat="server"  /></p>
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
				<p><asp:label id="BillCountry" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Phone</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillPhone" Columns="40" runat="server"  /></p>
			</div>
			<div class="col-4of12">
				<p>Fax</p>
			</div>
			<div class="col-8of12">
				<p><asp:label id="BillFax" Columns="40" runat="server"  /></p>
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
			<asp:Button id="ReorderButton" runat="server" OnClick="DoReorder" CssClass="buy" text="Reorder" />
			<a class="buy cancel" href="06_account.aspx">Back</a>
		</div>
	</div>


	<!--#include file="footer.aspx"-->
	
</form>



<script src="js/ios_doubleTap_disable.js"></script>
</body>
</html>