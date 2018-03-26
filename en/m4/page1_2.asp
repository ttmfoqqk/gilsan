<!-- #include file="../inc/top.asp" -->
<%
checkLogin( g_host & g_url )

Dim arrList
Dim cntList   : cntList  = -1
Dim cntTotal  : cntTotal = 0
Dim orderCode : orderCode   = Request("orderCode")

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

If orderCode = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 주문번호 입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_ORDER_BASKET_L"
		.Parameters("@ID").value     = session("userId")
		.Parameters("@ODNO").value   = orderCode
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

<STYLE type="text/css">
	table.reserve_table td{cursor:auto;}
</STYLE>

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">온라인주문</span><span class="block2">온라인주문</span>
		</div>
	</div>
	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">온라인주문 현황</h3>
			
			<form name="mForm" id="mForm" method="post" action="page1_2_proc.asp">
				<input type="hidden" id="orderCode" name="orderCode" value="<%=orderCode%>">
				<input type="hidden" id="seq" name="seq" value="">
				<input type="hidden" id="actType" name="actType" value="">
			</form>

			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:50px;">번호</th>
					<th>품목구분</th>
					<th style="width:150px;">품명</th>
					<th style="width:50px;">두께</th>
					<th style="width:50px;">호칭경</th>
					<th style="width:50px;">길이</th>
					<th style="width:50px;">수량</th>
					
					<th style="width:80px;">주문일자</th>

					<th style="width:50px;">수정</th>
					<th style="width:50px;">삭제</th>
				</tr>
				<%for iLoop = 0 to cntList%>
				<tr>
					<td><%=arrList(FI_rownum,iLoop)%></td>
					<td><%=arrList(FI_typename,iLoop)%></td>
					<td><%=arrList(FI_PRODUCT_NAME,iLoop)%></td>
					<td><%=arrList(FI_THICK,iLoop)%></td>
					<td><%=arrList(FI_EXTDIA,iLoop)%></td>
					<td><%=arrList(FI_LENGTH,iLoop)%></td>
					<td><%=arrList(FI_QTY,iLoop)%></td>
					
					<td><%=Left(arrList(FI_INDATETIME,iLoop),10)%></td>

					<td><button type="button" class="btn" style="width:80%;" onclick="pop_modify(<%=arrList(FI_SEQ,iLoop)%>)">수정</button></td>
					<td><button type="button" class="btn" style="width:80%;" onclick="basket_delete(<%=arrList(FI_SEQ,iLoop)%>)">삭제</button></td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then%>
				<tr">
					<td colspan="10">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>

			
			
			<div style="margin:30px;text-align:center;" id="submit_area">
				<%If cntList > -1 Then%>
				<p style="margin-bottom:20px;font-size:14px;">주문 완료버튼을 클릭하셔야 최종 주문이 완료됩니다.</p>
				<button type="btn" class="btn" onclick="document.location.href='page1_1.asp?orderCode=<%=orderCode%>&companyCode=<%=arrList(FI_COCODE,0)%>';">추가주문</button>
				<button type="btn" class="btn" onclick="basket_insert();">주문완료</button>
				<%Else%>
				<button type="btn" class="btn" onclick="document.location.href='page1_1.asp';">온라인주문</button>
				<%End If%>

			</div>

			</form>
		</div>
	</div>
</div>
<script type="text/JavaScript" src="order.js"></script>
<!-- #include file="../inc/footer.asp" -->