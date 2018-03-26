<!-- #include file="../inc/top.asp" -->
<%checkLogin( g_host & g_url )%>
<%
Session("temp_edit_input") = "y"

Call Expires()
Call dbopen()
	Call getList()

	Dim userEmail   : userEmail = Split(IIF( FI_email="","@",FI_email ),"@")

	Dim optionEmail : optionEmail = setCodeOption( 11 , "select" , 1 , userEmail(1) )
Call dbclose()



Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_user_member_info_v"
		.Parameters("@id").value = session("userId")
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
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">회원정보 변경</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">회원정보 변경</h3>

			<form name="mForm" id="mForm" method="post" action="page3_result.asp" onsubmit="return checkEdit()">
			<input type="hidden" id="authEmail" name="authEmail" value="<%=FI_email%>">

			<div class="form_wrap" style="width:680px;">
				<div class="row">
					<label>아이디 <span class="color_red">*</span></label>
					<b class="color_blue" style="font-size:14px;"><%=session("userId")%></b>
				</div>

				<div class="row">
					<label>회사명 <span class="color_red">*</span></label>
					<b class="color_blue" style="font-size:14px;"><%=FI_CUSTNAME%></b>
				</div>
				
				<%If FI_SANO <> "" Then %>
				<div class="row">
					<label>사업자 등록번호 <span class="color_red">*</span></label>
					<b class="color_blue" style="font-size:14px;"><%=IIF(FI_SANO = "","&nbsp;",FI_SANO)%></b>
				</div>
				<%End If%>

				<div class="row">
					<label>이름 <span class="color_red">*</span></label>
					<input type="text" class="input" id="userName" name="userName" maxlength="30" style="width:316px;" tabindex="6" value="<%=FI_MEMNAME%>">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">한글 1~16자, 영문 대·소문자 2~30자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>주소 </label>
					<input type="text" class="input" id="userAddr" name="userAddr" maxlength="200" style="width:316px;" tabindex="7" value="<%=FI_JUSO%>">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">한글 1~16자, 영문 대·소문자 2~30자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>HP </label>

					<input type="text" id="userHP" name="userHP" maxlength="20" class="input" style="width:316px;" tabindex="8" value="<%=FI_HP%>"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">핸드폰번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>
				<div class="row">
					<label>TEL </label>
					<input type="text" id="userTEL" name="userTEL" maxlength="50" class="input" style="width:316px;" tabindex="9" value="<%=FI_TEL%>"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">전화번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>
				<div class="row">
					<label>FAX </label>
					<input type="text" id="userFAX" name="userFAX" maxlength="50" class="input" style="width:316px;" tabindex="10" value="<%=FI_FAX%>"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">팩스번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>


				<div class="row">
					<label>담당자 이메일 <span class="color_red">*</span></label>
					<div style="display:inline-block;">
						<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:139px;" maxlength="100" tabindex="11" value="<%=userEmail(0)%>"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:139px;" maxlength="100" tabindex="13" value="<%=userEmail(1)%>">
						<select class="input" id="userEmail3" style="width:139px;height:32px;padding:5px;" tabindex="12">
							<option value="">직접입력</option>
							<%=optionEmail%>
						</select>

						<div class="alert" style="top:3px;;left:615px;">
							<div class="color_red">이메일을 입력해 주시기 바랍니다.</div>
						</div>

						<div class="color_red" style="font-size:11px;line-height:100%;margin-top:10px;">입력하신 이메일은 아이디, 비밀번호 분실 시 찾기 위한 용도로 사용되오니 신중하게 입력해 주세요.</div>
					</div>
				</div>
			</div>
			
			<div style="margin:30px;text-align:center;">
				<button type="submit" class="btn">정보변경</button>
			</div>
			</form>


		</div>
	</div>


</div>

<script type="text/JavaScript" src="../inc/js/member.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	$userName.focus();
	checkFormUserName();
	checkFormUserEmail();
});
function checkEdit(){

	var userName = checkFormUserName(true);
	if( !userName ){$userName.focus();return false;}

	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->