<!-- #include file = "../common/Carset_euckr.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Dim arrList
Dim cntList : cntList = -1

Dim actType      : actType     = request("actType")
Dim companyCode  : companyCode = request("companyCode")
Dim typeCode     : typeCode    = request("typeCode")
Dim productCode  : productCode = IIF(request("productCode")="","--",request("productCode"))


Dim steelCode    : steelCode   = Split( productCode,"-" )(0)
Dim surfaceCode  : surfaceCode = Split( productCode,"-" )(2)
Dim shapeCode    : shapeCode   = Split( productCode,"-" )(1)
Dim thickCode    : thickCode   = request("thickCode")

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
		.CommandText      = "M_PRODUCT_L"
		.Parameters("@actType").value     = actType
		.Parameters("@companyCode").value = companyCode
		.Parameters("@typeCode").value    = typeCode
		.Parameters("@steelCode").value   = steelCode
		.Parameters("@surfaceCode").value = surfaceCode
		.Parameters("@shapeCode").value   = shapeCode
		.Parameters("@thickCode").value   = thickCode
		.Parameters("@ID").value          = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Dim temp

Dim xmlStart : xmlStart = "<?xml version=""1.0"" encoding=""UTF-8""?><rss version=""2.0""><channel>"
Dim xmlEnd   : xmlEnd   = "</channel></rss>"
Dim cnt      : cnt      = "<cnt>"& (cntList+1) &"</cnt>"
For iLoop = 0 To cntList
	temp = temp & "<item>"
	temp = temp & "	<code><![CDATA["& arrList(FI_code, iLoop) &"]]></code>"
	temp = temp & "	<name><![CDATA["& arrList(FI_name, iLoop) &"]]></name>"
	temp = temp & "</item>"
Next

response.ContentType = "text/xml"
Response.write xmlStart & cnt & temp & xmlEnd
Set objDom = Nothing
%>