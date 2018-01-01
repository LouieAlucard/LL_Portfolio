<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<%@ Import Namespace="System.Net.Mail" %>
<!--#include file="/conn/conn.aspx"-->
<script language="VB" runat="server">
    Public TheError As String = ""
    Public TheEmailText As String = ""

	Protected Overrides Sub OnError(ByVal e as System.EventArgs) 
		Response.Redirect("http://www.b12cream.com/index.aspx")
	End Sub

    Protected Function GetFileContents(ByVal FullPath As String, Optional ByRef ErrInfo As String = "") As String

        Dim strContents As String
        Dim objReader As System.IO.StreamReader
        Try

            objReader = New System.IO.StreamReader(FullPath)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            Return strContents
        Catch Ex As Exception
            ErrInfo = Ex.Message
        End Try
    End Function

    Protected Sub SendEmail(ByVal message, ByVal who)
        Dim TheSubject As String = "Password Request From " & Session("CompanyName")
		Dim iMsg As New MailMessage()

		iMsg.To.Add (New MailAddress(who))
		iMsg.From = New MailAddress("order@biosensehealth.com")
		iMsg.Subject = TheSubject
		iMsg.Body = TheEmailText
		iMsg.IsBodyHTML = True
		iMsg.Priority = MailPriority.Normal

		Dim iSMTP As New SmtpClient

		Try
		iSMTP.Send(iMsg)
		Catch Ex As Exception
		End Try


		iSMTP = nothing
		iMsg = nothing


    End Sub

	Protected Function SqlEnc(ByVal a As String) As String
	
		Dim TempS As String = ""
		
		If NOT a is DBNull.Value Then
			TempS = Trim(Replace(a,"'","''"))
			TempS = Replace(TempS,vbCrLf,"")
		End If
		Return TempS
	End Function
	
    
    Protected Function ValidateEmail(ByVal a As String) As Boolean
        
        If InStr(a, "@") < 3 And InStr(a, ".") < 4 Then
            Return False
        Else
            Return True
        End If
    
    End Function

	Protected Function RetreivePassword(theemail As String) As Boolean
        Dim connA As New SqlConnection(ConnString)
        Dim drA As SqlDataReader
        Dim sqlA As New SqlCommand
        'SubmitButt.Enabled = False
        connA.Open()
        sqlA = New SqlCommand("SELECT ShipFName,ShipLName,Password,OrdersPlaced FROM Clients WHERE ShipEmail='" & SqlEnc(theemail) & "'", connA)
        drA = sqlA.ExecuteReader()
        If drA.Read Then
            If Not IsDBNull(drA("Password")) Then
                
				If drA("OrdersPlaced") < 1 Then					
	                Return False
	                drA.Close()
	                connA.Close()
	                drA = Nothing
	                connA = Nothing
				Else
					TheEmailText = GetFileContents(Server.MapPath("/") & "\email_forgot.html")
	                TheEmailText = (Replace(TheEmailText, "{{ShipFName}}", drA("ShipFName")))
	                TheEmailText = (Replace(TheEmailText, "{{ShipLName}}", drA("ShipLName")))
	                TheEmailText = (Replace(TheEmailText, "{{Password}}", drA("Password")))
	                TheEmailText = (Replace(TheEmailText, "{{ShipEmail}}", theemail))
	                SendEmail(TheEmailText, theemail)
	                drA.Close()
	                connA.Close()
	                drA = Nothing
	                connA = Nothing
	                Return True
				End If
            Else
                Return False
                drA.Close()
                connA.Close()
                drA = Nothing
                connA = Nothing
            End If
        Else
            Return False
            drA.Close()
            connA.Close()
            drA = Nothing
            connA = Nothing
        End If

       ' SubmitButt.Enabled = True

    End Function


    Protected Sub SubmitButt_Click(ByVal sender As Object, ByVal e As System.EventArgs)
            
        If EmailAddress.Text = "" Then
            TheError = "Email address cannot be blank"
        Else
            If Len(EmailAddress.Text) < 8 Then
                TheError = "Email address not valid: too short"
            Else
                If ValidateEmail(EmailAddress.Text) Then
                    If RetreivePassword(EmailAddress.Text) Then
                        TheError = "Your password has been sent."
                    Else
                        TheError = "That email address does not exist"
                    End If
                Else
                    TheError = "Enter a valid email address (eg. name@domain.com)"
                End If
            End If
        End If
    
    End Sub
  
 	Sub Page_Load()

 		If Request.QueryString("E") <> "" Then

                If ValidateEmail(Request.QueryString("E")) Then
                    If RetreivePassword(Request.QueryString("E")) Then
                        TheError = "Your password has been sent."
                    Else
                        TheError = "That email address does not exist"
                    End If
                Else
                    TheError = "Invalid Email Address"
                End If
		Else
		End If
 
 	End Sub
</script>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   
   	<title>Password Retrieve | Bioevolve B12 Plus+ Cream</title>
	<meta name="description" content="Retrieve customer's password">

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

		<div class="grid module-frame" id="pageForgot">
			<div class="col-14of14 header">
				<h5>Forgot Password</h5>
				<h4>Please enter your email address to retrieve your password. You can change this password in your account page.</h4>
				<div class="input-wrapper">
					<asp:textbox id="EmailAddress" columns="60" runat="server" maxlength="99" placeholder="Email Address"/>		
				</div>

				<asp:LinkButton id="SubmitButt" runat="server" CssClass="buy pink" Text="Submit" OnClick="SubmitButt_Click"/>		
			</div>	
			
		</div>


		<!--#include file="footer.aspx"-->
	</form>


<script src="js/ios_doubleTap_disable.js"></script>
</body>
</html>