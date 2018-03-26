<!-- #include file = "../inc/header_utf8.asp" -->
<%
Dim actType  : actType  = Request.Form("actType")
Dim Idx      : Idx      = IIF( Request.Form("Idx")="" , "0" , Request.Form("Idx") )
Dim BoardKey : BoardKey = IIF( Request.Form("BoardKey")="" , "0" , Request.Form("BoardKey") )
Dim contIdx  : contIdx  = IIF( Request.Form("contIdx")="" , "0" , Request.Form("contIdx") )
Dim admin    : admin    = Session("Admin_Idx")
Dim id       : id       = Session("Admin_Name")
Dim comment  : comment  = Trim( TagEncode(Request.Form("comment")) )

If id = "" Then
	Response.write "session"
	Response.End
End If

If BoardKey = "" Or contIdx = "" Or actType = "" Then
	Response.write "noparam"
	Response.End
End If

If (actType = "INSERT" Or actType = "UPDATE") And Trim(comment) = "" Then
	Response.write "nodata"
	Response.End
End If

Call Expires()
Call dbopen()
	Call proc()
Call dbclose()

Response.write "ok"
Response.End


Sub proc()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection	= objConn
		.prepared				= true
		.CommandType		= adCmdStoredProc
		.CommandText		= "M_BOARD_COMMENT_PROC"
		.Parameters("@actType").value  = actType
		.Parameters("@Idx").value      = Idx
		.Parameters("@key").value      = BoardKey
		.Parameters("@contIdx").value  = contIdx
		.Parameters("@id").value       = id
		.Parameters("@contants").value  = comment
		.Parameters("@ip").value       = g_uip
		.Parameters("@admin").value    = admin
		.Execute
	End with
	set objCmd = nothing
End Sub
%>