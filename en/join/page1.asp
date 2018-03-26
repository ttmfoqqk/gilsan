<!-- #include file="../inc/top.asp" -->
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<STYLE type="text/css">
#middle_sub{margin:0px;}
</STYLE>
<%
Call Expires()
Call dbopen()
	Call AgreeView()
Call dbclose()

Sub AgreeView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_COMM_AGREE_V"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub


%>

<div id="middle_sub">

	<div class="join_navi_wrap">
		<div class="join_wrap">
			<div class="join_navi_01"><span class="blind"><h4>약관동의</h4></span></div>
		</div>
	</div>

	<div class="join_wrap">
		<h2 class="title">약관동의</h2>
		
		<form id="mForm" name="mForm" method="post" action="page2.asp" onsubmit="return check();">
		<div class="join_msg">
			<h3>회원가입을 위해 <span>이용약관</span>과 <span>개인정보 수집 및 이용</span>에 동의해 주세요.</h3>
			<p>
			회원이 되시면  길산파이프에서 제공하는 다양한 서비스를 이용하실 수 있습니다.<br>
			아래의 서비스 약관 및 개인정보 수집 이용에 대한 안내를 반드시 읽고 동의해 주세요.
			</p>
			<div class="checkbox_wrap">
				<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="agree" value="all"></span></span>
				<label><b>이용약관, 개인정보 수집 및 이용약관(선택)에 모두 동의합니다.</b></label>
			</div>

			<div class="agree_block">
				<h5>이용약관</h5>
				<div class="textarea" style="width:100%;height:150px;overflow-x:hidden;overflow-y:scroll;line-height:160%;"><%=FI_agree1%></div>
				
				<div class="checkbox_wrap">
					<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree1" name="agree" value="agree1"></span></span>
					<label><b>이용약관에 동의합니다.</b></label>
				</div>
			</div>
			<div class="agree_block">
				<h5>개인정보 수집 및 이용</h5>
				<div class="textarea" style="width:100%;height:150px;overflow-x:hidden;overflow-y:scroll;line-height:160%;"><%=FI_agree2%></div>
				
				<div class="checkbox_wrap">
					<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree2" name="agree" value="agree2"></span></span>
					<label><b>개인정보 수집 및 이용에 동의합니다.</b> </label>
				</div>
			</div>
			<div style="margin:30px;">
				<button type="submit" class="btn">다음단계</button>
			</div>
		</div>
		</form>

	</div>
</div>
<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
function check(){
	if( !$('#agree1').attr('checked') || !$('#agree2').attr('checked') ){
		alert('(주)길산골프클럽 이용약관, 개인정보 수집 및 이용에 동의해 주세요');
		return false;
	}
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->