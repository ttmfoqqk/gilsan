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
			<span class="home">H</span><span class="block2">Login</span>
		</div>
	</div>

	<div class="login_msg">
		<h3>Welcome!. <span>Gilsan Pipe</span> </h3><br>
		Please login for more services. 
	</div>

	<div class="login_wrap">
		<div class="width_wrap">
			<div class="login_bg_box">
				<h5><span>Gilsan Pipe Co., LTD</span> Login</h5>
				
				<form method="post" name="mForm" id="mForm" action="login_proc.asp" onsubmit="return check()">
				<input type="hidden" name="goUrl" value="<%=request("goUrl")%>">
				
				<table cellpadding="0" cellspacing=="0" style="width:355px;text-align:left;margin:0px auto;" align="center">
					<tr>
						<td style="width:255px;height:37px;" valign="top"><input type="text" id="userId" name="userId" class="input" style="ime-mode:disabled;width:225px;" maxlength="12" placeholder="ID" tabindex="1" value="<%=save_id%>"></td>
						<td rowspan="2" valign="top">
							<button type="submit" class="btn" tabindex="3" style="width:100px;height:69px;">Login</span>
						</td>
					</tr>
					<tr>
						<td style="height:42px;" valign="top"><input type="password" id="userPwd" name="userPwd" class="input" style="width:225px;" maxlength="30" placeholder="Password" tabindex="2"></td>
					</tr>
					<tr>
						<td colspan="2" valign="top">
							<label><input type="checkbox" class="checkbox" name="saveLogin" value="0" <%=save_check%> tabindex="4">ID Store</label>
							<span style="float:right;">
								<a href="../find/page1.asp" tabindex="5">ID</a> · <a href="../find/page2.asp" tabindex="6">Password?</a> ㅣ <a href="../join/page1.asp" tabindex="7"><b>sign up</b></a>
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
		alert('ID in');
		$userId.focus();
		return false;
	}
	if( !trim($userPwd.val()) ){
		alert('Password in');
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