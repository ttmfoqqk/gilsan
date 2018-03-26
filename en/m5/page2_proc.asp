<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<!-- #include file = "../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 5 * 1024 * 1024 '5메가


Dim alertMsg

Dim actType       : actType      = Trim( UPLOAD__FORM("actType") )
Dim Idx           : Idx          = IIF( UPLOAD__FORM("Idx")="" , "0" , UPLOAD__FORM("Idx") )
Dim BoardKey      : BoardKey     = 20
Dim UserId        : UserId       = session("UserId")
Dim Title         : Title        = TagEncode( Trim( UPLOAD__FORM("title") ) )
Dim Contants      : Contants     = Trim( UPLOAD__FORM("Contants") )
Dim FileName      : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg    : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName   : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )
Dim Secret        : Secret       = IIF( UPLOAD__FORM("Secret")="",0,UPLOAD__FORM("Secret") )
Dim userEmail     : userEmail    = UPLOAD__FORM("userEmail1") & "@" & UPLOAD__FORM("userEmail2")

Dim PageParams    : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))


Call Expires()
Call dbopen()
	Call BoardCodeView()
	If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then
		
		Call dbclose()
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 게시판 코드 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,136)
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
				 .Write "alert('사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.');"
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
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,136)
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
				 .Write "alert('사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.');"
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
		.ActiveConnection	= objConn
		.prepared				= true
		.CommandType		= adCmdStoredProc
		.CommandText		= "M_BOARD_CONT_P"
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = Idx
		.Parameters("@Key").value       = BoardKey
		.Parameters("@UserId").value   = UserId
		.Parameters("@Title").value     = Title
		.Parameters("@Contants").value  = Contants
		.Parameters("@File_name").value = FileName
		.Parameters("@Ip").value        = g_uip
		.Parameters("@email").value     = userEmail
		.Execute
	End with
	set objCmd = nothing
End Sub

Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	<!--
		if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
		top.location.href = "page2.asp?<%=pageParams%>";
	//-->
	</script>
</head>
<body></body>
</html>