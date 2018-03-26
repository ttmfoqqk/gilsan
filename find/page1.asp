<!-- #include file="../inc/top.asp" -->
<%
Call Expires()
Call dbopen()
	Dim optionEmail : optionEmail = setCodeOption( 11  , "select" , 1 , "" )
Call dbclose()
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">아이디 찾기</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">아이디 찾기</h3>

			<form name="mForm" id="mForm" method="post" action="page1_result.asp" onsubmit="return check();">
			<div class="form_wrap" style="width:620px;">
				<div class="row">
					<label style="width:130px;">담당자명 <span class="color_red">*</span></label>
					<input type="text" id="userName" name="userName" class="input" style="width:316px;ime-mode:active;" maxlength="20" tabindex="1">
				</div>
				<div class="row">
					<label style="width:130px;">담당자 이메일 <span class="color_red">*</span></label>
					<div style="display:inline-block;">
						<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="2"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="4">
						<select id="userEmail3" name="userEmail3" class="input" style="width:139px;height:32px;padding:5px;" tabindex="3">
							<option value="">직접입력</option>
							<%=optionEmail%>
						</select>
						<div class="color_blue" style="font-size:11px;line-height:100%;margin-top:10px;">가입 시 기재한 이메일을 입력해 주세요.</div>
					</div>
				</div>
			</div>
			
			<div style="margin:30px;text-align:center;">
				<button class="btn" type="submit">아이디 찾기</button>
			</div>
			</form>


		</div>
	</div>


</div>

<script type="text/JavaScript" src="../inc/js/member.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	$userName.focus();
});
function check(){
	var userName = checkFormUserName(true);
	if( !userName ){$userName.focus();return false;}

	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}
}
</SCRIPT>

<!-- #include file="../inc/footer.asp" -->