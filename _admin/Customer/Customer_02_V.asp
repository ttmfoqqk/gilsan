<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim Idx      : Idx      = Request("Idx")

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim BoardKey : BoardKey = request("BoardKey")
Dim Title    : Title    = request("Title")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&Title="    & Title

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
		.CommandText      = "M_BOARD_TAP_V"
		.Parameters("@idx").value = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>

<script type="text/javascript">
function save(){
	if( !trim( $('#BoardKey').val() ) ){
		alert('게시판을 선택해주세요.');
		return false;
	}
	if( !trim( $('#name').val() ) ){
		alert('카테고리를 입력해주세요.');
		return false;
	}
	if( !trim( $('#order').val() ) ){
		alert('순서를 입력해주세요.');
		return false;
	}
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 카테고리 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form name="AdminForm" method="POST" action="Customer_02_P.asp" onsubmit="return save();">
				<input type="hidden" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">
				<input type="hidden" name="idx" value="<%=FI_idx%>">
				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">게시판</td>
								<td class="line_box">
									<select name="BoardKey" id="BoardKey">
										<option value="">선택</option>
										<option value="22" <%=IIF( IIF(FI_Key="",BoardKey,FI_Key) = "22" , "selected" , "" )%>>길산소개</option>
										<option value="23" <%=IIF( IIF(FI_Key="",BoardKey,FI_Key) = "23" , "selected" , "" )%>>길산행사</option>
										<option value="24" <%=IIF( IIF(FI_Key="",BoardKey,FI_Key) = "24" , "selected" , "" )%>>길산축제</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">카테고리 명</td>
								<td class="line_box"><input type="text" style="width:100%" id="name" name="name" class="input" value="<%= TagDecode( FI_name )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box"><input type="text" id="order" name="order" class="input" size="7" maxlength="7" onkeyup="onlyNumber(this)" value="<%=IIF(FI_order="",0,FI_order)%>"></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_write_ok.gif">
						<a href="Customer_02_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>

</table>

<!-- #include file = "../inc/bottom.asp" -->