<!-- #include file="../inc/top.asp" -->
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<STYLE type="text/css">
#middle_sub{margin:0px;}
</STYLE>
<%
Dim agree : agree = request("agree")
Dim length : length = Split(agree,",")
Dim agree1 : agree1 = 1
Dim agree2 : agree2 = 1

For i=0 To ubound(length)
	If Trim(length(i)) = "agree1" Then 
		agree1= 0
	End If
	If Trim(length(i)) = "agree2" Then 
		agree2= 0
	End If
Next

If agree1 <> 0 Or agree2 <> 0 Then
	Response.redirect "page1.asp"
End If

Call Expires()
Call dbopen()
	Dim optionEmail : optionEmail = setCodeOption( 11  , "select" , 1 , "" )
	Dim optionPhone : optionPhone = setCodeOption( 10  , "select" , 1 , "" )
Call dbclose()
%>
<div id="middle_sub">

	<div class="join_navi_wrap">
		<div class="join_wrap">
			<div class="join_navi_02"><span class="blind"><h4>기본정보 입력</h4></span></div>
		</div>
	</div>

	<div class="join_wrap">
		<h2 class="title">기본정보 입력</h2>
		
		<div class="join_msg">
			<h3>실명 인증 없이 <span>간단한 절차</span>로 가입하실 수 있습니다.</h3>
			<p>
			실명 인증 없이 간단한 정보만 입력하시면,<br>
			길산파이프의 다양한 서비스를 바로 이용하실 수 있습니다.
			</p>
			

			<form name="mForm" id="mForm" method="post" action="page2_proc.asp" onsubmit="return checkJoin()">
			<div class="form_wrap" style="width:680px;">
				<div class="row">
					<label>아이디 <span class="color_red">*</span></label>
					<input type="text" id="userId" name="userId" class="input" style="width:316px;ime-mode:disabled;" maxlength="12" tabindex="1">

					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">영소문자, 숫자 또는 혼용하여 6~12자 가능합니다.</div>
					</div>
				</div>
				<div class="row">
					<label>비밀번호 <span class="color_red">*</span></label>
					<input type="password" id="userPwd" name="userPwd" class="input" style="width:316px;" maxlength="20" tabindex="2">

					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">영문 대·소, 숫자, 특수문자 혼합 6~20자 가능합니다.</div>
					</div>
				</div>
				<div class="row">
					<label>비밀번호 확인 <span class="color_red">*</span></label>
					<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:316px;" maxlength="20" tabindex="3">

					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">비밀번호 확인을 위하여 위와 동일하게 입력하세요.</div>
					</div>
				</div>

				<div class="row">
					<label>회사명 <span class="color_red">*</span></label>
					<input type="text" class="input" id="userCompany" name="userCompany" maxlength="100" style="width:316px;" tabindex="4">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">한글, 영문 대·소, 숫자, 특수문자 혼합 2~100자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>가입구분 <span class="color_red">*</span></label>
					
					<div class="radio_wrap" name="radio_gubun">
						<span name="_radio" class="on"><span class="blind"><input type="radio" id="gubun1" name="gubun" value="0" checked></span></span>
						<label>거래처가입자</label>
					</div>
					&nbsp;&nbsp;
					<div class="radio_wrap" name="radio_gubun">
						<span name="_radio" class="off"><span class="blind"><input type="radio" id="gubun2" name="gubun" value="1"></span></span>
						<label>일반가입자</label>
					</div>

				</div>

				<div class="row">
					<label>사업자 등록번호 <span class="color_red">*</span></label>
					<input type="text" id="userSaNo" name="userSaNo" maxlength="10" class="input" style="width:316px;" tabindex="5">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">숫자 10자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>이름 <span class="color_red">*</span></label>
					<input type="text" class="input" id="userName" name="userName" maxlength="30" style="width:316px;" tabindex="6">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">한글 1~16자, 영문 대·소문자 2~30자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>주소 </label>
					<input type="text" class="input" id="userAddr" name="userAddr" maxlength="200" style="width:316px;" tabindex="7">
					<div class="alert" style="top:3px;;left:475px;">
						<div class="color_red">한글 1~16자, 영문 대·소문자 2~30자 가능합니다.</div>
					</div>
				</div>

				<div class="row">
					<label>HP </label>

					<input type="text" id="userHP" name="userHP" maxlength="20" class="input" style="width:316px;" tabindex="8"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">핸드폰번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>
				<div class="row">
					<label>TEL </label>
					<input type="text" id="userTEL" name="userTEL" maxlength="50" class="input" style="width:316px;" tabindex="9"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">전화번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>
				<div class="row">
					<label>FAX </label>
					<input type="text" id="userFAX" name="userFAX" maxlength="50" class="input" style="width:316px;" tabindex="10"> 

					<div class="alert" style="top:3px;left:475px;">
						<div class="color_red">팩스번호를 입력해 주시기 바랍니다.</div>
					</div>
				</div>


				<div class="row">
					<label>담당자 이메일 <span class="color_red">*</span></label>
					<div style="display:inline-block;">
						<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="11"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="13">
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
			
			<div style="margin:30px;line-height:40px;" id="submit_area">
				<button type="submit" class="btn">가입완료</button>
			</div>

			</form>


		</div>
	</div>
</div>
<script type="text/JavaScript" src="../inc/js/member.js"></script>
<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	$userId.focus();

	$('[name="radio_gubun"]').click(function(){
		$this_input = $(this).find('input');
		if( $this_input.val() == '0' ){
			$userSaNo.attr('disabled',false).css('background-color','#eff3f6').focus();
		}else{
			$userSaNo.attr('disabled',true).css('background-color','#d7d7d7').val('');
			$userSaNo.next().hide();
		}
	});

	$gubun2 = $('#gubun2');
	if( $gubun2.is(':checked') ){
		$gubun2.parent().parent().attr('class','on');
		$('#gubun1').parent().parent().attr('class','off');
		
		$userSaNo.attr('disabled',true).css('background-color','#d7d7d7').val('');
		$userSaNo.next().hide();
	}
});
function checkJoin(){
	
	var gubun = $('input[name="gubun"]:checked').val();

	var userId = checkFormUserId(true,false);
	if( userId == false ){$userId.focus();return false;}

	var userPwd = checkFormUserPwd(true);
	if( !userPwd ){$userPwd.focus();return false;}

	var userPwdConfirm = checkFormUserPwdConfirm(true);
	if( !userPwdConfirm ){$userPwdConfirm.focus();return false;}

	var userCompany = checkFormUserCompany(true);
	if( !userCompany ){$userCompany.focus();return false;}
	
	if( gubun=='0' ){
		var userSaNo = checkFormUserSaNo(true,false);
		if( !userSaNo ){$userSaNo.focus();return false;}
	}


	var userName = checkFormUserName(true);
	if( !userName ){$userName.focus();return false;}

	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}

	$('#submit_area').html('처리중 입니다.');
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->