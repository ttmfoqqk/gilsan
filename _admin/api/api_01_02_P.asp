<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\Api/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 30 * 1024 * 1024 '5메가

Dim alertMsg : alertMsg = ""

Dim actType       : actType       = UPLOAD__FORM("actType")
Dim idx           : idx           = IIF( UPLOAD__FORM("idx")="" , "0" , UPLOAD__FORM("idx") )
Dim pname         : pname         = TagEncode ( UPLOAD__FORM("pname") )
Dim Method        : Method        = TagEncode ( UPLOAD__FORM("Method") )
Dim Url           : Url           = TagEncode ( UPLOAD__FORM("Url") )
Dim UrlParameter  : UrlParameter  = TagEncode ( UPLOAD__FORM("UrlParameter") )
Dim tag           : tag           = TagEncode ( UPLOAD__FORM("tag") )

Dim description   : description   = UPLOAD__FORM("contants")
Dim Header        : Header        = UPLOAD__FORM("Header")
Dim BodyAttribute : BodyAttribute = UPLOAD__FORM("BodyAttribute")
Dim Body          : Body          = UPLOAD__FORM("Body")
Dim sample        : sample        = UPLOAD__FORM("sample")

Dim parent        : parent        = IIF( UPLOAD__FORM("parent")="" , "0" , UPLOAD__FORM("parent") )
Dim usFg          : usFg          = IIF( UPLOAD__FORM("usFg")="" , "0" , UPLOAD__FORM("usFg") )
Dim order         : order         = IIF( UPLOAD__FORM("order")="" , "0" , UPLOAD__FORM("order") )


Dim FileName      : FileName      = UPLOAD__FORM("FileName")
Dim oldFileName   : oldFileName   = UPLOAD__FORM("oldFileName")
Dim DellFileFg    : DellFileFg    = UPLOAD__FORM("DellFileFg")

Dim spname        : spname        = UPLOAD__FORM("spname")
Dim sparent       : sparent       = UPLOAD__FORM("sparent")
Dim stag          : stag          = UPLOAD__FORM("stag")
Dim susFg         : susFg         = UPLOAD__FORM("susFg")
Dim sinDate       : sinDate       = UPLOAD__FORM("sinDate")
Dim soutDate      : soutDate      = UPLOAD__FORM("soutDate")
Dim pageNo        : pageNo        = IIF( UPLOAD__FORM("pageNo")="" , "1" , UPLOAD__FORM("pageNo") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&pname=" & spname &_
		"&tag=" & stag &_
		"&parent=" & sparent &_
		"&usFg=" & susFg &_
		"&inDate=" & sinDate &_
		"&outDate=" & soutDate

Call Expires()
Call dbopen()

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,84)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 30MB 를 넘길수 없습니다.');"
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
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,84)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 30MB 를 넘길수 없습니다.');"
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
		.CommandText      = "KETI_API_PLATFORM_P"
		.Parameters("@actType").value      = actType
		.Parameters("@idx").value          = idx
		.Parameters("@name").value         = pname
		.Parameters("@tag").value          = tag
		.Parameters("@description").value  = description
		.Parameters("@parentIdx").value    = parent
		.Parameters("@order").value        = order
		.Parameters("@usFg").value         = usFg

		.Parameters("@Method").value       = Method
		.Parameters("@Url").value          = Url
		.Parameters("@UrlParameter").value = UrlParameter
		.Parameters("@Header").value       = Header
		.Parameters("@BodyAttribute").value= BodyAttribute
		.Parameters("@Body").value         = Body
		.Parameters("@sample").value       = sample
		.Execute
	End with
	set objCmd = nothing
End Sub
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
	if("<%=actType%>" == "UPDATE"){
		//top.location.href = "api_01_W.asp?<%=pageParams%>&Idx=<%=Idx%>";
		top.location.href = "api_01_02_L.asp?<%=pageParams%>";
	}else{
		top.location.href = "api_01_02_L.asp?<%=pageParams%>";
	}
	</script>
</head>
<body></body>
</html>