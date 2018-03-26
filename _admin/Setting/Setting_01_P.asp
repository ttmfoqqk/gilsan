<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim alertMsg  : alertMsg  = ""
Dim actType   : actType   = Trim( Request.Form("actType") )
Dim pageNo    : pageNo    = Request.Form("pageNo")
Dim idx       : idx       = Request.Form("idx")
Dim check_idx : check_idx = Request.Form("check_idx")
Dim ord       : ord       = IIF( Request.Form("ord")="",0,Request.Form("ord") )
Dim name_t    : name_t    = Trim( Request.Form("name_t") )
Dim name_m    : name_m    = Trim( Request.Form("name_m") )
Dim usfg      : usfg      = IIF( Request.Form("usfg")="",0,Request.Form("usfg") )
Dim bigo      : bigo      = Trim( TagEncode(Request.Form("bigo")) )

idx = IIF( idx="",check_idx,idx )

Call Expires()
Call dbopen()
	If actType = "INSERT" Then 
		Call Insert()
		If FI_CNT > 0 Then 
			alertMsg = "중복된 시간은 사용하실수 없습니다."
		Else
			alertMsg = "입력되었습니다."
		End If
	ElseIf actType = "UPDATE" Then 
		Call Insert()
		If FI_CNT > 0 Then 
			alertMsg = "중복된 시간은 사용하실수 없습니다."
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
		.CommandText      = "KETI_SETTTING_TIME_P"
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = Idx
		.Parameters("@Ord").value       = Ord
		.Parameters("@Name").value      = name_t & ":" & name_m
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
  location.href="Setting_01_L.asp?pageNo=<%=pageNo%>"
  </script>
 </body>
</html>