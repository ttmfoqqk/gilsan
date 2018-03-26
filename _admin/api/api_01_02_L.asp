<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList  , arrCate
Dim cntList  : cntList  = -1
Dim cntCate  : cntCate  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim pname    : pname    = request("pname")
Dim tag      : tag      = request("tag")
Dim parent   : parent   = request("parent")
Dim usFg     : usFg     = request("usFg")
Dim inDate   : inDate   = request("inDate")
Dim outDate  : outDate  = request("outDate")


Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&pname=" & pname &_
		"&tag=" & tag &_
		"&parent=" & parent &_
		"&usFg=" & usFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&pname=" & pname &_
		"&tag=" & tag &_
		"&parent=" & parent &_
		"&usFg=" & usFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_API_PLATFORM_L"
		.Parameters("@rows").value    = rows 
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@name").value    = pname
		.Parameters("@tag").value     = tag
		.Parameters("@parent").value  = parent
		.Parameters("@usFg").value    = usFg
		.Parameters("@inDate").value  = inDate
		.Parameters("@outDate").value = outDate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If

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
		$(this).attr('checked') == true ? $('input[name=Idx]').attr({"checked":"checked"}) : $('input[name=Idx]').attr({"checked":""});
	});
} );
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='Idx']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%" style="padding-bottom:3px;"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 플랫폼 API 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">입력일자</td>
								<td class="line_box" colspan=3>
								<input type="text" class="input" id="inDate" name="inDate" readonly value="<%=inDate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.inDate);"> - 
								<input type="text" class="input" id="outDate" name="outDate" readonly value="<%=outDate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.outDate);"> 
								<a href="javascript:date_input('inDate','outDate','<%=Date%>','<%=Date%>')">[오늘]</a>
								<a href="javascript:date_input('inDate','outDate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7일전]</a>
								<a href="javascript:date_input('inDate','outDate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30일전]</a>
								&nbsp;
								<a href="javascript:date_input('inDate','outDate','','')">[날짜초기화]</a>
								</td>
							</tr>
							
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0">플랫폼명</td>
								<td class="line_box" width="250">
									<select name="parent">
										<option value="">선택</option>
										<%for iLoop = 0 to cntCate%>
										<option value="<%=arrCate(CATE_idx,iLoop)%>" <%=IIF( CStr(arrCate(CATE_idx,iLoop)) = parent , "selected" , "" )%>><%=arrCate(CATE_name,iLoop)%></option>
										<%Next%>
									</select>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select name="usFg">
										<option value="">선택</option>
										<option value="0" <%=IIF( usFg = "0" , "selected" , "" )%>>사용</option>
										<option value="1" <%=IIF( usFg = "1" , "selected" , "" )%>>미사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0">API명</td>
								<td class="line_box" width="250"><input type="text" class="input" name="pname" value="<%=pname%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">검색키워드</td>
								<td class="line_box"><input type="text" class="input" name="tag" value="<%=tag%>"></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align=center colspan=2><input type="image" src="../img/center_btn_Search.gif"></td>
				</tr>

				</form>

				<tr>
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
						<form name="AdminForm" method="post" action="api_01_02_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">

						<input type="hidden" name="pageNo" value="<%=pageNo%>">
						<input type="hidden" name="spname" value="<%=pname%>">
						<input type="hidden" name="tag" value="<%=tag%>">
						<input type="hidden" name="susFg" value="<%=usFg%>">
						<input type="hidden" name="sinDate" value="<%=inDate%>">
						<input type="hidden" name="soutDate" value="<%=outDate%>">

						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="50">번호</td>
								<td class="line_box" width="20%">플랫폼명</td>
								<td class="line_box">API명</td>
								<td class="line_box" width="10%">사용여부</td>
								<td class="line_box" width="10%">순서</td>
								<td class="line_box" width="10%">작성일</td>
							</tr>
							<%
							for iLoop = 0 to cntList
							PageLink = "location.href='api_01_02_W.asp?" & PageParams & "&idx=" & arrList(FI_Idx,iLoop) & "'"
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;"><input type="checkbox" name="Idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_category,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_apiName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=IIF(arrList(FI_usFg,iLoop)="0","사용","<font color='red'>미사용</font>")%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_order,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_date,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>등록된 내용이 없습니다.</td>
							</tr>
							<%end if%>
						</table>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="api_01_02_W.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
				
				</form>
			</table>

		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->