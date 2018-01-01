<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">

	Public TheGrandtotal As Single
	Public TheCurrency As String
	Public TheFullName As String
	
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
     	'If Session("ClientID") < 1 Then
      		'Response.Redirect("/viewcart.aspx")
       	'End If
		If Request.QueryString("custom") = "returned" or Request.Form("custom") = "returned" Then
			Response.Redirect("https://www.b12cream.com/04_thankyou.aspx?P=P")
		End If		


        conn.Open()
        'Start check cart for items
        sql = New SqlCommand("SELECT Grandtotal,GrandtotalC,ShipFName + ' ' + ShipLName As FullName From Invoice WHERE Invoice=" & Session("Invoice"), conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
			If Session("InCAD") = 0 Then
				TheGrandtotal = dr("Grandtotal")
				TheCurrency = "USD"
				TheFullName = dr("FullName")
			Else
				TheGrandtotal = dr("GrandtotalC")
				TheCurrency = "CAD"
				TheFullName = dr("FullName")
			End If
        Else
            dr.close()
            Conn.Close()
            dr = Nothing
            conn = Nothing
            Response.Redirect("http:/www.b12cream.com/index.aspx")

        End If
		
		
    End Sub
</script>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Check out by PayPal| Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="check out page using PayPal as billing method">

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


	<div class="grid shopping-cart" id="pageCheckout">
		<div class="col-12of14">
			<h1>Redirecting to PayPal... If you are not redirected within 10 seconds, click the button below.</h1>
		</div>

		<div class="col-12of14 log-in">
			<form name="checkout" id="checkout" action="https://www.paypal.com/cgi-bin/webscr" method="post">
				<input type="hidden" name="cmd" value="_cart">
				<input type="hidden" name="upload" value="1">
				<input type="hidden" name="business" value="rx@biosensepharmacy.com">
				<input type="hidden" name="item_name_1" value="B12Cream.com Invoice <%= Session("Invoice") %>">
				<input type="hidden" name="amount_1" value="<%= TheGrandtotal %>">
				<input type="hidden" name="currency_code" value="<%= TheCurrency %>">
				<input type="hidden" name="invoice" value="<%= Session("Invoice") %>">
				<input type="hidden" name="return" value="https://www.biosensehealth.com/thankyou.aspx?P=P">
				<input type="hidden" name="custom" value="returned">
				<input type="hidden" name="img_url" value="https://www.biosenseclinical.com/Images/150x50paypal.png">
				<input type="hidden" name="cpp_cart_border_color" value="74ba00">
				<input type="hidden" name="cpp_logo_image" value="https://www.biosenseclinical.com/Images/150x50paypal.png">
				<input type="hidden" name="no-note" value="1">
				<input type="hidden" name="no-shipping" value="1">
				<input type="submit" value="Continue to PayPal">
			</form>
		</div>



	</div>


	<!--#include file="footer.aspx"-->
	


<script src="js/ios_doubleTap_disable.js"></script>
<script LANGUAGE="JavaScript">
	setTimeout('document.checkout.submit()',1000);
</script>

</body>
</html>