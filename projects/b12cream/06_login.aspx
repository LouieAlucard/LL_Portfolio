<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">
	Public TheError As String
	'Public TempSql As String
	'Public ThePatientRelease As String

	Protected Function SqlEnc(ByVal a As String) As String
	
		Dim TempS As String = ""
		
		If NOT a is DBNull.Value Then
			TempS = Trim(Replace(a,"'","''"))
			TempS = Replace(TempS,vbCrLf,"")
		End If
		Return TempS
	End Function

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("http://www.b12cream.com/index.aspx")
	End Sub


    
	Protected Sub RetrieveInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim connA As New SqlConnection(ConnString)
        Dim drA As SqlDataReader
        Dim sqlA As New SqlCommand
		RetrieveInfo.Enabled = False
		connA.Open()
        sqlA = New SqlCommand("SELECT ClientID,VIPDiscount,Vendor,ShipFName FROM Clients WHERE ShipEmail='" & SqlEnc(LoginEmail.Text) & "' AND Password='" & SqlEnc(LoginPassword.Text) & "'" , connA)
		drA = sqlA.ExecuteReader()
		If drA.Read Then
			If NOT IsDBNull(drA("ClientID")) Then
				Session("ClientName") = drA("ShipFName")
				Session("ClientID") = drA("ClientID")
				If drA("VIPDiscount") <> 0 Then
					Session("IsVIP") = 1
				End If
				If drA("Vendor") <> 0 Then
					Session("IsVendor") = 1
				End If
				drA.Close
				connA.Close
				drA = nothing
				connA = nothing
				Response.Cookies("BioSense")("Username") = LoginEmail.Text
				Response.Cookies("BioSense").Expires = Now.AddDays(180)
				Response.Redirect("/06_account.aspx")
			Else
				TheError = "Sorry, the username or password you entered was incorrect. Please try again."		
				ErrorLogin.Visible = True
				RetrieveInfo.Enabled = True
                drA.Close()
                connA.Close()
                drA = Nothing
                connA = Nothing
			End If
		Else
				TheError = "Sorry, the username or password you entered was incorrect. Please try again."		
				ErrorLogin.Visible = True			
				RetrieveInfo.Enabled = True
                drA.Close()
                connA.Close()
                drA = Nothing
                connA = Nothing
		End If
	End Sub



	Sub Page_Load()

		If Request.QueryString("L") = "O" Then
			Session.Abandon()
			Session("ClientName") = ""
			Session("ClientID") = 0
			Response.Redirect("/06_login.aspx?O=O")
		End If

		If Session("ClientID") > 0 Then 
			Response.Redirect("/06_account.aspx")
		End If
 
		If NOT IsPostBack Then
			ErrorLogin.Visible = False
	  		If Not Request.Cookies("BioSense") Is Nothing Then
			    LoginEmail.Text = Server.HtmlEncode(Request.Cookies("BioSense")("Username"))
			End If
		End If

		
	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Login | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Login page, login to check your profile such as name and address, also view your order history.">

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

		<div class="grid module-frame" id="pageLogin">
			<div class="col-14of14 header">
				<h5>Existing Customer</h5>

				<% If Request.QueryString("O") = "O" Then 
				Response.Write("<br/><span class=""red"">You have been logged out!</span><br />")
				End If %>
				
				<div class="input-wrapper">
					<label><h3>Email</h3></label>
					<asp:textbox id="LoginEmail" Columns="40" runat="server" maxlength="99" placeholder="Enter Email Address" />			
				</div>
					
				<div class="input-wrapper">
					<label><h3>Password</h3></label>
					<asp:textbox id="LoginPassword" Columns="40" runat="server" TextMode="password" maxlength="99" placeholder="Enter Password" />
				</div>

				<a href="06_forgot.aspx" id="forgot">Forgot Password?</a>
			
				<div id="ErrorLogin" runat="server"><p><b class="red"><%= TheError %></b></p>
				</div>

				<asp:Button CssClass="buy pink" id="RetrieveInfo" runat="server" Text="Login" onclick="RetrieveInfo_Click" />			
			</div>
		</div>

		<!--#include file="footer.aspx"-->

	</form>	

<script src="js/ios_doubleTap_disable.js"></script>
</body>
</html>