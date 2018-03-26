<!-- #include file="../inc/top.asp" -->
<%
checkLogin( g_host & g_url )

Dim arrList  , arrListOption
Dim cntListOption  : cntListOption  = -1
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim indate   : indate   = request("indate")
Dim outdate  : outdate  = request("outdate")
Dim cocode   : cocode   = request("cocode")

Call Expires()
Call dbopen()
	Call GetList()
	Call GetListOption()
Call dbclose()

Dim pageURL , PageParams

pageURL    = g_url & "?pageNo=__PAGE__&indate=" & indate & "&outdate=" & outdate & "&cocode=" & cocode
PageParams = "pageNo=" & pageNo & "&indate=" & indate & "&outdate=" & outdate & "&cocode=" & cocode


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
		.Parameters("@cocode").value = cocode
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

Sub GetListOption()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_L"
		.Parameters("@actType").value = "company"
		.Parameters("@ID").value      = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI2")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrListOption = objRs.GetRows()
		cntListOption = UBound(arrListOption, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">온라인주문</span><span class="block2">나의 주문현황</span>
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
						<select name="cocode" id="cocode" style="vertical-align:middle;height:32px;">
							<option value="">계열사 선택</option>
							<%for iLoop = 0 to cntListOption%>
							<option value="<%=arrListOption(FI2_code,iLoop)%>" <%=IIF( cocode=arrListOption(FI2_code,iLoop),"selected","" )%>><%=arrListOption(FI2_name,iLoop)%></option>
							<%Next%>
						</select>
						&nbsp;
						<label style="margin-right:10px;font-size:14px;">주문일자 </label>
						<input type="text" id="indate" name="indate" class="input" style="width:75px;padding:0px;" onclick="callCalendar(form_more_pop.indate);" readonly maxlength="10" value="<%=indate%>">
						<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.indate);" style="vertical-align:top;height:30px;cursor:pointer;">
						~
						<input type="text" id="outdate" name="outdate" class="input" style="width:75px;padding:0px;" onclick="callCalendar(form_more_pop.outdate);" readonly maxlength="10" value="<%=outdate%>">
						<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.outdate);" style="vertical-align:top;height:30px;cursor:pointer;">

						<button type="submit" class="btn" style="height:30px;width:50px;">검색</button>
						<!--button type="button" class="btn" onclick="$('#indate').val('');$('#outdate').val('');" style="height:30px;width:50px;">초기화</button-->
					</div>
					</form>
				</div>
			</div>
			
			<form name="mForm" id="mForm" method="POST" action="../m4/orderPrint.asp">
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:40px;"><input type="checkbox" name="selectAll" id="selectAll" /></th>
					
					<th style="width:70px;">품목구분</th>
					<th>품명</th>
					<th style="width:40px;">두께</th>
					<th style="width:40px;">호칭경</th>
					<th style="width:50px;">길이</th>
					<th style="width:50px;">수량</th>
					<th style="width:70px;">주문상태</th>
					<th style="width:55px;">승인수량</th>
					<th style="width:70px;">납기예정</th>
					<th style="width:80px;">주문일자</th>
				</tr>
				<%for iLoop = 0 to cntList
					onclick = "location.href='page2_view.asp?" & PageParams & "&orderCode=" & arrList(FI_ODNO,iLoop) & "'"

					ex_text = ""
					If arrList(FI_SUB_CNT,iLoop) > 1 Then 
						ex_text = "외" & arrList(FI_SUB_CNT,iLoop) -1 & "건"
					End If
				%>
				<tr>
					<td style="cursor:auto;"><input type="checkbox" name="ODNO" value="<%=arrList(FI_ODNO,iLoop)%>"/></td>
					
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
					<td onclick="<%=onclick%>"><%=Left(arrList(FI_INDATETIME,iLoop),10)%></td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then%>
				<tr">
					<td colspan="11">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>
			</form>

			<div style="text-align:right;">
				<button class="btn_bg" style="width:80px;" onclick="printGo()">프린트</button>
			</div>
			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>
			

		</div>
	</div>


</div>
<SCRIPT type="text/javascript">
$('#selectAll').click (function () {
	var checkedStatus = this.checked;
	$('input[name="ODNO"]').each(function () {
		$(this).prop('checked', checkedStatus);
	});
});

var rptWin;
var tid;

function printGo(){
	if($('input[name="ODNO"]:checked').length <=0 ){
		alert('주문현황을 선택해주세요.');return false;
	}

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