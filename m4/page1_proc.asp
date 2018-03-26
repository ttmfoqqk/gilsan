<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Response.redirect "page1_1.asp"

checkLogin( g_host & "/m4/page1.asp" )

Dim orderCode   : orderCode   = Request.Form("orderCode")
Dim companyCode : companyCode = Request.Form("companyCode")
Dim itemCode    : itemCode    = Request.Form("itemCode")
Dim productCode : productCode = Request.Form("productCode")
Dim thickCode   : thickCode   = Request.Form("thickCode")
Dim widthCode   : widthCode   = Request.Form("widthCode")
Dim length      : length      = Request.Form("length")
Dim qty         : qty         = Request.Form("qty")
Dim duedate     : duedate     = Request.Form("duedate")
Dim unloadplace : unloadplace = Request.Form("unloadplace")
Dim remark      : remark      = Request.Form("remark")

Dim steelCode   : steelCode   = Split( productCode,"-" )(0)
Dim surfaceCode : surfaceCode = Split( productCode,"-" )(2)
Dim shapeCode   : shapeCode   = Split( productCode,"-" )(1)

If companyCode = "" Or itemCode = "" Or productCode = "" Or thickCode = "" Or widthCode = "" Or length = "" Or qty = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 항목이 있습니다.');"
	 .Write "history.back(-1);"
	 '.Write "document.location.href='page1.asp';"
	 .Write "</script>"
	 .End
	End With
End If

If orderCode = "" And duedate = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 항목이 있습니다.');"
	 .Write "history.back(-1);"
	 '.Write "document.location.href='page1.asp';"
	 .Write "</script>"
	 .End
	End With
End If

If IsNumeric(length) = False Or IsNumeric(qty) = False Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('길이,수량은 숫자로만 입력해주세요.');"
	 .Write "history.back(-1);"
	 '.Write "document.location.href='page1.asp';"
	 .Write "</script>"
	 .End
	End With
End If


Call Expires()
Call dbopen()
	Call insert()
Call dbclose()

Sub insert()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_INSERT"
		.Parameters("@ODNO").value        = orderCode
		.Parameters("@ID").value          = session("userId")
		.Parameters("@COCODE").value      = companyCode
		.Parameters("@TYPECODE").value    = itemCode
		.Parameters("@STEELCODE").value   = steelCode
		.Parameters("@SURFACE").value     = surfaceCode
		.Parameters("@EXTDIA").value      = widthCode
		.Parameters("@THICK").value       = thickCode
		.Parameters("@QTY").value         = qty
		.Parameters("@INDATETIME").value  = FormatDateTime(Now(), 2)&","&FormatDateTime(Now(), 4)
		.Parameters("@HOSTNAME").value    = Request.ServerVariables("REMOTE_HOST")
		.Parameters("@IP").value          = Request.ServerVariables("REMOTE_ADDR")
		.Parameters("@LENGTH").value      = length
		.Parameters("@shape").value       = shapeCode
		.Parameters("@DUEDATE").value     = Replace(duedate,"-","")
		.Parameters("@UNLOADPLACE").value = unloadplace
		.Parameters("@REMARK").value      = remark
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 길산파이프(주) </title>
<meta name="Generator" content="EditPlus">
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>

<form name="mForm" method="post" action="page1.asp">
	<input type="hidden" name="orderCode" value="<%=FI_ODNO%>">
	<input type="hidden" name="companyCode" value="<%=companyCode%>">
</form>
<SCRIPT type="text/javascript">
	alert('주문접수 되었습니다.');
	document.mForm.submit();
</SCRIPT>

</body>
</html>