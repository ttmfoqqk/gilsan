<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim pageURL  : pageURL  = "javascript:getMyOrder(""favorites"",__PAGE__);"

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
		.CommandText      = "M_FAVORITES_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@ID").value     = session("userId")
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

Dim temp

Dim xmlStart : xmlStart = "<?xml version=""1.0"" encoding=""UTF-8""?><rss version=""2.0""><channel>"
Dim xmlEnd   : xmlEnd   = "</channel></rss>"
Dim cnt      : cnt      = "<cnt>"& (cntList+1) &"</cnt>"
Dim page     : page     = "<page><![CDATA["& printPageList(cntTotal, pageNo, rows, pageURL) &"]]></page>"
For iLoop = 0 To cntList
	temp = temp & "<item>"
	temp = temp & "	<idx><![CDATA["         & arrList(FI_idx, iLoop)          & "]]></idx>"
	temp = temp & "	<rownum><![CDATA["      & arrList(FI_rownum, iLoop)       & "]]></rownum>"
	temp = temp & "	<id><![CDATA["          & arrList(FI_ID, iLoop)           & "]]></id>"
	temp = temp & "	<typename><![CDATA["    & arrList(FI_typename, iLoop)     & "]]></typename>"
	temp = temp & "	<product><![CDATA["     & arrList(FI_PRODUCT_NAME, iLoop) & "]]></product>"
	temp = temp & "	<thick><![CDATA["       & arrList(FI_THICK, iLoop)        & "]]></thick>"
	temp = temp & "	<extdia><![CDATA["      & arrList(FI_EXTDIA, iLoop)       & "]]></extdia>"
	temp = temp & "	<length><![CDATA["      & arrList(FI_LENGTH, iLoop)       & "]]></length>"
	temp = temp & "	<qty><![CDATA["         & arrList(FI_QTY, iLoop)          & "]]></qty>"
	temp = temp & "	<status><![CDATA["      & arrList(FI_STATUS, iLoop)       & "]]></status>"
	temp = temp & "	<indatetime><![CDATA["  & Left(arrList(FI_indate, iLoop),10)   & "]]></indatetime>"

	temp = temp & "	<companyCode><![CDATA[" & arrList(FI_COCODE, iLoop)       & "]]></companyCode>"
	temp = temp & "	<typeCode><![CDATA["    & arrList(FI_TYPECODE, iLoop)     & "]]></typeCode>"
	temp = temp & "	<productCode><![CDATA[" & arrList(FI_PRODUCT_CODE, iLoop) & "]]></productCode>"

	temp = temp & "</item>"
Next

response.ContentType = "text/xml"
Response.write xmlStart & cnt & page & temp & xmlEnd
Set objDom = Nothing
%>