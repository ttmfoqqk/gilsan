<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<%
Response.Buffer=true
Dim goUrl     : goUrl     = IIF( LEN( Trim( request.Form("goUrl") ) ) = 0 , "../" , Trim( request.Form("goUrl") ) )
Dim userId    : userId    = Trim( request.Form("userId") )
Dim userPwd   : userPwd   = Trim( request.Form("userPwd") )
Dim saveLogin : saveLogin = request.Form("saveLogin")

if userId="" Or  userPwd = "" Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('아이디 혹은 비밀번호가 일치하지 않습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	Call login()
Call dbclose()

'If FI_userIdx = 0 Or FI_pwdCheck = 0 Then 
If FI_userId = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('아이디 혹은 비밀번호가 일치하지 않습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

session("userId")    = userId
session("userName")  = FI_userName
session("userEmail") = FI_userEmail


If saveLogin = "0" Then 
	response.Cookies("user").domain   = Request.ServerVariables("SERVER_NAME")
	response.cookies("user")("id")    = userId
	response.cookies("user").expires  = Date() + 365
Else
	response.Cookies("user").domain   = Request.ServerVariables("SERVER_NAME")
	response.cookies("user")("id")    = ""
	response.cookies("user").expires  = Date() - 1
End If


response.redirect goUrl

Sub login()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_user_member_login_log"
		.Parameters("@id").value   = userId
		.Parameters("@pwd").value  = userPwd
		.Parameters("@ip").value   = g_uip
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>