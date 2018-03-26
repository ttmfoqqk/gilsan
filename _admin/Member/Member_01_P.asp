<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & "/_admin/Member/Member_01_L.asp")

Dim Id         : Id         = request("Id")
Dim pwd        : pwd        = request("pwd")
Dim CUSTNAME   : CUSTNAME   = request("CUSTNAME")
Dim SANO       : SANO       = request("SANO")
Dim JUSO       : JUSO       = request("JUSO")
Dim MEMNAME    : MEMNAME    = request("MEMNAME")
Dim HP         : HP         = request("HP")
Dim TEL        : TEL        = request("TEL")
Dim FAX        : FAX        = request("FAX")


Dim userEmail1 : userEmail1 = request("email1")
Dim userEmail3 : userEmail3 = request("email3")
Dim state      : state      = request("state")

Dim PageParams : PageParams = URLDecode(request("PageParams"))

Call Expires()
Call dbopen()
	Call update()
Call dbclose()

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('정상처리 되었습니다.');"
 .Write "location.href='Member_01_L.asp?" & PageParams & "';"
 .Write "</script>"
 .End
End With

Sub update()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_user_member_info_update_admin"
		.Parameters("@ID").value       = Id
		.Parameters("@MEMNAME").value  = MEMNAME
		.Parameters("@CUSTNAME").value = CUSTNAME
		.Parameters("@SANO").value     = SANO
		.Parameters("@JUSO").value     = JUSO
		.Parameters("@HP").value       = HP
		.Parameters("@TEL").value      = TEL
		.Parameters("@FAX").value      = FAX
		.Parameters("@EMAIL").value    = userEmail1 &"@"& userEmail3
		.Parameters("@state").value    = state
		If pwd <> "" Then 
		.Parameters("@pwd").value      = pwd
		End If
		.Execute
	End with
	set objCmd = nothing
End Sub
%>