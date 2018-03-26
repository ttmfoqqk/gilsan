<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%checkLogin( g_host & "/m4/page1_1.asp" )%>
<%
Dim actType   : actType   = Request.Form("actType")
Dim orderCode : orderCode = Request.Form("orderCode")
Dim seq       : seq       = Request.Form("seq")

If actType = "insert" Then 
	If orderCode = "" Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 주문번호 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Call Expires()
	Call dbopen()
		Call insert()
	Call dbclose()

	If FI_CNT1 < 1 Or FI_CNT1 < 1 Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 주문번호 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('주문접수 되었습니다.');"
	 .Write "document.location.href='../mypage/page5.asp';"
	 .Write "</script>"
	 .End
	End With
ElseIf actType = "delete" Then 
	If orderCode = "" Or seq = "" Or IsNumeric(seq) = False Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 주문번호 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Call Expires()
	Call dbopen()
		Call update()
	Call dbclose()

	If FI_CNT1 < 1 Or FI_CNT1 < 1 Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 주문번호 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('삭제 되었습니다.');"
	 .Write "document.location.href='page1_2.asp?orderCode=" & orderCode & "';"
	 .Write "</script>"
	 .End
	End With
Else
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 요청입니다.');"
	 .Write "history.back(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Sub insert()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_INSERT_REAL"
		.Parameters("@ODNO").value        = orderCode
		.Parameters("@ID").value          = session("userId")
		.Parameters("@INDATETIME").value  = FormatDateTime(Now(), 2)&","&FormatDateTime(Now(), 4)
		.Parameters("@HOSTNAME").value    = Request.ServerVariables("REMOTE_HOST")
		.Parameters("@IP").value          = Request.ServerVariables("REMOTE_ADDR")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub update()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_DELETE_BASKET"
		.Parameters("@ODNO").value = orderCode
		.Parameters("@ID").value   = session("userId")
		.Parameters("@SEQ").value  = seq
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>