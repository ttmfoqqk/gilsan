<%
'------------------------------------------------------------------------------------
' Admin �޴�����
'------------------------------------------------------------------------------------
Dim AdminLeftName,AdminTopmode

If INSTR(LCase(g_url),"/admin/")>0 Then
	AdminLeftName = "Ȩ����������"
	AdminTopmode  = 1
elseIf INSTR(LCase(g_url),"/info/")>0 Then 
	AdminLeftName = "�����Ȳ����"
	AdminTopmode  = 2
elseIf INSTR(LCase(g_url),"/staff/")>0 Then 
	AdminLeftName = "�����������"
	AdminTopmode  = 3
elseIf INSTR(LCase(g_url),"/member/")>0 Then 
	AdminLeftName = "ȸ������"
	AdminTopmode  = 4
elseIf INSTR(LCase(g_url),"/customer/")>0 Then 
	AdminLeftName = "�Խ��ǰ���"
	AdminTopmode  = 5
End If
'------------------------------------------------------------------------------------
'' ������ �α��� üũ.
'------------------------------------------------------------------------------------
Function checkAdminLogin(url)
	If session("Admin_Id")="" or IsNull(session("Admin_Id"))=True Then 
		response.redirect "../index.asp?GoUrl=" & server.urlencode(url)
	End If
End Function

'�����ڵ� �迭��ȯ 
Function fc_code_list(idx)
	Call Expires()
	Call dbopen()

	Dim arrList
	Dim tmp_txt
	Dim cntList  : cntList  = -1

	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_COMM_CODE2_P"
		.Parameters("@actType").value = "VIEW"
		.Parameters("@PIdx").value    = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing

	For iLoop = 0 To cntList
		tmp_txt = tmp_txt & arrList(FI_Idx,iLoop) & "|_KEY_|" & TagDecode( arrList(FI_Name,iLoop) )
		If iLoop < cntList Then 
			tmp_txt = tmp_txt &  "|_ARRY_|"
		End If
	Next
	Call dbclose()
	fc_code_list = tmp_txt
End Function
%>