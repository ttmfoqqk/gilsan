<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrList  , arrList2
Dim cntList2 : cntList2 = -1

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap      : tap      = IIF( request("tap")="",0,request("tap") )
Dim menu     : menu     = IIF( request("menu")="",0,request("menu") )
Dim title    : title    = request("title")
Dim contants : contants = request("contants")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tap="      & tap &_
		"&menu="     & menu &_
		"&title="    & title &_
		"&contants=" & contants &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate


Call Expires()
Call dbopen()
	Call GetMenuList()
	Call GetView()
Call dbclose()


Sub GetView()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "facility_view"
		.Parameters("@Idx").value = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub GetMenuList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "facility_menu_list"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "MENU")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList2	= objRs.GetRows()
		cntList2	= UBound(arrList2, 2)
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
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_02_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 시설안내관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="info_02_P.asp" enctype="multipart/form-data" onsubmit="return check();">
				<input type="hidden" name="oldFileName" value="<%=FI_File_name%>">
				<input type="hidden" name="idx" value="<%=FI_Idx%>">
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">지점</td>
								<td class="line_box">
									<select name="tap" id="tap">
										<option value="1" <%=IIF( FI_tap="1","selected","" )%>>원내동</option>
										<option value="2" <%=IIF( FI_tap="2","selected","" )%>>유상지점</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">메뉴</td>
								<td class="line_box">
									<select name="menu" id="menu">
										<option value="">선택</option>
										<%for iLoop = 0 to cntList2%>
										<option value="<%=arrList2(MENU_idx,iLoop)%>" <%=IIF( CStr(FI_menu) = CStr(arrList2(MENU_idx,iLoop)),"selected","" )%>><%=arrList2(MENU_name,iLoop)%></option>
										<%Next%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" name="title" id="title" class="input" value="<%=FI_name%>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box">
									<textarea name="contants" id="contants" style="width:100%;height:300px;display:none;"><%=FI_contants%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이미지</td>
								<td class="line_box">
									<input type="file" name="FileName" class="input">
									<%If FI_File_name <> "" Then %>
									<a href="../../common/download.asp?pach=/upload/m4/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
									<input type="checkbox" value="1" name="DellFileFg"> 기존파일 삭제
									<%End If%>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box">
									<input type="text" name="order" id="order" maxlength="4" size="4" value="<%=IIF( FI_order="","0",FI_order )%>">
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_save.gif" style="border:0px;">
						<a href="info_02_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
			</table>

		</td>
	</tr>
</form>
</table>
<script type="text/javascript">
getCodeAdd_combobox('#phone1','<%=fc_code_list(10)%>','','<%=FI_phone1%>','선택');

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contants",
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

function check() {
	
	if( !trim($('#tap').val()) ){
		alert('지점을 선택해주세요.');
		return false;
	}
	if( !trim($('#menu').val()) ){
		alert('메뉴를 선택해주세요.');
		return false;
	}
	if( !trim($('#title').val()) ){
		alert('제목을 입력해주세요.');
		return false;
	}
	if( !trim($('#order').val()) ){
		alert('순서를 입력해주세요.');
		return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
}

</script>
<!-- #include file = "../inc/bottom.asp" -->