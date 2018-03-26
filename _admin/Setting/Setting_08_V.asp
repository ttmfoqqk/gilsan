<?xml version="1.0" encoding="euc-kr" ?>
<!-- #include file = "../inc/header.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"
Dim Idx : Idx = Trim( Request("Idx") )

If Session("Admin_Idx") <> "" Then
	Call Expires()
	Call dbopen()
		Call getView()
		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		DataMsg = DataMsg &  "<item>"		
		DataMsg = DataMsg &  "<idx><![CDATA["    & Trim( FI_Idx )    & "]]></idx>"
		DataMsg = DataMsg &  "<ord><![CDATA["    & Trim( FI_Ord )    & "]]></ord>"
		DataMsg = DataMsg &  "<name><![CDATA["   & Trim( FI_Name )   & "]]></name>"
		DataMsg = DataMsg &  "<usfg><![CDATA["   & Trim( FI_Usfg )   & "]]></usfg>"
		DataMsg = DataMsg &  "<bigo><![CDATA["   & TagDecode( Trim( FI_Bigo ) )   & "]]></bigo>"
		DataMsg = DataMsg &  "<indate><![CDATA[" & Trim( FI_Indate ) & "]]></indate>"
		DataMsg = DataMsg &  "</item>"
		DataMsg = DataMsg &  "</data>"
	Call dbclose()
End If

Response.write DataMsg

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_SETTTING_NODATE_L"
		.Parameters("@Idx").value  = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>