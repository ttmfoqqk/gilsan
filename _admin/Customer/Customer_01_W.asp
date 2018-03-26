<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrCate
Dim cntCate  : cntCate  = -1

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName : UserName = request("UserName")
Dim UserId   : UserId   = request("UserId")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim BoardKey : BoardKey = request("BoardKey")
Dim tap      : tap      = IIF( request("tap")="",0,request("tap") )
Dim Title    : Title    = request("Title")
Dim Idx      : Idx      = IIF( request("Idx")="" , 0 , request("Idx") )

Dim actType  : actType  = request("actType")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&tap="      & tap &_
		"&Title="    & Title


Call Expires()
Call dbopen()
	Call BoardCodeList()
	Call BoardCodeView()
	Call GetList()
Call dbclose()

Sub BoardCodeList()
'왼쪽메뉴용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CODE_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "BoardCode")
	If NOT(objRs.BOF or objRs.EOF) Then
		BC_ARRY_LIST = objRs.GetRows()
		BC_CNT_LIST  = UBound(BC_ARRY_LIST, 2)
		BC_FIRST_KEY = BC_ARRY_LIST(BoardCode_Idx, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub


Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_V"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = BoardKey
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	'카테고리
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "CATE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrCate		= objRs.GetRows()
		cntCate		= UBound(arrCate, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<script type="text/javascript">
$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=check_idx]').attr({"checked":"checked"}) : $('input[name=check_idx]').attr({"checked":""});
	});
} );
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		<%
		If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then 
			Response.write "잘못된 게시판 코드 입니다."
		Else
		%>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="Customer_01_P.asp" enctype="multipart/form-data">
				<input type="hidden" name="oldFileName" value="<%=FI_File_name%>">
				<!--input type="hidden" name="oldFileName2" value="<%=FI_File_name2%>"-->
				<input type="hidden" name="Idx" value="<%=FI_Idx%>">
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , IIF(actType="ANS","INSERT","UPDATE") )%>">
				<input type="hidden" name="UserId" value="<%=FI_UserId%>">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">
				<input type="hidden" name="userEmail" value="<%=FI_email%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<%If BoardKey = "22" Or BoardKey = "23" Or BoardKey = "24" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">카테고리</td>
								<td class="line_box">
									<select name="tap" id="tap">
										<option value="">선택</option>
										<%for iLoop = 0 to cntCate%>
										<option value="<%=arrCate(CATE_Idx,iLoop)%>" <%=IIF( CStr(IIF( FI_tap="",tap,FI_tap )) = CStr(arrCate(CATE_Idx,iLoop)) ,"selected","" )%>><%=arrCate(CATE_name,iLoop)%></option>
										<%next%>
									</select>
								</td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" name="Title" class="input" value="<%= TagDecode( FI_Title )%>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box">
									<textarea name="Contants" id="Contants" style="width:100%;height:300px;display:none;"><%=FI_Contants & IIF(actType="ANS","<br>---- 원본글 ----","")%></textarea>
								</td>
							</tr>
							<%If BoardKey <> "19" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">첨부파일</td>
								<td class="line_box">
									<input type="file" name="FileName" class="input">
									<%If FI_File_name<>"" And actType<>"ANS" Then %>
									<a href="../../common/download.asp?pach=/upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
									<input type="checkbox" value="1" name="DellFileFg"> 기존파일 삭제
									<%End If%>
								</td>
							</tr>
							<%End If%>
							<%If BoardKey <> "19" and BoardKey <> "25" and BoardKey <> "26" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">공지</td>
								<td class="line_box"><input type="checkbox" value="1" name="Notice" <%=IIF( FI_Notice="1","checked","" )%>></td>
							</tr>
							<%End If%>

							<%If BoardKey = "25" or BoardKey = "26" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box">
									<input type="text" name="order" id="order" maxlength="4" size="4" value="<%=IIF( FI_order="","0",FI_order )%>">
								</td>
							</tr>
							<%End If%>
							
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2 class="btnArea">
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="submitContents()">
						<a href="Customer_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
			</table>
		<%End If%>
		</td>
	</tr>
</form>
</table>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contants",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
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

function submitContents() {
	var form=document.AdminForm;

	if( $('#tap').length > 0 && !trim( $('#tap').val() ) ){
		alert("카테고리를 입력하세요.");return false;
	}
	if( !trim( form.Title.value ) ){
		alert("제목을 입력하세요.");return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["Contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	//document.getElementById("content").value
	try {
		form.submit();
	} catch(e) {}
}

</script>
<!-- #include file = "../inc/bottom.asp" -->