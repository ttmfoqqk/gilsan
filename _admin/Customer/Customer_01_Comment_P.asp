<?xml version="1.0" encoding="utf-8"?>
<!-- #include file = "../inc/header_utf8.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"
Dim actType  : actType  = Trim( IIF( Request.Form("actType")="ANS" , "INSERT" , Request.Form("actType") ) )
Dim Idx      : Idx      = IIF( Request.Form("Idx")="",0,Request.Form("Idx") )
Dim BoardKey : BoardKey = IIF( Request.Form("BoardKey")="",0,Request.Form("BoardKey") )
Dim ContIdx  : ContIdx  = IIF( Request.Form("ContIdx")="",0,Request.Form("ContIdx") )
Dim UserIdx  : UserIdx  = IIF( Request.Form("UserIdx")="",0,Request.Form("UserIdx") )
Dim Contants : Contants = TagEncode( Trim( Request.Form("Contants") ) )
Dim AdminIdx : AdminIdx = Session("Admin_Idx")
Dim Ip       : Ip       = g_uip

Contants = Replace( Contants , vbLf , "<br>" )

If AdminIdx <> "" Then
	Call Expires()
	Call dbopen()
		Call Insert()

		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		DataMsg = DataMsg &  "<item>"
		DataMsg = DataMsg &  "<cont_Idx><![CDATA["      & Trim( FI_Idx )      & "]]></cont_Idx>"
		DataMsg = DataMsg &  "<cont_Contants><![CDATA[" & Trim( FI_Contants ) & "]]></cont_Contants>"
		DataMsg = DataMsg &  "<cont_ContId><![CDATA["   & Trim( FI_ContId )   & "]]></cont_ContId>"
		DataMsg = DataMsg &  "<cont_ContName><![CDATA[" & Trim( FI_ContName ) & "]]></cont_ContName>"
		DataMsg = DataMsg &  "<cont_UserIdx><![CDATA[" & Trim( FI_UserIdx ) & "]]></cont_UserIdx>"
		DataMsg = DataMsg &  "<cont_Depth><![CDATA["    & Trim( FI_Depth_no ) & "]]></cont_Depth>"
		DataMsg = DataMsg &  "<cont_Ord><![CDATA["    & Trim( FI_Ord_no ) & "]]></cont_Ord>"
		DataMsg = DataMsg &  "<cont_Indate><![CDATA["    & Trim( FI_Indate ) & "]]></cont_Indate>"
		DataMsg = DataMsg &  "</item>"
		DataMsg = DataMsg &  "</data>"
	Call dbclose()
End If

If actType = "" Then 
	DataMsg = "error"
End If

Response.write DataMsg

Sub Insert()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_BOARD_COMMENT_P"
		.Parameters("@actType").value  = actType
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = BoardKey
		.Parameters("@ContIdx").value  = ContIdx
		.Parameters("@UserIdx").value  = UserIdx
		.Parameters("@Contants").value = Contants
		.Parameters("@Ip").value       = Ip
		.Parameters("@AdminIdx").value = AdminIdx
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>