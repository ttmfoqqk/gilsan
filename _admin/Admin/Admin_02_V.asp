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
		DataMsg = DataMsg &  "<admin_idx><![CDATA["     & Trim( FI_Idx )                   & "]]></admin_idx>"
		DataMsg = DataMsg &  "<admin_id><![CDATA["      & Trim( FI_Id )                    & "]]></admin_id>"
		DataMsg = DataMsg &  "<admin_pwd><![CDATA["     & Trim( FI_Pwd )                    & "]]></admin_pwd>"
		DataMsg = DataMsg &  "<admin_name><![CDATA["    & Trim( FI_Name )                   & "]]></admin_name>"
		DataMsg = DataMsg &  "<admin_phone1><![CDATA["  & Trim( FI_pHone1 )                & "]]></admin_phone1>"
		DataMsg = DataMsg &  "<admin_phone2><![CDATA["  & Trim( FI_pHone2 )                & "]]></admin_phone2>"
		DataMsg = DataMsg &  "<admin_phone3><![CDATA["  & Trim( FI_pHone3 )                & "]]></admin_phone3>"
		DataMsg = DataMsg &  "<admin_hphone1><![CDATA[" & Trim( FI_Hphone1 )               & "]]></admin_hphone1>"
		DataMsg = DataMsg &  "<admin_hphone2><![CDATA[" & Trim( FI_Hphone2 )               & "]]></admin_hphone2>"
		DataMsg = DataMsg &  "<admin_hphone3><![CDATA[" & Trim( FI_Hphone3 )               & "]]></admin_hphone3>"
		DataMsg = DataMsg &  "<admin_ext><![CDATA["     & Trim( FI_ExtNum )                & "]]></admin_ext>"
		DataMsg = DataMsg &  "<admin_dir><![CDATA["     & Trim( FI_DirNum )                & "]]></admin_dir>"
		DataMsg = DataMsg &  "<admin_mail1><![CDATA["   & Trim( Split(FI_email,"@")(0) )   & "]]></admin_mail1>"
		DataMsg = DataMsg &  "<admin_mail2><![CDATA["   & Trim( Split(FI_email,"@")(1) )   & "]]></admin_mail2>"
		DataMsg = DataMsg &  "<admin_msg1><![CDATA["    & Trim( Split(FI_MsgAddr,"@")(0) ) & "]]></admin_msg1>"
		DataMsg = DataMsg &  "<admin_msg2><![CDATA["    & Trim( Split(FI_MsgAddr,"@")(1) ) & "]]></admin_msg2>"
		DataMsg = DataMsg &  "<admin_bigo><![CDATA["    & TagDecode(Trim( FI_Bigo ))       & "]]></admin_bigo>"
		DataMsg = DataMsg &  "<admin_indata><![CDATA["  & Trim( FI_Indata )                & "]]></admin_indata>"
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
		.CommandText      = "M_ADMIN_MEMBER_V"
		.Parameters("@Idx").value  = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>