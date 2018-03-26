<!-- #include file="../inc/top.asp" -->
<%
Dim userId     : userId     = request.Form("userId")
Dim userName   : userName   = request.Form("userName")
Dim userEmail1 : userEmail1 = request.Form("userEmail1")
Dim userEmail2 : userEmail2 = request.Form("userEmail2")

If userName = "" Or userId = "" Or userEmail1 = "" Or userEmail2 = "" Then 
	Response.redirect "page2.asp"
End If

Call Expires()
Call dbopen()

	Call getList()
	If FI_ID = "" Then 
		Call dbclose()
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('입력하신 정보와 일치하는 아이디가 없습니다.');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	' 난수발생 비밀번호변경 -> 이메일 발송.
	Dim tpm_rand : tpm_rand = RandomNumber(10,"")
	Dim result   : result   = sendSmsEmail( "pwd_search" , userId , userEmail1 & "@" & userEmail2 , tpm_rand , "" )

	Call update()
Call dbclose()

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_find_info"
		.Parameters("@actType").value = "pwd"
		.Parameters("@id").value    = userId
		.Parameters("@name").value  = userName
		.Parameters("@email").value = userEmail1 & "@" & userEmail2
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub update()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_pwd_change"
		.Parameters("@actType").value = "id"
		.Parameters("@newPwd").value  = tpm_rand
		.Parameters("@id").value      = FI_ID
		.Parameters("@name").value    = userName
		.Parameters("@uEmail").value  = userEmail1 & "@" & userEmail2
		.Execute
	End with
	set objCmd = nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">비밀번호 재발급</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">비밀번호 재발급</h3>

			<div class="msg">
				<h3><span style="color:#0cb6ef;"><%=userEmail1%>@<%=userEmail2%> </span>이메일 주소로 임시 비밀번호가 재발급 되었습니다.</h3>
				<p>로그인 하신 후 비밀번호를 변경해 주시기 바랍니다.</p>
			</div>

			<div style="margin:30px;text-align:center;">
				<button class="btn" onclick="location.href='../login/'">로그인</button>
			</div>


		</div>
	</div>


</div>

<!-- #include file="../inc/footer.asp" -->