<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<%
Dim actType : actType = request("actType")
Dim search  : search  = request("search")
Dim id      : id      = request("id")

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

response.write FI_check

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_check"
		.Parameters("@actType").value = actType
		.Parameters("@search").value  = search
		.Parameters("@id").value      = id
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>