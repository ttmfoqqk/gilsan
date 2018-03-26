<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%checkLoginPOP()%>
<%
Dim actType     : actType     = Request("actType")
Dim unloadplace : unloadplace = Request("unloadplace")
Dim idx         : idx         = Request("idx")

If actType = "insert" Then 
	
	If unloadplace = "" Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('등록할 하차장소를 입력해주세요.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Call Expires()
	Call dbopen()
		Call insert()
	Call dbclose()

	Response.redirect "pop_unloadplace.asp"

ElseIf actType = "delete" Then 
	
	If idx = "" Or IsNumeric(idx) = False Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 경로 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Call Expires()
	Call dbopen()
		Call delete()
	Call dbclose()

	Response.redirect "pop_unloadplace.asp"

End If


Sub insert()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_UNLOADPLACE_INSERT"
		.Parameters("@ID").value          = session("userId")
		.Parameters("@UNLOADPLACE").value = unloadplace
		.Parameters("@IP").value          = Request.ServerVariables("REMOTE_ADDR")
		.Execute
	End with
	set objCmd = nothing
End Sub

Sub delete()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_UNLOADPLACE_DELETE"
		.Parameters("@ID").value  = session("userId")
		.Parameters("@IDX").value = idx
		.Execute
	End with
	set objCmd = nothing
End Sub
%>