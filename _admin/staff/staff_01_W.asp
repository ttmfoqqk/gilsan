<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap      : tap      = IIF( request("tap")="",0,request("tap") )
Dim position : position = request("position")
Dim userName : userName = request("userName")
Dim Career   : Career   = request("Career")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tap="      & tap &_
		"&position=" & position &_
		"&userName=" & userName &_
		"&Career="   & Career &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate


Call Expires()
Call dbopen()
	Call GetView()
Call dbclose()


Sub GetView()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_STAFF_V"
		.Parameters("@Idx").value = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
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
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="staff_01_P.asp" enctype="multipart/form-data" onsubmit="return check();">
				<input type="hidden" name="oldFileName" value="<%=FI_File_name%>">
				<input type="hidden" name="idx" value="<%=FI_Idx%>">
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">소속</td>
								<td class="line_box">
									<select name="tap" id="tap">
										<option value="1" <%=IIF( FI_tap="1","selected","" )%>>길산파이프(주)</option>
										<option value="2" <%=IIF( FI_tap="2","selected","" )%>>길산스틸(주) 계룡본사</option>
										<option value="3" <%=IIF( FI_tap="3","selected","" )%>>길산스틸(주) 대전지점</option>
										<option value="4" <%=IIF( FI_tap="4","selected","" )%>>길산스틸(주) 광주지점</option>
										<option value="5" <%=IIF( FI_tap="5","selected","" )%>>길산에스티(주)</option>
										<option value="6" <%=IIF( FI_tap="6","selected","" )%>>길산에스티(주) 코일센터</option>
										<option value="7" <%=IIF( FI_tap="7","selected","" )%>>길산에스에스티(주)</option>
										<option value="8" <%=IIF( FI_tap="8","selected","" )%>>(주)길산골프클럽 원내동</option>
										<option value="9" <%=IIF( FI_tap="9","selected","" )%>>(주)길산골프클럽 유상지점</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">직책</td>
								<td class="line_box"><input type="text" style="width:100%" name="position" id="position" class="input" value="<%=FI_position%>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이름</td>
								<td class="line_box"><input type="text" style="width:100%" name="userName" id="userName" class="input" value="<%=FI_name%>" maxlength="50"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">연락처</td>
								<td class="line_box">
									<select name="phone1" id="phone1"></select> - 
									<input type="text" name="phone2" id="phone2" maxlength="4" size="4" value="<%=FI_phone2%>"> - 
									<input type="text" name="phone3" id="phone3" maxlength="4" size="4" value="<%=FI_phone3%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">취급품목</td>
								<td class="line_box">
									<textarea name="Career" id="Career" style="width:100%;height:300px;display:none;"><%=FI_Career%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사진</td>
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
						<a href="staff_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
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
	elPlaceHolder: "Career",
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
		alert('소속을 선택해주세요.');
		return false;
	}
	if( !trim($('#position').val()) ){
		alert('직책을 입력해주세요.');
		return false;
	}
	if( !trim($('#userName').val()) ){
		alert('이름을 입력해주세요.');
		return false;
	}
	if( !trim($('#phone1').val()) || !trim($('#phone2').val()) || !trim($('#phone3').val()) ){
		alert('연락처를 입력해주세요.');
		return false;
	}
	if( !trim($('#order').val()) ){
		alert('순서를 입력해주세요.');
		return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["Career"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
}

</script>
<!-- #include file = "../inc/bottom.asp" -->