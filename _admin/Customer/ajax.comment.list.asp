<!-- #include file = "../inc/header_utf8.asp" -->
<%
Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = CInt(IIF(request("rows")="","10",request("rows")))
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim boardKey : boardKey = request("boardKey")
Dim contIdx  : contIdx  = request("contIdx")

Dim pageURL  : pageURL  = "javascript:getComentList(__PAGE__);"

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
		.CommandText      = "M_BOARD_COMMENT_L"
		.Parameters("@rows").value    = rows 
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@key").value     = boardKey
		.Parameters("@contIdx").value = contIdx
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
	btnFg = 1
	If arrList(FI_admin, iLoop) = "0" Then
		btnFg = 0
	End If
	temp = temp & "<item>"
	temp = temp & "	<idx><![CDATA["     & arrList(FI_idx, iLoop)       & "]]></idx>"
	temp = temp & "	<rownum><![CDATA["  & arrList(FI_rownum, iLoop)    & "]]></rownum>"
	temp = temp & "	<key><![CDATA["     & arrList(FI_key, iLoop)       & "]]></key>"
	temp = temp & "	<contIdx><![CDATA[" & arrList(FI_contIdx, iLoop)   & "]]></contIdx>"
	temp = temp & "	<id><![CDATA["      & arrList(FI_id, iLoop)        & "]]></id>"
	temp = temp & "	<contants><![CDATA["& arrList(FI_contants, iLoop)  & "]]></contants>"

	temp = temp & "	<ip><![CDATA["      & arrList(FI_ip, iLoop)        & "]]></ip>"
	temp = temp & "	<inDate><![CDATA["  & arrList(FI_inDate, iLoop)    & "]]></inDate>"
	temp = temp & "	<admin><![CDATA["   & arrList(FI_admin, iLoop)     & "]]></admin>"
	temp = temp & "	<btnFg><![CDATA["   & btnFg                        & "]]></btnFg>"
	temp = temp & "</item>"
Next

response.ContentType = "text/xml"
Response.write xmlStart & cnt & page & temp & xmlEnd
Set objDom = Nothing
%>