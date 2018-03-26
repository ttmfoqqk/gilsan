<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim rows      : rows      = 20

Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim userName  : userName  = request("userName")
Dim area      : area      = request("area")
Dim state     : state     = request("state")
Dim cSdate    : cSdate    = request("cSdate")
Dim cEdate    : cEdate    = request("cEdate")
Dim Other1    : Other1    = request("Other1")

Dim pageParam
pageParam = "pageNo="& pageNo &_
		"&userName=" & userName   &_
		"&area="     & area   &_
		"&state="    & state  &_
		"&cSdate="   & cSdate &_
		"&cEdate="   & cEdate &_
		"&Other1="   & Other1

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&userName=" & userName   &_
		"&area="     & area   &_
		"&state="    & state  &_
		"&cSdate="   & cSdate &_
		"&cEdate="   & cEdate &_
		"&Other1="   & Other1

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
		.CommandText      = "KETI_IOT_NEW_RESERVE_L"
		.Parameters("@pageNo").value = pageNo
		.Parameters("@rows").value   = rows
		.Parameters("@name").value   = userName
		.Parameters("@area").value   = area
		.Parameters("@state").value  = state
		.Parameters("@cSdate").value = cSdate
		.Parameters("@cEdate").value = cEdate
		.Parameters("@Other1").value = Other1
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
<SCRIPT type="text/javascript">
$(function(){
	getCodeAdd_combobox('#area','<%=fc_reserve_code_list("area","","")%>','name');
	$("#area > option[value = <%=area%>]").attr("selected", "ture");
});

</SCRIPT>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%" style="padding-bottom:3px;"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 예약현황 </td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용일</td>
								<td class="line_box" colspan=3>
									<input type="text" class="input" id="cSdate" name="cSdate" readonly value="<%=cSdate%>" size=15> 
									<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.cSdate);"> - 
									<input type="text" class="input" id="cEdate" name="cEdate" readonly value="<%=cEdate%>" size=15> 
									<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.cEdate);"> 

									<a href="javascript:date_input('cSdate','cEdate','<%=Date%>','<%=Date%>')">[오늘]</a>
									<a href="javascript:date_input('cSdate','cEdate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7일전]</a>
									<a href="javascript:date_input('cSdate','cEdate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30일전]</a>
									&nbsp;
									<a href="javascript:date_input('cSdate','cEdate','','')">[날짜초기화]</a>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">예약자</td>
								<td class="line_box" width="250">
									<input type="text" class="input" name="userName" value="<%=userName%>">
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">좌석번호</td>
								<td class="line_box">
									<select id="area" name="area">
										<option value="">선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용목적</td>
								<td class="line_box" width="250">
									<input type="text" class="input" name="Other1" value="<%=Other1%>">
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">진행상황</td>
								<td class="line_box">
									<select id="state" name="state">
										<option value="">선택</option>
										<option value="0">예약완료</option>
										<option value="1">신청</option>
										<option value="2">본인취소</option>
										<option value="3">대리취소</option>
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
					<td align="right" colspan="2"><img src="../img/btn_calender.gif" style="cursor:pointer;" onclick="alert('준비중')"><img src="../img/btn_area.gif" style="cursor:pointer;" onclick="window.open('../../openIot/lab/pop_area.html','calender','width=730,height=460');"></td>
				</tr>
				<tr>
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
					
						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed;">
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="40">번호</td>
								<td class="line_box" width="8%">예약자</td>
								<td class="line_box" width="20%">사용일</td>
								<td class="line_box" width="20%">좌석번호</td>
								<td class="line_box">사용목적</td>
								<td class="line_box" width="10%">진행상황</td>
								<td class="line_box" width="10%">등록일자</td>
							</tr>
							<%
							Dim PageLink,StateTxt
							for iLoop = 0 to cntList
								PageLink   = "location.href='dev_Reserve_01_V.asp?" & pageParam & "&idx="& arrList(FI_idx,iLoop) &"';"

								If arrList(FI_state,iLoop) = "0" Then 
									StateTxt = "<font color=red>예약완료</font>"
								ElseIf arrList(FI_state,iLoop) = "1" Then
									StateTxt = "신청"
								ElseIf arrList(FI_state,iLoop) = "2" Then
									StateTxt = "<font color=blue>본인취소</font>"
								ElseIf arrList(FI_state,iLoop) = "3" Then
									StateTxt = "<font color=blue>대리취소</font>"
								ElseIf arrList(FI_state,iLoop) = "9" Then
									StateTxt = "삭제"
								End If
							%>
							<tr height="30" align=center>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_UserName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_cSdate,iLoop)%>~<%=arrList(FI_cEdate,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;"><%=arrySort( arrList(FI_areaName,iLoop) , ",")%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Other1,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=StateTxt%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=Left(arrList(FI_indate,iLoop),10)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="7" align=center>등록된 내용이 없습니다.</td>
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
			</table>

		</td>
	</tr>
</table>
<!-- #include file = "../inc/bottom.asp" -->