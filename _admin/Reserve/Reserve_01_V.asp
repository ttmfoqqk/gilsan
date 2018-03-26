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
		DataMsg = DataMsg &  "<idx><![CDATA["         & Trim( FI_Idx )    & "]]></idx>"
		DataMsg = DataMsg &  "<Other1><![CDATA["      & Trim( FI_Other1 )   & "]]></Other1>"
		DataMsg = DataMsg &  "<Other2><![CDATA["      & Trim( FI_Other2 ) & "]]></Other2>"
		DataMsg = DataMsg &  "<UserIdx><![CDATA["     & Trim( FI_UserIdx )   & "]]></UserIdx>"
		DataMsg = DataMsg &  "<UserId><![CDATA["      & Trim( FI_UserId )   & "]]></UserId>"
		DataMsg = DataMsg &  "<UserName><![CDATA["    & Trim( FI_UserName ) & "]]></UserName>"
		DataMsg = DataMsg &  "<UserJumin><![CDATA["   & Trim( Left(FI_UserJumin,6) ) & "-*******]]></UserJumin>"
		DataMsg = DataMsg &  "<UserPhone1><![CDATA["  & Trim( FI_UserPhone1 ) & "]]></UserPhone1>"
		DataMsg = DataMsg &  "<UserPhone2><![CDATA["  & Trim( FI_UserPhone2 ) & "]]></UserPhone2>"
		DataMsg = DataMsg &  "<UserPhone3><![CDATA["  & Trim( FI_UserPhone3 ) & "]]></UserPhone3>"
		DataMsg = DataMsg &  "<UserHPhone0><![CDATA[" & Trim( FI_UserHPhone0 ) & "]]></UserHPhone0>"
		DataMsg = DataMsg &  "<UserHPhone1><![CDATA[" & Trim( FI_UserHPhone1 ) & "]]></UserHPhone1>"
		DataMsg = DataMsg &  "<UserHPhone2><![CDATA[" & Trim( FI_UserHPhone2 ) & "]]></UserHPhone2>"
		DataMsg = DataMsg &  "<UserHPhone3><![CDATA[" & Trim( FI_UserHPhone3 ) & "]]></UserHPhone3>"
		DataMsg = DataMsg &  "<UserEmail><![CDATA["   & Trim( FI_UserEmail ) & "]]></UserEmail>"
		DataMsg = DataMsg &  "<UserZipcode><![CDATA[" & Trim( Left(FI_UserZipcode,3)&"-"&Right(FI_UserZipcode,3) ) & "]]></UserZipcode>"
		DataMsg = DataMsg &  "<UserAddr1><![CDATA["   & Trim( FI_UserAddr1 ) & "]]></UserAddr1>"
		DataMsg = DataMsg &  "<UserAddr2><![CDATA["   & Trim( FI_UserAddr2 ) & "]]></UserAddr2>"
		DataMsg = DataMsg &  "<UserIndate><![CDATA["  & Trim( FI_UserIndate ) & "]]></UserIndate>"
		DataMsg = DataMsg &  "<UserOutdate><![CDATA[" & Trim( FI_UserOutdate ) & "]]></UserOutdate>"
		DataMsg = DataMsg &  "<UserDelFg><![CDATA["   & Trim( IIF(FI_UserDelFg="0","사용중","탈퇴") ) & "]]></UserDelFg>"
		DataMsg = DataMsg &  "<UserEmailFg><![CDATA[" & Trim( FI_UserEmailFg ) & "]]></UserEmailFg>"
		DataMsg = DataMsg &  "<UserBigo><![CDATA["    & Trim( FI_UserBigo ) & "]]></UserBigo>"
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
		.CommandText      = "KETI_IOT_RESERVE_V"
		.Parameters("@Idx").value  = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>