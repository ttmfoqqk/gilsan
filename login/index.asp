<!-- #include file="../inc/top.asp" -->
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<STYLE type="text/css">
#middle_sub{margin:0px;}
</STYLE>
<%
	Dim save_id    : save_id    = request.cookies("user")("id")
	Dim save_check : save_check = IIF( save_id <> "","checked","" )
%>
<div id="middle_sub">

	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block2">로그인</span>
		</div>
	</div>

	<div class="login_msg">
		<h3><span>길산파이프</span>에 오신것을 환영합니다.</h3><br>
		보다 많은 서비스 이용을 위해 로그인하시기 바랍니다.
	</div>

	<div class="login_wrap">
		<div class="width_wrap">
			<div class="login_bg_box">
				<h5><span>길산파이프(주)</span> 로그인</h5>
				
				<form method="post" name="mForm" id="mForm" action="login_proc.asp" onsubmit="return check()">
				<input type="hidden" name="goUrl" value="<%=request("goUrl")%>">
				
				<table cellpadding="0" cellspacing=="0" style="width:355px;text-align:left;margin:0px auto;" align="center">
					<tr>
						<td style="width:255px;height:37px;" valign="top"><input type="text" id="userId" name="userId" class="input" style="ime-mode:disabled;width:225px;" maxlength="12" placeholder="아이디" tabindex="1" value="<%=save_id%>"></td>
						<td rowspan="2" valign="top">
							<button type="submit" class="btn" tabindex="3" style="width:100px;height:69px;">로그인</span>
						</td>
					</tr>
					<tr>
						<td style="height:42px;" valign="top"><input type="password" id="userPwd" name="userPwd" class="input" style="width:225px;" maxlength="30" placeholder="비밀번호" tabindex="2"></td>
					</tr>
					<tr>
						<td colspan="2" valign="top">
							<label><input type="checkbox" class="checkbox" name="saveLogin" value="0" <%=save_check%> tabindex="4"> 아이디 저장</label>
							<span style="float:right;">
								<a href="../find/page1.asp" tabindex="5">아이디</a> · <a href="../find/page2.asp" tabindex="6">비밀번호 찾기</a> ㅣ <a href="../join/page1.asp" tabindex="7"><b>회원가입</b></a>
							</span>
						</td>
					</tr>
				</table>

				</form>

			</div>
		</div>
	</div>


</div>

<SCRIPT type="text/javascript">
$userId  = $('#userId');
$userPwd = $('#userPwd');

function check(){
	if( !trim($userId.val()) ){
		alert('아이디를 입력하세요');
		$userId.focus();
		return false;
	}
	if( !trim($userPwd.val()) ){
		alert('비밀번호를 입력하세요');
		$userPwd.focus();
		return false;
	}
}

$(function(){
	<%if save_id <> "" then%>
	$userPwd.focus();
	<%else%>
	$userId.focus();
	<%end if%>
});
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->