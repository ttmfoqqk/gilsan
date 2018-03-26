<!-- #include file="../inc/top.asp" -->
<%
Dim arrList , arrNoti
Dim cntList  : cntList  = -1
Dim cntNoti  : cntNoti  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"
Dim PageParams : PageParams = "pageNo=" & pageNo


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@Key").value      = 20
		.Parameters("@UserName").value = UserName
		.Parameters("@UserId").value   = UserId
		.Parameters("@Indate").value   = Indate
		.Parameters("@Outdate").value  = Outdate
		.Parameters("@tap").value      = tap
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	'공지사항
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "NOTICE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrNoti		= objRs.GetRows()
		cntNoti		= UBound(arrNoti, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">질문과 답변</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">질문과 답변</h3>

			<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:12px;margin-bottom:10px;table-layout:fixed;">
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:60px;text-align:center;font-size:14px;"><b>번호</b></td>
					<td style="border-bottom:1px solid #4f4f4f;text-align:center;font-size:14px;"><b>제목</b></td>
					<td style="border-bottom:1px solid #4f4f4f;width:70px;text-align:center;font-size:14px;"><b>작성자</b></td>
					<td style="border-bottom:1px solid #4f4f4f;width:90px;text-align:center;font-size:14px;"><b>등록일</b></td>
					<td style="border-bottom:1px solid #4f4f4f;width:70px;text-align:center;font-size:14px;"><b>조회수</b></td>
				</tr>
				<%for iLoop = 0 to cntNoti
					onclick = "location.href='page2_view.asp?" & PageParams & "&idx=" & arrNoti(NOTICE_Idx,iLoop) & "'"
				%>
				<tr style="height:40px;">
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><b style="color_red">[공지]</b></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;padding-left:10px;cursor:pointer;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><%=arrNoti(NOTICE_Title,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrNoti(NOTICE_ContName,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrNoti(NOTICE_Indate,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrNoti(NOTICE_Read_cnt,iLoop)%></td>
				</tr>
				<%Next%>
				<%for iLoop = 0 to cntList
					onclick = "location.href='page2_view.asp?" & PageParams & "&idx=" & arrList(FI_Idx,iLoop) & "'"

					nbsp = ""
					If arrList(FI_Depth_no, iLoop) > 0 Then 
						for Depth = 2 to arrList(FI_Depth_no, iLoop)
							nbsp = nbsp & "&nbsp;&nbsp;&nbsp;&nbsp;"
						Next
						nbsp = nbsp & "<b>></b> [RE] "
					End If
				%>
				<tr style="height:40px;">
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrList(FI_rownum,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;padding-left:10px;cursor:pointer;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><%=nbsp & arrList(FI_Title,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrList(FI_ContName,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrList(FI_Indate,iLoop)%></td>
					<td onclick="<%=onclick%>" style="border-bottom:1px solid #4f4f4f;text-align:center;cursor:pointer;"><%=arrList(FI_Read_cnt,iLoop)%></td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then%>
				<tr style="height:40px;">
					<td colspan="5" style="border-bottom:1px solid #4f4f4f;text-align:center;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>
			<div style="text-align:right;margin-bottom:10px;">
				<button class="btn_bg" style="width:80px;" onclick="location.href='page2_write.asp?<%=PageParams%>'">글쓰기</button>
			</div>

			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>

		</div>
	</div>


</div>

<!-- #include file="../inc/footer.asp" -->