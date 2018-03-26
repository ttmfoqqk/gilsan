<!-- #include file="../inc/top.asp" -->
<%
checkLogin( g_host & g_url )

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim indate   : indate   = request("indate")
Dim outdate  : outdate   = request("outdate")

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL , PageParams

pageURL    = g_url & "?pageNo=__PAGE__&indate=" & indate & "&outdate=" & outdate
PageParams = "pageNo=" & pageNo & "&indate=" & indate & "&outdate=" & outdate


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_ORDER_GROUP_L"
		.Parameters("@rows").value    = rows 
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@ID").value      = session("userId")
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
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">마이페이지</span><span class="block2">나의 주문현황</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<div style="position:relative;">
				<h3 class="title">나의 주문현황</h3>

				<div style="position:absolute;top:5px;right:0px;">
					<form name="form_more_pop" id="form_more_pop" method="GET">
					<div class="row">
						<label style="margin-right:10px;font-size:14px;">주문일자 </label>
						<input type="text" id="indate" name="indate" class="input" style="width:80px;padding:0px;" onclick="callCalendar(form_more_pop.indate);" readonly maxlength="10" value="<%=indate%>">
						<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.indate);" style="vertical-align:top;height:30px;cursor:pointer;">
						~
						<input type="text" id="outdate" name="outdate" class="input" style="width:80px;padding:0px;" onclick="callCalendar(form_more_pop.outdate);" readonly maxlength="10" value="<%=outdate%>">
						<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.outdate);" style="vertical-align:top;height:30px;cursor:pointer;">

						<button type="submit" class="btn" style="height:30px;width:50px;">검색</button>
						<button type="button" class="btn" onclick="$('#indate').val('');$('#outdate').val('');" style="height:30px;width:50px;">초기화</button>
					</div>
					</form>
				</div>
			</div>
			
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:40px;">번호</th>
					<th style="width:80px;">주문ID</th>
					<th style="width:70px;">품목구분</th>
					<th>품명</th>
					<th style="width:40px;">두께</th>
					<th style="width:40px;">호칭경</th>
					<th style="width:50px;">길이</th>
					<th style="width:50px;">수량</th>
					<th style="width:70px;">주문상태</th>
					<th style="width:55px;">승인수량</th>					
					<th style="width:70px;">납기예정</th>
				</tr>
				<%for iLoop = 0 to cntList
					onclick = "location.href='page5_view.asp?" & PageParams & "&orderCode=" & arrList(FI_ODNO,iLoop) & "'"

					ex_text = ""
					If arrList(FI_SUB_CNT,iLoop) > 1 Then 
						ex_text = "외" & arrList(FI_SUB_CNT,iLoop) -1 & "건"
					End If
				%>
				<tr>
					<td onclick="<%=onclick%>"><%=arrList(FI_rownum,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_ID,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_typename,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_PRODUCT_NAME,iLoop)%>&nbsp;<%=ex_text%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_THICK,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_EXTDIA,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_LENGTH,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_QTY,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_STATUS,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_SoQTY,iLoop)%></td>					
					<td onclick="<%=onclick%>">
						<%
						If arrList(FI_submitDate,iLoop) <> "" And Len( arrList(FI_submitDate,iLoop) ) >= 8 Then
							Response.write Left(arrList(FI_submitDate,iLoop),4)&"-"&Mid(arrList(FI_submitDate,iLoop), 5, 2)&"-"&Right(arrList(FI_submitDate,iLoop), 2)
						Else
							Response.write "미정"
						End If
						%>
					</td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then%>
				<tr">
					<td colspan="11">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>

			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>

		</div>
	</div>


</div>

<!-- #include file="../inc/footer.asp" -->