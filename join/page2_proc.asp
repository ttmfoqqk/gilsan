<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Dim userId         : userId         = Trim( request.Form("userId") )
Dim userPwd        : userPwd        = Trim( request.Form("userPwd") )
Dim userPwdConfirm : userPwdConfirm = Trim( request.Form("userPwdConfirm") )

Dim userCompany    : userCompany    = Trim( request.Form("userCompany") )
Dim userSaNo       : userSaNo       = Trim( request.Form("userSaNo") )
Dim userName       : userName       = Trim( request.Form("userName") )
Dim userAddr       : userAddr       = Trim( request.Form("userAddr") )
Dim userHP         : userHP         = Trim( request.Form("userHP") )
Dim userTEL        : userTEL        = Trim( request.Form("userTEL") )
Dim userFAX        : userFAX        = Trim( request.Form("userFAX") )

Dim userEmail1     : userEmail1     = Trim( request.Form("userEmail1") )
Dim userEmail2     : userEmail2     = Trim( request.Form("userEmail2") )
Dim gubun          : gubun          = request.Form("gubun")

If userId = "" Or userPwd = "" Or userPwdConfirm = "" Or userCompany = "" Or userName = "" Or userEmail1 = "" Or userEmail2 = "" Or gubun = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 목록이 있습니다.');"
	 .Write "window.history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If userPwd <> userPwdConfirm Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('비밀번호를 확인해주세요.');"
	 .Write "window.history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	Call insert()
Call dbclose()

If FI_CNT1 > 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('현재 사용중인 아이디입니다');"
	 .Write "window.history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If FI_CNT2 > 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('현재 사용중인 사업자 등록번호 입니다.');"
	 .Write "window.history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If FI_CNT3 < 1 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('거래처가 아닙니다. 거래처 등록 후 사용 하십시요.\n문의전화 : 041-732-9994');"
	 .Write "window.history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

'이메일 발송
Dim result : result = sendSmsEmail( "join" , userId , userEmail1 & "@" & userEmail2 , now() , "" )
response.redirect "page2_result.asp"


Sub insert()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_user_member_insert"
		.Parameters("@ID").value       = userId
		.Parameters("@PASSWORD").value = userPwd
		.Parameters("@MEMNAME").value  = userName
		.Parameters("@CUSTNAME").value = userCompany
		.Parameters("@SANO").value     = userSaNo
		.Parameters("@JUSO").value     = userAddr
		.Parameters("@HP").value       = userHP
		.Parameters("@TEL").value      = userTEL
		.Parameters("@FAX").value      = userFAX
		.Parameters("@EMAIL").value    = userEmail1 & "@" & userEmail2
		.Parameters("@gubun").value    = gubun
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>