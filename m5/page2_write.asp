<!-- #include file="../inc/top.asp" -->
<%
checkLogin(g_host & g_url)
Dim userEmail : userEmail = Split(session("userEmail"),"@")

Dim idx        : idx        = IIF( request("idx")="","0",request("idx") )
Dim pageNo     : pageNo     = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim actType    : actType    = request("actType")

Dim PageParams : PageParams = "pageNo=" & pageNo

Call Expires()
Call dbopen()
	Dim optionEmail : optionEmail = setCodeOption( 11  , "select" , 1 , userEmail(1) )
	Call GetList()
Call dbclose()

'If FI_Idx = "" Then 
'	With Response
'	 .Write "<script language='javascript' type='text/javascript'>"
'	 .Write "alert('잘못된 경로입니다.');"
'	 .Write "history.back(-1);"
'	 .Write "</script>"
'	 .End
'	End With
'End If


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_V"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = 20
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
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">SALES</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">SALES</h3>

			<form name="AdminForm" method="POST" action="page2_proc.asp" enctype="multipart/form-data" onsubmit="return check()">
			<input type="hidden" name="oldFileName" value="<%=FI_File_name%>">
			<input type="hidden" name="Idx" value="<%=FI_Idx%>">
			<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , IIF(actType="ANS","INSERT","UPDATE") )%>">

			<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

			<table cellpadding="0" cellspacing="0" style="width:100%;font-size:14px;margin-bottom:10px;">
				<tr style="height:40px;">
					<td style="width:125px;padding-left:15px;">이메일<span style="color:red">*</span></td>
					<td>
						<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:178px;" maxlength="100" value="<%=userEmail(0)%>"> @ 
						<input type="text" id="userEmail2" name="userEmail2" class="input" style="width:178px;" maxlength="100" value="<%=userEmail(1)%>">
						<select class="input" id="userEmail3" style="width:178px;height:32px;padding:5px;">
							<option value="">직접입력</option>
							<%=optionEmail%>
						</select>
					</td>
				</tr>
				<tr style="height:40px;">
					<td style="padding-left:15px;">제목<span style="color:red">*</span></td>
					<td><input type="text" class="input" style="width:578px;" maxlength="100" name="title" id="title" value="<%= TagDecode( FI_Title )%>"></td>
				</tr>
				<tr style="height:40px;">
					<td style="padding:20px 0px 20px 15px;">내용<span style="color:red">*</span></td>
					<td style="padding:20px 0px 20px 0px;">
						<textarea name="Contants" id="Contants" rows="10" cols="100" style="width:100%;height:300px;display:none;"><%=FI_Contants%></textarea>
					</td>
				</tr>
				<tr style="height:40px;">
					<td style="padding:20px 0px 20px 15px;" valign="top">첨부파일</td>
					<td style="padding:20px 0px 20px 0px;">
						<input type="file" class="input" style="width:100%;" name="FileName" id="FileName">
						
						<%If FI_File_name<>"" Then %>
						<br><br>
						<a href="../../common/download.asp?pach=/upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
						<input type="checkbox" value="1" name="DellFileFg"> 기존파일 삭제
						<br><br>
						<%End If%>

						<div style="font-size:11px;margin-top:5px;line-height:160%;">
							사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.<br>
							오류 문의시 브라우저명, 버전과 구체적 상황 또는 캡쳐화면을 첨부해주시면 신속하고 정확한 답변이 가능합니다.<br>
							파일의 크기가 3MB를 초과하거나 2개 이상의 파일을 첨부하실 경우 spweb@naver.com 으로 보내주시기 바랍니다. <br>
						</div>
					</td>
				</tr>
			</table>

			<div style="text-align:center" class="btnArea">
				<button type="submit" class="btn">저장</button>
			</div>

			</form>

		</div>
	</div>


</div>
<script type="text/JavaScript" src="../inc/js/member.js"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contants",
	sSkinURI: "../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function check() {
	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}
	
	if( !trim($('#title').val()) ){
		alert('제목을 입력해주세요.');
		return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["Contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	try {
		form.submit();
	} catch(e) {}
}

</script>
<!-- #include file="../inc/footer.asp" -->