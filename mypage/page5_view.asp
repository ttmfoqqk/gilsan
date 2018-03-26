<!-- #include file="../inc/top.asp" -->
<%
checkLogin( g_host & g_url )

Dim arrList
Dim cntList   : cntList  = -1
Dim cntTotal  : cntTotal = 0
Dim rows      : rows     = 20
Dim pageNo    : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim orderCode : orderCode = request("orderCode")
Dim indate    : indate   = request("indate")
Dim outdate   : outdate   = request("outdate")

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

PageParams = "pageNo=" & pageNo & "&indate=" & indate & "&outdate=" & outdate

If cntList < 0 Or orderCode = "" Then 
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
		.CommandText      = "M_PRODUCT_ORDER_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
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
			<h3 class="title">나의 주문현황</h3>
			
			<STYLE type="text/css">
				table.reserve_table td{cursor:auto;}
			</STYLE>

			<form name="mForm" id="mForm" method="POST" action="../m4/orderPrint.asp">
			<input type="hidden" name="ODNO" value="<%=arrList(FI_ODNO,0)%>"/>
			</form>

			<h4 style="margin-bottom:20px;margin-top:20px;">주문내역</h4>
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:150px;">회사명</th>
					<td style="text-align:left;"><%=arrList(FI_CUSTNAME,0)%></td>
				</tr>
				<tr>
					<th style="width:150px;">주문일자</th>
					<td style="text-align:left;"><%=Left(arrList(FI_INDATETIME,iLoop),10)%></td>
				</tr>
				<tr>
					<th style="width:150px;">희망납기일</th>
					<td style="text-align:left;"><%=Left(arrList(FI_DUEDATE,0),4)&"-"&Mid(arrList(FI_DUEDATE,0), 5, 2)&"-"&Right(arrList(FI_DUEDATE,0), 2)%></td>
				</tr>
				<tr>
					<th style="width:150px;">하차장소</th>
					<td style="text-align:left;"><%=arrList(FI_UNLOADPLACE,0)%></td>
				</tr>
				<tr>
					<th style="width:150px;">기타사항</th>
					<td style="text-align:left;"><%=arrList(FI_REMARK,0)%></td>
				</tr>
			</table>
			
			<h4 style="margin-bottom:20px;margin-top:20px;">주문상품</h4>
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:50px;">번호</th>
					<th>품목구분</th>
					<th style="width:150px;">품명</th>
					<th style="width:50px;">두께</th>
					<th style="width:50px;">호칭경</th>
					<th style="width:50px;">길이</th>
					<th style="width:50px;">수량</th>
					<th style="width:50px;">승인수량</th>
					<th style="width:80px;">주문상태</th>
					<th style="width:80px;">납기예정</th>
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
					<td><%=arrList(FI_SoQTY,iLoop)%></td>
					<td><%=arrList(FI_STATUS,iLoop)%></td>
					<td>
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
					<td colspan="9">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>

			<div style="text-align:right;margin-bottom:10px;">
				<button class="btn_bg" type="button" style="width:80px;float:left;margin:0px;" onclick="location.href='page5.asp?<%=PageParams%>'">목록보기</button>
				<button class="btn_bg" style="width:80px;float:right;margin:0px;" onclick="printGo()">프린트</button>
			</div>



		</div>
	</div>


</div>
<SCRIPT type="text/javascript">
var rptWin;
var tid;

function printGo(){
	rptWin = window.open('','printPop','scrollbars=no,toolbar=no,resizable=no,width=100,height=100,left=0,top=0');
	mForm.target = 'printPop';
	mForm.submit();

	tid=setInterval(chkChild,300);
}

function chkChild() {
	if(rptWin.document.readyState=="complete"){
		clearInterval(tid);
		rptWin.print();
		rptWin.close();
	}
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->