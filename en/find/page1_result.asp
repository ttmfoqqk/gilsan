<!-- #include file="../inc/top.asp" -->
<%
Dim userName   : userName   = request.Form("userName")
Dim userEmail1 : userEmail1 = request.Form("userEmail1")
Dim userEmail2 : userEmail2 = request.Form("userEmail2")


If userName = "" Or userEmail1 = "" Or userEmail2 = "" Then 
	Response.redirect "page1.asp"
End If

Dim arrList
Dim cntList : cntList = -1

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

If cntList < 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('입력하신 정보와 일치하는 아이디가 없습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_find_info"
		.Parameters("@actType").value = "id"
		.Parameters("@name").value    = userName
		.Parameters("@email").value   = userEmail1 & "@" & userEmail2
		Set objRs = .Execute
	End with
	set objCmd = nothing

	CALL setFieldIndex(objRs, "FI")
	
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

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

			<div class="msg">
				<h3>입력하신 회원정보로 가입된 <span class="color_blue">아이디 일부</span>를 알려드립니다.</h3>
				<p>조회 결과, 입력하신 정보와 일치하는 아이디는 다음과 같습니다.<br>아이디 전체를 보고 싶으시면, 아래의 아이디 이메일 발송 버튼을 클릭하시기 바랍니다</p>
			</div>
			
			<center>
			<div style="display:inline-block;margin-top:30px;">
				<div style="line-height:200%;display:inline-block;text-align:left;">
				<%For iLoop = 0 To cntList%>
					<label><input type="radio" class="checkbox" name="find_id" value="<%=arrList( FI_id , iLoop)%>" <%=IIF( iLoop = 0 ,"checked","" )%>> <h2 class="color_blue" style="display:inline-block;"><%=StrLenBlind2( arrList( FI_id , iLoop) , 3 )%></h4> (<%=arrList( FI_indate , iLoop)%> 가입) </label><br>
				<%Next%>
				</div>
			</div>
			</center>
			
			<div style="margin:30px;text-align:center;">
				<button class="btn" style="width:140px;" onclick="SendMaile();">아이디 이메일 발송</button>
				<button class="btn" style="width:140px;" onclick="location.href='../login/'">로그인</button>
			</div>

			<div style="padding:25px;border:1px solid #bfbfbf;background-color:#fafafa;line-height:160%;">
				개인정보 보호를 위해 끝자리는 *로 표시됩니다.<br>
				만약 자신이 만든 아이디가 아니라면 개인정보 도용 신고 절차에 따라 신고해 주시기 바랍니다.<br>
				위의 방법으로 아이디 찾을 수 없을 경우 별도 확인이 불가능하오니, 새로운 아이디로 가입하여 주시기 바랍니다.<br>
			</div>


		</div>
	</div>


</div>
<SCRIPT type="text/javascript">
function SendMaile(){
	$.ajax({
		type    : 'POST',
		url     : 'page1_email.asp'  ,
		data    : 'userName=<%=userName%>&userEmail=' + encodeURIComponent('<%=userEmail1 & "@" & userEmail2%>') + '&userId='+ $('input[name="find_id"]').filter(':checked').val() ,
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			alert('발송되었습니다.');
		},error:function(err){
			//alert(err.responseText);
			//obj.html( err.responseText );
			alert('일시적인 장애입니다. 잠시 후 다시 시도해 주세요.');
		}
	});
};
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->