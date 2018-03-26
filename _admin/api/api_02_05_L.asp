<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim sname    : sname    = request("sname")
Dim cate1    : cate1    = request("cate1")
Dim cate2    : cate2    = request("cate2")
Dim cate3    : cate3    = request("cate3")
Dim cate4    : cate4    = request("cate4")
Dim usFg     : usFg     = request("usFg")

Dim mfIdx    : mfIdx    = request("mfIdx")
Dim modelIdx : modelIdx = request("modelIdx")
Dim inDate   : inDate   = request("inDate")
Dim outDate  : outDate  = request("outDate")


Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&sname=" & sname &_
		"&cate1=" & cate1 &_
		"&cate2=" & cate2 &_
		"&cate3=" & cate3 &_
		"&cate4=" & cate4 &_
		"&mfIdx=" & mfIdx &_
		"&modelIdx=" & modelIdx &_
		"&usFg=" & usFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&sname=" & sname &_
		"&cate1=" & cate1 &_
		"&cate2=" & cate2 &_
		"&cate3=" & cate3 &_
		"&cate4=" & cate4 &_
		"&mfIdx=" & mfIdx &_
		"&modelIdx=" & modelIdx &_
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
		.CommandText      = "KETI_API_DEVICE_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@cate1").value    = cate1
		.Parameters("@cate2").value    = cate2
		.Parameters("@cate3").value    = cate3
		.Parameters("@cate4").value    = cate4
		.Parameters("@name").value     = sname
		.Parameters("@usFg").value     = usFg
		.Parameters("@mmfIdx").value   = mfIdx
		.Parameters("@modelIdx").value = modelIdx
		.Parameters("@inDate").value   = inDate
		.Parameters("@outDate").value  = outDate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

%>
<script type="text/javascript">
$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=Idx]').attr({"checked":"checked"}) : $('input[name=Idx]').attr({"checked":""});
	});

	deviceCategoryOption(1,0,'#cate1','<%=cate1%>');
	deviceCategoryOption(2,'<%=cate1%>','#cate2','<%=cate2%>');
	deviceCategoryOption(3,'<%=cate2%>','#cate3','<%=cate3%>');
	deviceCategoryOption(4,'<%=cate3%>','#cate4','<%=cate4%>');
	$('#cate1').change(function(){
		deviceCategoryOption(2,$(this).val(),'#cate2','<%=cate2%>');
	})
	$('#cate2').change(function(){
		deviceCategoryOption(3,$(this).val(),'#cate3','<%=cate3%>');
	})
	$('#cate3').change(function(){
		deviceCategoryOption(4,$(this).val(),'#cate4','<%=cate4%>');
	})
	

	deviceCategoryOption(10,0,'#mfIdx','<%=mfIdx%>');
	deviceCategoryOption(11,'<%=mfIdx%>','#modelIdx','<%=modelIdx%>');
	$('#mfIdx').change(function(){
		deviceCategoryOption(11,$(this).val(),'#modelIdx','<%=modelIdx%>');
	})
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
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 디바이스 API 관리 </td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box"  colspan=3>
									<select id="cate1" name="cate1" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate2" name="cate2" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate3" name="cate3" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate4" name="cate4" style="width:145px;">
										<option value="">선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제조사/모델</td>
								<td class="line_box"  colspan=3>
									<select id="mfIdx" name="mfIdx" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="modelIdx" name="modelIdx" style="width:145px;">
										<option value="">선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">검색어</td>
								<td class="line_box" width="250"><input type="text" class="input" name="sname" value="<%=sname%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select id="State" name="usFg">
										<option value="">선택</option>
										<option value="0" <%=IIF( usFg = "0" , "selected" , "" )%>>사용</option>
										<option value="1" <%=IIF( usFg = "1" , "selected" , "" )%>>미사용</option>
									</select>
								</td>
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
						<form name="AdminForm" method="post" action="api_02_05_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="sname" value="<%=sname%>">
						<input type="hidden" name="scate1" value="<%=cate1%>">
						<input type="hidden" name="scate2" value="<%=cate2%>">
						<input type="hidden" name="scate3" value="<%=cate3%>">
						<input type="hidden" name="scate4" value="<%=cate4%>">
						<input type="hidden" name="susFg" value="<%=usFg%>">
						<input type="hidden" name="mfIdx" value="<%=mfIdx%>">
						<input type="hidden" name="modelIdx" value="<%=modelIdx%>">
						<input type="hidden" name="sinDate" value="<%=inDate%>">
						<input type="hidden" name="soutDate" value="<%=outDate%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="20"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="25">번호</td>
								<td class="line_box" width="10%">분류1</td>
								<td class="line_box" width="10%">분류2</td>
								<td class="line_box" width="10%">분류3</td>
								<td class="line_box" width="10%">분류4</td>
								<td class="line_box" width="10%">제조사</td>
								<td class="line_box" width="10%">모델</td>
								<td class="line_box">디바이스명</td>
								<td class="line_box" width="7%">사용</td>
								<td class="line_box" width="10%">입력일자</td>
								<td class="line_box" width="5%">조회</td>
							</tr>
							<%
								for iLoop = 0 to cntList
								PageLink = "location.href='api_02_05_W.asp?" & PageParams & "&Idx=" & arrList(FI_Idx,iLoop) & "'"
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;"><input type="checkbox" name="Idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_category1,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_category2,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_category3,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_category4,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_mfName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_model,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_name,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=IIF(arrList(FI_usFg,iLoop)="0","사용","<font color='red'>미사용</font>")%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_date,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_cnt,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="11" align=center>등록된 내용이 없습니다.</td>
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
						<a href="api_02_05_W.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
				
				</form>
			</table>

		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->