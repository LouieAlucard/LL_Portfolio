<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!DOCTYPE html>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("http://www.b12cream.com/index.aspx")
	End Sub


	Sub Page_Load()

        If Session("ClientID") < 1 Then
            Response.Redirect("06_login.aspx")
        End If


        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
        Dim TCCard(2) As String
		
         conn.Open()
		
		sql = New SqlCommand("SELECT ShipFName,ShipLName,ShipAddress,ShipEmail,ShipCity,ShipState,ShipCountry,ShipZip,ShipPhone,ShipFax FROM Clients WHERE ClientID = " & Session("ClientID") , conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
			If NOT IsDBNull(dr("ShipFName")) Then
				'TheFullName = dr("ShipFName") & " " & dr("ShipLName") '
 	
				UserFirst.Text = dr("ShipFName")
 				UserLast.Text = dr("ShipLName")
 				UserAddress.Text = dr("ShipAddress")
 				UserCity.Text = dr("ShipCity")
 				UserZip.Text = dr("ShipZip")
 				UserPhone.Text = dr("ShipPhone")
				If NOT IsDBNull(dr("ShipFax")) Then
	 				UserFax.Text = dr("ShipFax") & "&nbsp;"
				Else
					UserFax.Text = "&nbsp;"
				End If
 				UserCountry.Text = dr("ShipCountry")
 				UserEmail.Text = dr("ShipEmail")
				UserState.Text = dr("ShipState")
			End If
		End If
		dr.Close
		conn.Close
		dr = nothing
		conn = nothing
	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Customer Account | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Customer account main page that contains the profile information">

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

	<div class="grid" id="pageAccount">
		<div class="col-12of14">
			<h2>My Account</h2>
			<a class="buy" href="06_history.aspx">View My Past Purchases</a>
		</div>
		<div class="col-12of14 profile content-no-margin">
			<h5>Profile</h5>
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
			<div class="right">
				<a href="06_change_profile.aspx">Edit Profile</a>
			</div>
		</div>
	</div>


	<!--#include file="footer.aspx"-->

<script src="js/ios_doubleTap_disable.js"></script>
<script src="js/sticky-footer.js"></script>
</body>
</html>