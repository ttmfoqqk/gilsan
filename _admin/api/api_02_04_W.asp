<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrCate
Dim cntCate  : cntCate  = -1


Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )
Dim name     : name     = request("name")
Dim parent   : parent   = request("parent")
Dim usFg     : usFg     = request("usFg")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&name=" & name &_
		"&parent=" & parent &_
		"&usFg=" & usFg

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
		.CommandText      = "KETI_API_DEVICE_MODEL_V"
		.Parameters("@idx").value = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")

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
function save(){
	if( !trim( $('#parent').val() ) ){
		alert('제조사를 선택해주세요.');
		return false;
	}
	if( !trim( $('#name').val() ) ){
		alert('모델명을 입력해주세요.');
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
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 디바이스 API 모델 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form name="AdminForm" method="POST" action="api_02_04_P.asp" enctype="multipart/form-data" onsubmit="return save();">
				<input type="hidden" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="idx" value="<%=FI_idx%>">
				<input type="hidden" name="sname" value="<%=name%>">
				<input type="hidden" name="sparent" value="<%=parent%>">
				<input type="hidden" name="susFg" value="<%=usFg%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제조사</td>
								<td class="line_box">
									<select id="parent" name="parent">
										<option value="">선택</option>
										<%for iLoop = 0 to cntCate%>
										<option value="<%=arrCate(CATE_idx,iLoop)%>" <%=IIF( CStr(arrCate(CATE_idx,iLoop)) = FI_parentidx , "selected" , "" )%>><%=arrCate(CATE_name,iLoop)%></option>
										<%Next%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">모델명</td>
								<td class="line_box"><input type="text" style="width:100%" id="name" name="name" class="input" value="<%= TagDecode( FI_name )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box"><input type="text" id="order" name="order" class="input" size="7" maxlength="7" onkeyup="onlyNumber(this)" value="<%=IIF(FI_order="",0,FI_order)%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select id="usFg" name="usFg">
										<option value="0" <%=IIF( FI_usFg = "0" , "selected" , "" )%>>사용</option>
										<option value="1" <%=IIF( FI_usFg = "1" , "selected" , "" )%>>미사용</option>
									</select>
								</td>
							</tr>
							
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_write_ok.gif">
						<a href="api_02_04_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->