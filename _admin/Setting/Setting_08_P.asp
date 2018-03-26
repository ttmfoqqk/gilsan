<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim alertMsg  : alertMsg  = ""
Dim actType   : actType   = Trim( Request.Form("actType") )
Dim pageNo    : pageNo    = Request.Form("pageNo")
Dim idx       : idx       = Request.Form("idx")
Dim check_idx : check_idx = Request.Form("check_idx")
Dim ord       : ord       = IIF( Request.Form("ord")="",0,Request.Form("ord") )
Dim data_y    : data_y    = Trim( Request.Form("data_y") )
Dim data_m    : data_m    = Trim( Request.Form("data_m") )
Dim data_d    : data_d    = Trim( Request.Form("data_d") )
Dim usfg      : usfg      = IIF( Request.Form("usfg")="",0,Request.Form("usfg") )
Dim bigo      : bigo      = Trim( TagEncode(Request.Form("bigo")) )

idx = IIF( idx="",check_idx,idx )

Call Expires()
Call dbopen()
	If actType = "INSERT" Then 
		Call Insert()
		If FI_CNT > 0 Then 
			alertMsg = "중복된 일자는 사용하실수 없습니다."
		Else
			alertMsg = "입력되었습니다."
		End If
	ElseIf actType = "UPDATE" Then 
		Call Insert()
		If FI_CNT > 0 Then 
			alertMsg = "중복된 일자는 사용하실수 없습니다."
		Else
			alertMsg = "수정되었습니다."
		End If		
	ElseIf actType = "DELETE" Then 
		Call Insert()
		alertMsg = "삭제되었습니다."
	Else
		alertMsg = "[actType] 이 없습니다."
	End If	
Call dbclose()

Sub Insert()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_SETTTING_NODATE_P"
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = Idx
		.Parameters("@Ord").value       = Ord
		.Parameters("@Name").value      = data_y &"-"& data_m &"-"& data_d
		.Parameters("@Usfg").value      = Usfg
		.Parameters("@Bigo").value      = Bigo
		.Parameters("@AdminIdx").value = Session("Admin_Idx")
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
 </head>

 <body>
  <script type="text/javascript">
  if("<%=alertMsg%>")alert("<%=alertMsg%>");
  location.href="Setting_04_L.asp?pageNo=<%=pageNo%>"
  </script>
 </body>
</html>