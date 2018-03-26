<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & "/_admin/Reserve/Reserve_01_L.asp" )

Dim idx       : idx       = Request.Form("idx")
Dim cSdate    : cSdate    = Request.Form("cSdate")
Dim cEdate    : cEdate    = Request.Form("cEdate")
Dim rArea     : rArea     = Request.Form("rArea")
Dim cArea     : cArea     = Request.Form("cArea")
Dim state     : state     = Request.Form("state")
Dim pageParam : pageParam = Request.Form("pageParam")


if Trim(idx) = "" Or Trim(rArea) = "" Or Trim(state) = "" Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 항목이 있습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Call Expires()
Call dbopen()
	Call update()
Call dbclose()

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('저장되었습니다.');"
 .Write "location.href='Reserve_01_L.asp?" & Replace(pageParam,"%3D","=") & "';"
 .Write "</script>"
 .End
End With

Sub update()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_IOT_NEW_RESERVE_UPDATE"
		.Parameters("@idx").value    = idx
		
		If cSdate <> "" Then 
		.Parameters("@cSdate").value = cSdate
		End If
		If cEdate <> "" Then 
		.Parameters("@cEdate").value = cEdate
		End If
		If rArea <> "" Then 
		.Parameters("@rArea").value  = rArea
		End If
		If cArea <> "" Then 
		.Parameters("@cArea").value  = cArea
		End If
		If state <> "" Then 
		.Parameters("@state").value  = state
		End If

		.Execute
	End with
	set objCmd = Nothing
End Sub
%>