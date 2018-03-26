<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)


Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap      : tap      = IIF( request("tap")="",0,request("tap") )
Dim position : position = request("position")
Dim userName : userName = request("userName")
Dim Career   : Career   = request("Career")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&tap="      & tap &_
		"&position=" & position &_
		"&userName=" & userName &_
		"&Career="   & Career &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate

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
	Call GetList()
Call dbclose()



Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_STAFF_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@tap").value      = tap
		.Parameters("@position").value = position
		.Parameters("@name").value     = userName
		.Parameters("@Career").value   = Career
		.Parameters("@inDate").value   = Indate
		.Parameters("@outDate").value  = Outdate
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
		$(this).attr('checked') == true ? $('input[name=idx]').attr({"checked":"checked"}) : $('input[name=idx]').attr({"checked":""});
	});
} );
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='idx']:checked").length==0 ){
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
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성일</td>
								<td class="line_box" colspan=3>
								<input type="text" class="input" id="Indate" name="Indate" readonly value="<%=Indate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Indate);"> - 
								<input type="text" class="input" id="Outdate" name="Outdate" readonly value="<%=Outdate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Outdate);"> 
								<a href="javascript:date_input('Indate','Outdate','<%=Date%>','<%=Date%>')">[오늘]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7일전]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30일전]</a>
								&nbsp;
								<a href="javascript:date_input('Indate','Outdate','','')">[날짜초기화]</a>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이름</td>
								<td class="line_box"><input type="text" class="input" name="UserName" value="<%=UserName%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">직책</td>
								<td class="line_box" width="250"><input type="text" class="input" name="position" value="<%=position%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">취급품목</td>
								<td class="line_box"><input type="text" class="input" name="Career" value="<%=Career%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">소속</td>
								<td class="line_box" width="250">
									<select name="tap">
										<option value="">선택</option>
										<option value="1" <%=IIF( tap="1","selected","" )%>>길산파이프(주)</option>
										<option value="2" <%=IIF( tap="2","selected","" )%>>길산스틸(주) 계룡본사</option>
										<option value="3" <%=IIF( tap="3","selected","" )%>>길산스틸(주) 대전지점</option>
										<option value="4" <%=IIF( tap="4","selected","" )%>>길산스틸(주) 광주지점</option>
										<option value="5" <%=IIF( tap="5","selected","" )%>>길산에스티(주)</option>
										<option value="6" <%=IIF( tap="6","selected","" )%>>길산에스티(주) 코일센터</option>
										<option value="7" <%=IIF( tap="7","selected","" )%>>길산에스에스티(주)</option>
										<option value="8" <%=IIF( tap="8","selected","" )%>>(주)길산골프클럽 원내동</option>
										<option value="9" <%=IIF( tap="9","selected","" )%>>(주)길산골프클럽 유상지점</option>
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
						<form name="AdminForm" method="post" action="staff_01_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="50">번호</td>
								<td class="line_box" width="15%">소속</td>
								<td class="line_box" width="15%">직책</td>
								<td class="line_box" width="20%">이름</td>
								<td class="line_box" >연락처</td>
								<td class="line_box" width="5%">순서</td>
								<td class="line_box" width="15%">등록일</td>
							</tr>
							
							<%
							for iLoop = 0 to cntList
							PageLink = "location.href='staff_01_W.asp?" & PageParams & "&idx=" & arrList(FI_Idx,iLoop) & "'"
							
							If arrList(FI_tap,iLoop)="1" Then
								position_txt = "길산파이프(주)"
							ElseIf arrList(FI_tap,iLoop)="2" Then
								position_txt = "길산스틸(주) 계룡본사"
							ElseIf arrList(FI_tap,iLoop)="3" Then
								position_txt = "길산스틸(주) 대전지점"
							ElseIf arrList(FI_tap,iLoop)="4" Then
								position_txt = "길산스틸(주) 광주지점"
							ElseIf arrList(FI_tap,iLoop)="5" Then
								position_txt = "길산에스티(주)"
							ElseIf arrList(FI_tap,iLoop)="6" Then
								position_txt = "길산에스티(주) 코일센터"
							ElseIf arrList(FI_tap,iLoop)="7" Then
								position_txt = "길산에스에스티(주)"
							ElseIf arrList(FI_tap,iLoop)="8" Then
								position_txt = "(주)길산골프클럽 원내동"
							ElseIf arrList(FI_tap,iLoop)="9" Then
								position_txt = "(주)길산골프클럽 유상지점"
							Else
								position_txt = ""
							End If
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;" ><input type="checkbox" name="idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=position_txt%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_position,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_name,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_phone1,iLoop)%>-<%=arrList(FI_phone2,iLoop)%>-<%=arrList(FI_phone3,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_order,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=Left(arrList(FI_indate,iLoop),10)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>등록된 내용이 없습니다.</td>
							</tr>
							<%end if%>
						</table>

						</form>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="staff_01_W.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		
		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->