<!-- #include file="../inc/top.asp" -->
<%
checkLogin( g_host & g_url )
Dim oldUserPwd     : oldUserPwd     = request.Form("oldUserPwd")
Dim userPwd        : userPwd        = request.Form("userPwd")
Dim userPwdConfirm : userPwdConfirm = request.Form("userPwdConfirm")

If oldUserPwd = "" Or userPwd = "" Or userPwdConfirm = "" Then 
	Response.redirect "page2.asp"
End If

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

If FI_pwdCheck = 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('정보가 일치하지 않습니다. 비밀번호를 다시 입력 해주세요.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim result   : result   = sendSmsEmail( "pwd_change" , session("userId") , FI_email , now() , "" )

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_pwd_change"
		.Parameters("@actType").value = "pwd"
		.Parameters("@pwd").value     = oldUserPwd
		.Parameters("@newPwd").value  = userPwd
		.Parameters("@id").value      = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">비밀번호 변경</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">비밀번호 변경</h3>

			<div class="msg">
				<h3>설정하신 비밀번호로 <span class="color_blue">변경이 완료</span>되었습니다.</h3>
				<p>회원님의 개인정보 보호에 최선을 다하겠습니다.</p>
			</div>

			<!--div style="margin:30px;text-align:center;">
				<button class="btn" onclick="location.href='../'">서비스 바로가기</button>
			</div-->

		</div>
	</div>


</div>

<!-- #include file="../inc/footer.asp" -->