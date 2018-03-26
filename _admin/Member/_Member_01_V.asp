<?xml version="1.0" encoding="euc-kr" ?>
<!-- #include file = "../inc/header.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"
Dim UserIdx : UserIdx = IIF(Request.Form("user_idx")="",0,Request.Form("user_idx"))

If Session("Admin_Idx") <> "" Then
	Call Expires()
	Call dbopen()
		Call getView()
		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		DataMsg = DataMsg &  "<item>"		
		DataMsg = DataMsg &  "<UserIdx><![CDATA["         & Trim( FI_UserIdx )             & "]]></UserIdx>"
		DataMsg = DataMsg &  "<UserId><![CDATA["          & Trim( FI_UserId )              & "]]></UserId>"
		DataMsg = DataMsg &  "<UserName><![CDATA["        & Trim( FI_UserName )            & "]]></UserName>"
		DataMsg = DataMsg &  "<UserHPhone0><![CDATA["     & Trim( FI_UserHPhone0 )         & "]]></UserHPhone0>"
		DataMsg = DataMsg &  "<UserHPhone1><![CDATA["     & Trim( FI_UserHPhone1 )         & "]]></UserHPhone1>"
		DataMsg = DataMsg &  "<UserHPhone2><![CDATA["     & Trim( FI_UserHPhone2 )         & "]]></UserHPhone2>"
		DataMsg = DataMsg &  "<UserHPhone3><![CDATA["     & Trim( FI_UserHPhone3 )         & "]]></UserHPhone3>"
		DataMsg = DataMsg &  "<UserEmail1><![CDATA["      & Trim( Split(FI_UserEmail,"@")(0) ) & "]]></UserEmail1>"
		DataMsg = DataMsg &  "<UserEmail2><![CDATA["      & Trim( Split(FI_UserEmail,"@")(1) ) & "]]></UserEmail2>"
		DataMsg = DataMsg &  "<UserZipcode1><![CDATA["    & Trim( Left(FI_UserZipcode,3) )    & "]]></UserZipcode1>"
		DataMsg = DataMsg &  "<UserZipcode2><![CDATA["    & Trim( Right(FI_UserZipcode,3) )   & "]]></UserZipcode2>"
		DataMsg = DataMsg &  "<UserAddr1><![CDATA["       & Trim( FI_UserAddr1 )              & "]]></UserAddr1>"
		DataMsg = DataMsg &  "<UserAddr2><![CDATA["       & Trim( FI_UserAddr2 )              & "]]></UserAddr2>"
		DataMsg = DataMsg &  "<UserIndate><![CDATA["      & Trim( FI_UserIndate )          & "]]></UserIndate>"
		DataMsg = DataMsg &  "<UserIndate_full><![CDATA[" & Trim( FI_UserIndate_full )     & "]]></UserIndate_full>"
		DataMsg = DataMsg &  "<UserOutdate><![CDATA["     & Trim( FI_UserOutdate )         & "]]></UserOutdate>"
		DataMsg = DataMsg &  "<UserDelFg><![CDATA["       & Trim( FI_UserDelFg )           & "]]></UserDelFg>"
		DataMsg = DataMsg &  "<UserEmailFg><![CDATA["     & Trim( FI_UserEmailFg )         & "]]></UserEmailFg>"
		DataMsg = DataMsg &  "<UserBigo><![CDATA["        & TagDecode(Trim( FI_UserBigo )) & "]]></UserBigo>"
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
		.CommandText      = "KETI_USER_MEMBER_L"
		.Parameters("@UserIdx").value  = UserIdx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>