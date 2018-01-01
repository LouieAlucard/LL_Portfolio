<script runat="server">
Sub Application_Start(Sender As Object, E As EventArgs)
End Sub


Sub Application_End(Sender As Object, E As EventArgs)
End Sub

Sub Session_Start(Sender As Object, E As EventArgs)

        Dim FullIP As String
        Dim arrDec() As String
        Dim i As Integer
        Dim intResult As Long
        Dim connSql As System.Data.SqlClient.SqlConnection
        Dim sqlSql As System.Data.SqlClient.SqlCommand
        Dim drSql As System.Data.SqlClient.SqlDataReader



        'If Request.QueryString("test") <> "1" Then Response.Redirect("/maintenance.asp")

        FullIP = Request.ServerVariables("REMOTE_ADDR")

        If Request.QueryString("P") = "GMI" Then
            Session("Country") = "Local"
            Session("CountryCode") = "Local"
        Else

            FullIP = Request.ServerVariables("REMOTE_ADDR")

            If FullIP = "" Then
                intResult = 0
            Else
                arrDec = FullIP.Split(".")
                For i = arrDec.Length - 1 To 0 Step -1
                    intResult = intResult + ((Int(arrDec(i)) Mod 256) * Math.Pow(256, 3 - i))
                Next
            End If


            connSql = New System.Data.SqlClient.SqlConnection("Data Source=mssql.gurumatrix.com\THEONE,4933;Initial Catalog=geolocation;Password=d4k8rdu8gilk7d4h7j;User Id=geolocr")
            Try
                connSql.Open()
            Catch Ex As Exception
            End Try

            sqlSql = New System.Data.SqlClient.SqlCommand("SELECT [countrySHORT],[countryLONG], [ipREGION], [ipCITY] FROM [IPREGIONCITY] WHERE " & intResult & " BETWEEN [ipFROM] AND [ipTO]", connSql)
            Try
                drSql = sqlSql.ExecuteReader
            Catch Ex As Exception

            End Try

            While drSql.Read
                If NOT isDBNull(drSql("countrySHORT")) Then
			If drSql("countrySHORT") = "" OR drSql("countrySHORT") = "-" OR drSql("countrySHORT") = "--" Then
				Session("Country") = "Unknown"
				Session("CountryCode") = "US"
			Else
				Session("Country") = drSql("countryLONG") & ":" & drSql("ipREGION") & ":" & drSql("ipCITY")
        		        Session("CountryCode") = drSql("countrySHORT")
			End If
		Else
			Session("Country") = "Unknown"
			Session("CountryCode") = "US"

		End If
            End While
           If Session("CountryCode") ="" Then
		Session("Country") = "Unknown"
		Session("CountryCode") = "US"

	   End If
	 
	   drSql.Close()
            connSql.Close()
            drSql = Nothing
            connSql = Nothing
            sqlSql = Nothing
        End If

        If Session("CountryCode") = "Local" Then Session("CountryCode") = "US"


        Session("OrderID") = "0"
        Session("Invoice") = "0"
        Session("ClientID") = "0"
        Session("CompanyName") = "b12cream.com"
        Session("OrderEmail") = "order@b12cream.com"
        Session("FreeShipping") = 99
        Session("Referer") = Replace(Request.ServerVariables("HTTP_REFERER"),"'","''")
		Session("ShippingCode") = 0
        Session("TheCurrentSite") = 7
	If Session("CountryCode") = "CA" Then
            Session("InCAD") = 1
    Else
            Session("InCAD") = 0
    End If
        Session("NewSession") = 1
	Session("SearchEngine") = Replace(Request.QueryString("se"),"'","''")
	Session("ShippingCode") = 0
	If Not Request.Cookies("BioSenseHealth") Is Nothing Then
		If Not Request.Cookies("BioSenseHealth")("ReferredBy") Is Nothing Then
			Session("Affiliate") = Request.Cookies("BioSenseHealth")("ReferredBy")
			Response.Cookies("BioSenseHealth").Expires = Now.AddDays(30)
			
		Else
			Session("Affiliate") =  Replace(Request.QueryString("aid"),"'","''")
			If Session("Affiliate") <> "" Then
				Response.Cookies("BioSenseHealth")("ReferredBy") = Session("Affiliate")
				Response.Cookies("BioSenseHealth").Expires = Now.AddDays(30)
			End If
		End If
	Else
		Session("Affiliate") =  Replace(Request.QueryString("aid"),"'","''")
		If Session("Affiliate") <> "" Then
			Response.Cookies("BioSenseHealth")("ReferredBy") = Session("Affiliate")
			Response.Cookies("BioSenseHealth").Expires = Now.AddDays(30)
		End If
	End If
	Session("SortBy") = ""
	Session("CouponProductID") = 0
	Session("CouponOneTime") = 0
	Session("CouponMin") = 0
	Session("CouponAmount") = 0
	Session("IsVIP") = 0
	Session("SynergieTotal") = 0
	Session("SynergieCouponID") = 0
	Session("AC") = 0

End Sub

Sub Session_OnEnd(Sender As Object, E As EventArgs)

        Dim connSql As System.Data.SqlClient.SqlConnection
        Dim sqlSql As System.Data.SqlClient.SqlCommand
        Dim drSql As System.Data.SqlClient.SqlDataReader

        connSql = New System.Data.SqlClient.SqlConnection("Data Source=mssql.gurumatrix.com\THEONE,4933;Initial Catalog=cdsmora;User ID=r4huwfteuw7h63gs8;Password=w5dn6w93gek5e6svd")
        sqlSql = New System.Data.SqlClient.SqlCommand("SELECT AuthCode FROM [TempOrder] WHERE OrderID = " & Session("OrderID"), connSql)
        Try
            connSql.Open()
            drSql = sqlSql.ExecuteReader
        Catch Ex As Exception
        End Try
        If drSql.Read Then
            If IsDBNull(drSql("AuthCode")) Then
                Try
                    sqlSql = New System.Data.SqlClient.SqlCommand("DELETE FROM [TempItem] WHERE OrderID = " & Session("OrderID"), connSql)
                    sqlSql.ExecuteNonQuery()
                    sqlSql = New System.Data.SqlClient.SqlCommand("DELETE FROM [TempOrder] WHERE OrderID = " & Session("OrderID"), connSql)
                    sqlSql.ExecuteNonQuery()
                Catch Ex As Exception
                End Try
            End If
        End If
        drSql.Close()
        connSql.Close()
        drSql = Nothing
        connSql = Nothing
 
    End Sub

Sub Session_Timeout(Sender As Object, E As EventArgs)

        Dim connSql As System.Data.SqlClient.SqlConnection
        Dim sqlSql As System.Data.SqlClient.SqlCommand
        Dim drSql As System.Data.SqlClient.SqlDataReader

        connSql = New System.Data.SqlClient.SqlConnection("Data Source=mssql.gurumatrix.com\THEONE,4933;Initial Catalog=cdsmora;User ID=r4huwfteuw7h63gs8;Password=w5dn6w93gek5e6svd")
        sqlSql = New System.Data.SqlClient.SqlCommand("SELECT AuthCode FROM [TempOrder] WHERE OrderID = " & Session("OrderID"), connSql)
        Try
            connSql.Open()
            drSql = sqlSql.ExecuteReader
        Catch Ex As Exception
        End Try
        If drSql.Read Then
            If IsDBNull(drSql("AuthCode")) Then
                Try
                    sqlSql = New System.Data.SqlClient.SqlCommand("DELETE FROM [TempItem] WHERE OrderID = " & Session("OrderID"), connSql)
                    sqlSql.ExecuteNonQuery()
                    sqlSql = New System.Data.SqlClient.SqlCommand("DELETE FROM [TempOrder] WHERE OrderID = " & Session("OrderID"), connSql)
                    sqlSql.ExecuteNonQuery()
                Catch Ex As Exception
                End Try
            End If
        End If
        drSql.Close()
        connSql.Close()
        drSql = Nothing
        connSql = Nothing
 
    End Sub

</script>