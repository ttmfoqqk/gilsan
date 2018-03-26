<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
checkLoginPOP()

Dim arrList
Dim cntList : cntList = -1
Dim rows    : rows    = 100
Dim ODNO    : ODNO    = Replace(request("ODNO")," ","")

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

If cntList < 0 Or ODNO = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 주문번호 입니다.');"
	 .Write "window.close();"
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
		.Parameters("@ID").value     = session("userId")
		.Parameters("@ODNO").value   = ODNO
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title> 길산파이프(주) </title>
<link rel="stylesheet" type="text/css" href="../inc/css/default.css">
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>

<STYLE type="text/css">
	body{min-width:740px;}
	#contant{width:auto;margin:10px;}
	table.reserve_table td{cursor:auto;}
	div.BreakBefore{page-break-before:always;}
</STYLE>

<body>
<div id="contant">
	<%
	Dim temp_ODNO : temp_ODNO = ""
	for iLoop = 0 to cntList
		If temp_ODNO <> arrList(FI_ODNO,iLoop) Then 
			temp_ODNO = arrList(FI_ODNO,iLoop)
			
			If iLoop > 0 Then 
				Response.write "</table></div>"
			End If
	%>		<div class="<%=IIF(iLoop<=0,"","BreakBefore")%>">
			<div style="font-size:30px;text-align:center;line-height:160%;"><b><%=arrList(FI_CUSTNAME,iLoop)%></b></div>
			<h4 style="margin-top:0px;padding-bottom:20px;">주문내역</h4>
			
			
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:150px;">주문일자</th>
					<td style="text-align:left;"><%=Left(arrList(FI_INDATETIME,iLoop),10)%></td>
				</tr>
				<tr>
					<th style="width:150px;">희망납기일</th>
					<td style="text-align:left;"><%=Left(arrList(FI_DUEDATE,iLoop),4)&"-"&Mid(arrList(FI_DUEDATE,iLoop), 5, 2)&"-"&Right(arrList(FI_DUEDATE,iLoop), 2)%></td>
				</tr>
				<tr>
					<th style="width:150px;">하차장소</th>
					<td style="text-align:left;"><%=arrList(FI_UNLOADPLACE,iLoop)%>&nbsp;</td>
				</tr>
				<tr>
					<th style="width:150px;">기타사항</th>
					<td style="text-align:left;"><%=arrList(FI_REMARK,iLoop)%>&nbsp;</td>
				</tr>
			</table>

			<h4 style="margin-bottom:20px;margin-top:20px;">주문상품</h4>
			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:50px;">번호</th>
					<th style="width:100px;">품목구분</th>
					<th style="width:150px;">품명</th>
					<th style="width:50px;">두께</th>
					<th style="width:50px;">호칭경</th>
					<th style="width:50px;">길이</th>
					<th style="width:50px;">수량</th>
					<th style="width:50px;">승인수량</th>
					<th style="width:80px;">주문상태</th>
					<th style="width:80px;">납기예정</th>
				</tr>
	<%
		iLoop = iLoop -1
		Else
	%>
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
	<%
		End If

	Next
	%>
			</table></div>
</div>
<SCRIPT type="text/javascript">
//window.print();
//self.close();
</SCRIPT>
</body>
</html>