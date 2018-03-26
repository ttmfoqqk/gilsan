<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%checkLogin( g_host & "/mypage/page4.asp" )%>
<%
Dim agree   : agree   = request.Form("agree")

If agree = "" Then 
	Response.redirect "page4.asp"
End If

Call Expires()
Call dbopen()
	'Call getList()

	'If FI_check <> 1 Then 
	'	Call dbclose()
	'	With Response
	'	 .Write "<script language='javascript' type='text/javascript'>"
	'	 .Write "alert('정보가 일치하지 않습니다. 비밀번호를 다시 입력 해주세요.');"
	'	 .Write "history.go(-1);"
	'	 .Write "</script>"
	'	 .End
	'	End With
	'End If

	Call secede()

Call dbclose()

session("userId")    = ""
session("userName")  = ""
session("userEmail") = ""

Dim result : result = sendSmsEmail( "secede" , session("userId") , session("userEmail") , now() , "" )
Response.redirect "page4_result.asp"


Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_check"
		.Parameters("@actType").value = "pwd"
		.Parameters("@search").value  = userPwd
		.Parameters("@id").value      = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub secede()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_secede"
		.Parameters("@id").value = session("userId")
		.Execute
	End with
	set objCmd = nothing
End Sub
%>