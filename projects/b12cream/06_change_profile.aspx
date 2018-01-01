<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!DOCTYPE html>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">
    Public TheError As String
	Public TheFullName As String
	Public PasswordError As String = ""
	Public PersonalError As String = ""
	Public CCError As String = ""

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("index.aspx")
	End Sub
  
     Protected Function ValidateEmail(ByVal a As String) As Boolean
        
        If InStr(a, "@") < 3 And InStr(a, ".") < 4 Then
            Return False
        Else
            Return True
        End If
    
    End Function

	Protected Function ValidatePassword(ByVal a As String) As Boolean

        Dim CheckUpper As New System.Text.RegularExpressions.Regex("[A-Z]")
        Dim CheckLower As New System.Text.RegularExpressions.Regex("[a-z]")
        Dim CheckNum As New System.Text.RegularExpressions.Regex("[0-9]")
		Dim CheckSym As New System.Text.RegularExpressions.Regex("[!-/]")
		Dim CheckSym2 As New System.Text.RegularExpressions.Regex("[:-@]")
		Dim AnyErrors As Boolean = False
		
       If Len(a) < 8 Then
            AnyErrors = True
            PasswordError = "Password must be at least 8 characters long. "
        End If

        If CheckUpper.Matches(a).Count < 1 AND CheckLower.Matches(a).Count < 1 Then
            AnyErrors = True
            PasswordError = PasswordError & "At least one letter is required. "
        End If

        If CheckNum.Matches(a).Count < 1 Then
            AnyErrors = True
            PasswordError = PasswordError & "At least one number is required. "
        End If

        If CheckSym.Matches(a).Count < 1 AND CheckSym2.Matches(a).Count < 1 Then
            AnyErrors = True
            PasswordError = PasswordError & "At least one symbol is required. "
        End If
		
		If AnyErrors Then 
			Return False
		Else
			Return True
		End If

	End Function


    Protected Function SqlEnc(ByVal a As String) As String
	
        Dim TempS As String = ""
		
        If Not a Is DBNull.Value Then
            TempS = Trim(Replace(a, "'", "''"))
            TempS = Replace(TempS, vbCrLf, "")
        End If
        Return TempS
    End Function


    Protected Sub UpdateInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim TSql As String
		Dim AnyErrors As Boolean = False
        Dim EmailError As Boolean = False
        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand


		If UserFirst.Text = "" Then
            LabelFirst.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelFirst.CssClass = "ErrorNormalLabel"
		End If

		If UserLast.Text = "" Then
			LabelLast.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelLast.CssClass = "ErrorNormalLabel"
		End If

		If UserEmail.Text = "" Then
			LabelEmail.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			If ValidateEmail(UserEmail.Text) Then 
				LabelEmail.CssClass = "ErrorNormalLabel"
			Else
			LabelEmail.CssClass = "ErrorRedLabel"
			EmailError = True
			End If
		End If

		If UserAddress.Text = "" Then
			LabelAddress.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelAddress.CssClass = "ErrorNormalLabel"
		End If
		
		If UserCity.Text = "" Then
			LabelCity.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelCity.CssClass = "ErrorNormalLabel"
		End If

			If UserState.SelectedItem.Value = "none" Then
                    LabelState.CssClass = "ErrorRedLabel"
					AnyErrors = True
			Else
                    LabelState.CssClass = "ErrorNormalLabel"
			End If
		
		If UserZip.Text = "" Then
			LabelZip.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelZip.CssClass = "ErrorNormalLabel"
		End If
		
		If UserPhone.Text = "" Then
			LabelPhone.CssClass = "ErrorRedLabel"
			AnyErrors = True
		Else
			LabelPhone.CssClass = "ErrorNormalLabel"
		End If

		If AnyErrors Then
			ErrorDiv.Visible = True
			PersonalError = "There is missing information."
		Else
			ErrorDiv.Visible = True
			PersonalError = "Information updated."
 	       TSql = "Update Clients SET ShipFName='" & UserFirst.Text & "',ShipLName='" & UserLast.Text & "',ShipAddress='" & UserAddress.Text & "',ShipCity='" & UserCity.Text & "',ShipZip='" & UserZip.Text & "',ShipPhone='" & UserPhone.Text & "',ShipEmail='" & UserEmail.Text & "'"

    	    If UserFax.Text <> "" Then
	            TSql = TSql & ",ShipFax='" & UserFax.Text & "'"
	        End If

            TSql = TSql & ",ShipState='" & UserState.SelectedItem.Value & "'"
		
    	    TSql = TSql & " WHERE ClientID=" & Session("ClientID")
        	conn.Open()
	        sql = New SqlCommand(TSql, conn)
	        sql.ExecuteNonQuery()
	        conn.Close()
	        sql = Nothing
	        conn = Nothing

		End If


	End Sub


    Protected Sub UpdatePassword_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim TSql As String
		Dim AnyErrors As Boolean = False
        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
        

            If Password.Text = "" Then
                LabelPassword.CssClass = "ErrorRedLabel"
                AnyErrors = True
				PasswordError = "Password blank. "
            Else
                LabelPassword.CssClass = "ErrorNormalLabel"
            End If

            If Confirm.Text = "" Then
				LabelConfirm.CssClass = "ErrorRedLabel"
                AnyErrors = True
				PasswordError = PasswordError & "Confirm password blank."
            Else
                If Password.Text <> Confirm.Text Then
	                AnyErrors = True
					PasswordError = "Passwords do not match."
                Else
					If NOT ValidatePassword(Password.Text) Then
						AnyErrors = True
					End If
            	End If
			End If

		If AnyErrors Then
			ErrorDivPassword.Visible = True
		Else
			ErrorDivPassword.Visible = True
			PasswordError = "Password updated."
 	        TSql = "Update Clients SET Password='" & Password.Text & "' WHERE ClientID=" & Session("ClientID")
        	conn.Open()
	        sql = New SqlCommand(TSql, conn)
	        sql.ExecuteNonQuery()
	        conn.Close()
	        sql = Nothing
	        conn = Nothing
			Password.Text = ""
			Confirm.Text = ""
		End If

	End Sub
	   
	Sub Page_Load()

        If Session("ClientID") < 1 Then
            Response.Redirect("06_login.aspx")
        End If
	 	Page.MaintainScrollPositionOnPostback=True

        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
        Dim TCCard(2) As String
		
         conn.Open()
		
		If NOT IsPostBack Then
		ErrorDiv.Visible = False
		sql = New SqlCommand("SELECT ShipFName,ShipLName,ShipAddress,ShipEmail,ShipCity,ShipState,ShipCountry,ShipZip,ShipPhone,ShipFax FROM Clients WHERE ClientID = " & Session("ClientID") , conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
			If NOT IsDBNull(dr("ShipFName")) Then
				TheFullName = dr("ShipFName") & " " & dr("ShipLName") 
 	
				UserFirst.Text = dr("ShipFName")
 				UserLast.Text = dr("ShipLName")
 				UserAddress.Text = dr("ShipAddress")
 				UserCity.Text = dr("ShipCity")
 				UserZip.Text = dr("ShipZip")
 				UserPhone.Text = dr("ShipPhone")
				If NOT IsDBNull(dr("ShipFax")) Then
	 				UserFax.Text = dr("ShipFax")
				End If
 				UserCountry.Text = dr("ShipCountry")
 				UserEmail.Text = dr("ShipEmail")
				UserState.SelectedValue = dr("ShipState")
			End If
		End If
		dr.Close
		conn.Close
		dr = nothing
		conn = nothing
       Else
		sql = New SqlCommand("SELECT ShipFName,ShipLName FROM Clients WHERE ClientID = " & Session("ClientID") , conn)
        dr = sql.ExecuteReader()
        If dr.Read Then
			If NOT IsDBNull(dr("ShipFName")) Then
				TheFullName = dr("ShipFName") & " " & dr("ShipLName") 
	  		End If
		End If	

		dr.Close
		conn.Close
		dr = nothing
		conn = nothing
	   End If
		
	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Profile Edit | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Page for customers to change their profile information">

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


		<div class="grid" id="pageAccount">
			<div class="col-12of14">
				<h2>My Account</h2>
			</div>
			<div class="col-12of14 profile no-margin">
				<h5>Personal Information</h5>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelFirst" Text="First Name" runat="server" /></h3></label>
					<asp:textbox id="UserFirst" Columns="40" runat="server" />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelLast" Text="Last Name" runat="server" /></h3></label>
					<asp:textbox id="UserLast" Columns="40" runat="server"  />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelAddress" Text="Address" runat="server" /></h3></label>
					<asp:textbox id="UserAddress" Columns="60" runat="server"  />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelCity" Text="City" runat="server" /></h3></label>
					<asp:textbox id="UserCity" Columns="60" runat="server"  />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelState" Text="State/Province" runat="server" /></h3></label>
					<asp:DropDownList id="UserState" width="123" runat="server" >
		                <asp:ListItem value="none" Text="Select a State..." />
		                <asp:ListItem value="--" Text="Outside US/Canada" />
		                <asp:ListItem value="AB" Text="Alberta" />
		                <asp:ListItem value="BC" Text="British Columbia" />
		                <asp:ListItem value="MB" Text="Manitoba" />
		                <asp:ListItem value="NB" Text="New Brunswick" />
		                <asp:ListItem value="NL" Text="Newfoundland/Labrador" />
		                <asp:ListItem value="NS" Text="Nova Scotia" />
		                <asp:ListItem value="NT" Text="Northwest Territories" />
		                <asp:ListItem value="NU" Text="Nunavut" />
		                <asp:ListItem value="ON" Text="Ontario" />
		                <asp:ListItem value="PE" Text="Price Edward Island" />
		                <asp:ListItem value="QC" Text="Quebec" />
		                <asp:ListItem value="SK" Text="Saskatchewan" />
		                <asp:ListItem value="YT" Text="Yukon" />
		                <asp:ListItem value="AK" Text="AK-Alaska" />
		                <asp:ListItem value="AL" Text="AL-Alabama" />
		                <asp:ListItem value="AR" Text="AR-Arkansas" />
		                <asp:ListItem value="AZ" Text="AZ-Arizona" />
		                <asp:ListItem value="CA" Text="CA-California" />
		                <asp:ListItem value="CO" Text="CO-Colorado" />
		                <asp:ListItem value="CT" Text="CT-Connecticut" />
		                <asp:ListItem value="DC" Text="DC-District of Columbia" />
		                <asp:ListItem value="DE" Text="DE-Delaware" />
		                <asp:ListItem value="FL" Text="FL-Florida" />
		                <asp:ListItem value="GA" Text="GA-Georgia" />
		                <asp:ListItem value="HI" Text="HI-Hawaii" />
		                <asp:ListItem value="IA" Text="IA-Iowa" />
		                <asp:ListItem value="ID" Text="ID-Idaho" />
		                <asp:ListItem value="IL" Text="IL-Illinois" />
		                <asp:ListItem value="IN" Text="IN-Indiana" />
		                <asp:ListItem value="KS" Text="KS-Kansas" />
		                <asp:ListItem value="KY" Text="KY-Kentucky" />
		                <asp:ListItem value="LA" Text="LA-Louisiana" />
		                <asp:ListItem value="MA" Text="MA-Massachusetts" />
		                <asp:ListItem value="MD" Text="MD-Maryland" />
		                <asp:ListItem value="ME" Text="ME-Maine" />
		                <asp:ListItem value="MI" Text="MI-Michigan" />
		                <asp:ListItem value="MN" Text="MN-Minnesota" />
		                <asp:ListItem value="MO" Text="MO-Missouri" />
		                <asp:ListItem value="MS" Text="MS-Mississippi" />
		                <asp:ListItem value="MT" Text="MT-Montana" />
		                <asp:ListItem value="NC" Text="NC-North Carolina" />
		                <asp:ListItem value="ND" Text="ND-North Dakota" />
		                <asp:ListItem value="NE" Text="NE-Nebraska" />
		                <asp:ListItem value="NH" Text="NH-New Hampshire" />
		                <asp:ListItem value="NV" Text="NV-Nevada" />
		                <asp:ListItem value="NJ" Text="NJ-New Jersey" />
		                <asp:ListItem value="NM" Text="NM-New Mexico" />
		                <asp:ListItem value="NY" Text="NY-New York" />
		                <asp:ListItem value="OH" Text="OH-Ohio" />
		                <asp:ListItem value="OK" Text="OK-Oklahoma" />
		                <asp:ListItem value="OR" Text="OR-Oregon" />
		                <asp:ListItem value="PA" Text="PA-Pennsylvania" />
		                <asp:ListItem value="RI" Text="RI-Rhode Island" />
		                <asp:ListItem value="SC" Text="SC-South Carolina" />
		                <asp:ListItem value="SD" Text="SD-South Dakota" />
		                <asp:ListItem value="TN" Text="TN-Tennessee" />
		                <asp:ListItem value="TX" Text="TX-Texas" />
		                <asp:ListItem value="UT" Text="UT-Utah" />
		                <asp:ListItem value="VA" Text="VA-Virginia" />
		                <asp:ListItem value="VI" Text="VI-Virgin Islands" />
		                <asp:ListItem value="VT" Text="VT-Vermont" />
		                <asp:ListItem value="WA" Text="WA-Washington" />
		                <asp:ListItem value="WI" Text="WI-Wisconsin" />
		                <asp:ListItem value="WV" Text="WV-West Virginia" />
		                <asp:ListItem value="WY" Text="WY-Wyoming" />
					</asp:DropDownList>
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelZip" Text="Zip/Postal Code" runat="server" /></h3></label>
					<asp:textbox id="UserZip" Columns="40" runat="server"  />
				</div>
				<div class="input-wrapper">
					<label><h3>Country</h3></label>
					<asp:textbox id="UserCountry" Columns="60" runat="server" readonly="true" />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelPhone" Text="Phone" runat="server" /></h3></label>
					<asp:textbox id="UserPhone" Columns="20" runat="server"  />
				</div>
				<div class="input-wrapper">
					<label><h3>Fax</h3></label>
					<asp:textbox id="UserFax" Columns="20" runat="server" />
				</div>
				<div class="input-wrapper">
					<label><h3><asp:Label id="LabelEmail" Text="Email" runat="server" /></h3></label>
					<asp:textbox id="UserEmail" Columns="60" runat="server"  />
				</div>
			</div>
			<div class="col-12of14 profile">
				<div class="red" id="ErrorDiv" runat="server" ><%= PersonalError %></div>

				<asp:Button id="UpdateInfo" Text="Update" CssClass="buy" runat="server" onClick="UpdateInfo_Click"/>

				<a class="buy cancel" href="06_account.aspx">Back</a>
			</div>

			<div class="col-12of14 profile no-margin">
				<h5>Change Password</h5>
				<div class="input-wrapper">
					<h3><asp:Label id="LabelPassword" runat="server" Text="New Password" /></h3>
					<asp:textbox id="Password" Columns="40" runat="server" TextMode="password" maxlength="40" />
				</div>
				<div class="input-wrapper">
					<h3><asp:Label id="LabelConfirm" runat="server" Text="Confirm" /></h3>
					<asp:textbox id="Confirm" Columns="40" runat="server" TextMode="password" maxlength="40" />
				</div>
				
			</div>
			<div class="col-12of14 profile">
				<div class="red" id="ErrorDivPassword" runat="server" ><%= PasswordError %></div>

				<asp:Button id="UpdatePassword" Text="Change" CssClass="buy" runat="server" onClick="UpdatePassword_Click" />
				<a class="buy cancel" href="06_account.aspx">Back</a>
			</div>
		</div>

		<!--#include file="footer.aspx"-->

	</form>

<script src="js/ios_doubleTap_disable.js"></script>
</body>
</html>