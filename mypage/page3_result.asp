<!-- #include file="../inc/top.asp" -->
<%checkLogin( g_host & "/mypage/page3.asp" )%>
<%
If Session("temp_edit_input") <> "y" Then 
	Response.redirect "edit.asp"
End If
Session("temp_edit_input") = ""

Dim userName       : userName       = Trim( request.Form("userName") )
Dim userAddr       : userAddr       = Trim( request.Form("userAddr") )
Dim userHP         : userHP         = Trim( request.Form("userHP") )
Dim userTEL        : userTEL        = Trim( request.Form("userTEL") )
Dim userFAX        : userFAX        = Trim( request.Form("userFAX") )

Dim authEmail      : authEmail      = Trim( request.Form("authEmail") )
Dim userEmail1     : userEmail1     = Trim( request.Form("userEmail1") )
Dim userEmail2     : userEmail2     = Trim( request.Form("userEmail2") )

If userName = "" Or userEmail1 = "" Or userEmail2 = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 목록이 있습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Call Expires()
Call dbopen()
	Call update()
Call dbclose()


If authEmail <> userEmail1 & "@" & userEmail2 Then 
	
	session("userEmail") = userEmail1 & "@" & userEmail2
	Dim result : result = sendSmsEmail( "email" , session("userId") , userEmail1 & "@" & userEmail2 , now() , "" )

End If


Sub update()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_info_update"
		.Parameters("@ID").value       = session("userId")
		.Parameters("@MEMNAME").value  = userName
		.Parameters("@JUSO").value     = userAddr
		.Parameters("@HP").value       = userHP
		.Parameters("@TEL").value      = userTEL
		.Parameters("@FAX").value      = userFAX
		.Parameters("@EMAIL").value    = userEmail1 & "@" & userEmail2
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
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">회원정보 변경</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">회원정보 변경</h3>

			<div class="msg">
				<h3>설정하신 정보로 <span class="color_blue">변경이 완료</span>되었습니다.</h3>
				<p>회원님의 개인정보 보호에 최선을 다하겠습니다.</p>
			</div>


		</div>
	</div>


</div>

<!-- #include file="../inc/footer.asp" -->