<!-- #include file = "../inc/header.asp" -->
<%
Dim ridx  : ridx  = request("ridx")
Dim aidx  : aidx  = request("aidx")
Dim sDate : sDate = request("sDate")
Dim sEate : sEate = request("sEate")

Call Expires()
Call dbopen()
	Call getView()
Call dbclose()

Response.write FI_CNT

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_IOT_NEW_RESERVE_CHECK"
		.Parameters("@rIdx").value   = rIdx
		.Parameters("@aIdx").value   = aIdx
		.Parameters("@cSdate").value = cSdate
		.Parameters("@cEdate").value = cEdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>