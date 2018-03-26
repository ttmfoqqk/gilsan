<!-- #include file="../inc/top.asp" -->
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

Dim result : result = sendSmsEmail( "secede" , session("userId") , session("userEmail") , now() , "" )

session("userIdx")   = ""
session("userId")    = ""
session("userEmail") = ""

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
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">회원탈퇴</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">회원탈퇴</h3>

			<div class="msg">
				<h3><span class="color_blue">회원 탈퇴</span>가 성공적으로 이루어졌습니다.</h3>
				<p>
					그동안 길산파이프(주)를 이용해 주셔서 감사합니다.<br>
					더 좋은 모습으로 회원님을 뵙겠습니다.
				</p>
			</div>

			<!--div style="margin:30px;text-align:center;">
				<button type="button" class="btn" onclick="location.href='../'">서비스 바로가기</button>
			</div-->

		</div>
	</div>


</div>
<!-- #include file="../inc/footer.asp" -->