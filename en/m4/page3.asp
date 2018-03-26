<!-- #include file="../inc/top.asp" -->
<%
Session.Timeout = 1440
Server.ScriptTimeOut = 60*60*24 '초

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim cocode   : cocode   = request("cocode")
Dim itemname : itemname = request("itemname")
Dim extdia   : extdia   = request("extdia")
Dim thick    : thick    = request("thick")

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL , PageParams

pageURL    = g_url & "?pageNo=__PAGE__" & "&cocode=" & cocode & "&itemname=" & itemname & "&extdia=" & extdia & "&thick=" & thick
PageParams = "pageNo=" & pageNo & "&cocode=" & cocode & "&itemname=" & itemname & "&extdia=" & extdia & "&thick=" & thick


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandTimeOut   = 0
		.CommandText      = "M_STOCK_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@cocode").value   = cocode
		.Parameters("@itemname").value = itemname
		.Parameters("@extdia").value   = extdia
		.Parameters("@thick").value    = thick
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
			<span class="home">H</span><span class="block1">온라인주문</span><span class="block2">재고조회</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<div style="position:relative;">
				<h3 class="title">재고조회</h3>
			</div>
			
			<form name="form_more_pop" id="form_more_pop" method="GET">
			<table cellpadding="0" cellspacing="0" style="width:100%;font-size:14px;">
				<tr>
					<td style="width:10%;">판매처</td>
					<td style="width:40%;">
						<select class="input" name="cocode" style="width:270px;">
							<option value="">전체</option>
							<option value="10" <%=IIF( cocode="10" ,"selected", "" )%>>길산파이프</option>
							<option value="20" <%=IIF( cocode="20" ,"selected", "" )%>>길산스틸</option>
							<option value="30" <%=IIF( cocode="30" ,"selected", "" )%>>길산ST</option>
							<option value="40" <%=IIF( cocode="40" ,"selected", "" )%>>길산SST</option>
						</select>
					</td>
					<td style="width:10%;">품명</td>
					<td style="width:40%;">
						<input type="text"name="itemname" class="input" maxlength="100" style="width:250px;" value="<%=itemname%>">
					</td>
				</tr>
				<tr><td colspan="4" style="height:10px;"></td></tr>
				<tr>
					<td>두께</td>
					<td>
						<input type="text" name="thick" class="input" maxlength="100" style="width:250px;" value="<%=thick%>">
					</td>
					<td>호칭경</td>
					<td>
						<input type="text" name="extdia" class="input" maxlength="100" style="width:250px;" value="<%=extdia%>">
					</td>
				</tr>
			</table>
			<br>
			<center>
				<button type="submit" class="btn">검색</button>
			</center>
			</form>
			
			<br><br>
			<STYLE type="text/css">
			.reserve_table td{cursor:auto;}
			</STYLE>
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:70px;">번호</th>
					<th>품명</th>
					<th style="width:100px;">두께</th>
					<th style="width:100px;">호칭경</th>
					<th style="width:100px;">길이</th>
					<th style="width:100px;">수량</th>
					<th style="width:100px;">중량</th>
				</tr>
				<%for iLoop = 0 to cntList%>
				<tr>
					<td><%=arrList(FI_rownum,iLoop)%></td>
					<td><%=arrList(FI_itemname,iLoop)%></td>
					<td><%=arrList(FI_thick,iLoop)%></td>
					<td><%=arrList(FI_extdia,iLoop)%></td>
					<td><%=arrList(FI_length,iLoop)%></td>
					<td><%=arrList(FI_qty,iLoop)%></td>
					<td><%=arrList(FI_weight,iLoop)%></td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then%>
				<tr">
					<td colspan="7">등록된 내용이 없습니다.</td>
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