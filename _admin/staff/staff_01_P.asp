<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\m3/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 5 * 1024 * 1024 '5메가


Dim alertMsg

Dim actType     : actType      = Trim( UPLOAD__FORM("actType") )
Dim idx         : idx          = IIF( UPLOAD__FORM("idx")="" , "0" , UPLOAD__FORM("idx") )

Dim tap         : tap          = IIF( UPLOAD__FORM("tap")="" , "0" , UPLOAD__FORM("tap") )
Dim position    : position     = UPLOAD__FORM("position")
Dim userName    : userName     = UPLOAD__FORM("userName")
Dim phone1      : phone1       = UPLOAD__FORM("phone1")
Dim phone2      : phone2       = UPLOAD__FORM("phone2")
Dim phone3      : phone3       = UPLOAD__FORM("phone3")
Dim Career      : Career       = Trim( UPLOAD__FORM("Career") )
Dim FileName    : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg  : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )
Dim Order       : Order        = IIF( UPLOAD__FORM("Order")="" , "0" , UPLOAD__FORM("Order") )

Dim PageParams  : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))


Call Expires()
Call dbopen()
	

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 5MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		End If		
		
		Call insert()
		alertMsg = "입력 되었습니다."

	ElseIf (actType = "UPDATE") Then	'글수정
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 5MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If

			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If
		Else
			FileName = oldFileName
		End If

		

		If DellFileFg = "1" Then 
			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If

			FileName = ""
		End If

		

		Call insert()
		alertMsg = "수정 되었습니다."
	ElseIf (actType = "DELETE") Then	'글삭제
		
		'글 삭제시 파일 삭제
		'If FI_FileName <> "" Then
		'	Set FSO = CreateObject("Scripting.FileSystemObject")
		'		If (FSO.FileExists(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)) Then	' 파일삭제
		'			fso.deletefile(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)
		'		End If
		'	set FSO = Nothing
		'End If

		Call insert()
		alertMsg = "삭제 되었습니다."
	else
		alertMsg = "actType[" & actType & "]이 정의되지 않았습니다."
	end If

Call dbclose()

Sub insert()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_STAFF_P"
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = idx
		.Parameters("@tap").value       = tap
		.Parameters("@position").value  = position
		.Parameters("@name").value      = userName
		.Parameters("@phone1").value    = phone1
		.Parameters("@phone2").value    = phone2
		.Parameters("@phone3").value    = phone3
		.Parameters("@Career").value    = Career
		.Parameters("@File_name").value = FileName
		.Parameters("@Dellfg").value    = Dellfg
		.Parameters("@order").value     = order
		.Execute
	End with
	set objCmd = nothing
End Sub
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	<!--
		if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
		top.location.href = "staff_01_L.asp?<%=pageParams%>";
	//-->
	</script>
</head>
<body></body>
</html>