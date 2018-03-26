<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\Api/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 30 * 1024 * 1024 '5메가



Dim alertMsg    : alertMsg    = ""
Dim actType     : actType     = UPLOAD__FORM("actType")
Dim idx         : idx         = IIF( UPLOAD__FORM("idx")="" , "0" , UPLOAD__FORM("idx") )
Dim name        : name        = TagEncode ( UPLOAD__FORM("dname") )
Dim tag         : tag         = TagEncode ( UPLOAD__FORM("tag") )
Dim description : description = UPLOAD__FORM("contants")
Dim cate1       : cate1       = IIF( UPLOAD__FORM("cate1")="" , -1 , UPLOAD__FORM("cate1") )
Dim cate2       : cate2       = IIF( UPLOAD__FORM("cate2")="" , -1 , UPLOAD__FORM("cate2") )
Dim cate3       : cate3       = IIF( UPLOAD__FORM("cate3")="" , -1 , UPLOAD__FORM("cate3") )
Dim cate4       : cate4       = IIF( UPLOAD__FORM("cate4")="" , -1 , UPLOAD__FORM("cate4") )
Dim mfIdx       : mfIdx       = IIF( UPLOAD__FORM("mfIdx")="" , 0 , UPLOAD__FORM("mfIdx") )
Dim modelIdx    : modelIdx    = IIF( UPLOAD__FORM("modelIdx")="" , 0 , UPLOAD__FORM("modelIdx") )
Dim Order       : Order       = IIF( UPLOAD__FORM("order")="" , 0 , UPLOAD__FORM("order") )
Dim usFg        : usFg        = IIF( UPLOAD__FORM("usFg")="" , 0 , UPLOAD__FORM("usFg") )

'다중인풋
ApiUrl         = TagEncode( Trim( UPLOAD__FORM("ApiUrl") ) )
ApiFunc        = TagEncode( Trim( UPLOAD__FORM("ApiFunc") ) )
ApiMethod      = TagEncode( Trim( UPLOAD__FORM("ApiMethod") ) )
ApiUrls        = TagEncode( Trim( UPLOAD__FORM("ApiUrls") ) )
ApiUrlParameter= TagEncode( Trim( UPLOAD__FORM("ApiUrlParameter") ) )
' textarea
ApiDescription = TagEncode( Trim( UPLOAD__FORM("ApiDescription") ) )
Apiparameter   = TagEncode( Trim( UPLOAD__FORM("Apiparameter") ) )
Apiheader      = TagEncode( Trim( UPLOAD__FORM("Apiheader") ) )
Apibody        = TagEncode( Trim( UPLOAD__FORM("Apibody") ) )

'다중인풋

Dim FileName    : FileName    = UPLOAD__FORM("FileName")
Dim oldFileName : oldFileName = UPLOAD__FORM("oldFileName")
Dim DellFileFg  : DellFileFg  = UPLOAD__FORM("DellFileFg")

Dim sname       : sname       = UPLOAD__FORM("sname")
Dim scate1      : scate1      = UPLOAD__FORM("scate1")
Dim scate2      : scate2      = UPLOAD__FORM("scate2")
Dim scate3      : scate3      = UPLOAD__FORM("scate3")
Dim scate4      : scate4      = UPLOAD__FORM("scate4")
Dim smfIdx      : smfIdx      = UPLOAD__FORM("smfIdx")
Dim smodelIdx   : smodelIdx   = UPLOAD__FORM("smodelIdx")
Dim susFg       : susFg       = UPLOAD__FORM("susFg")
Dim inDate      : inDate      = UPLOAD__FORM("sinDate")
Dim outDate     : outDate     = UPLOAD__FORM("soutDate")
Dim pageNo      : pageNo      = IIF( UPLOAD__FORM("pageNo")="" , "1" , UPLOAD__FORM("pageNo") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&sname=" & sname &_
		"&cate1=" & scate1 &_
		"&cate2=" & scate2 &_
		"&cate3=" & scate3 &_
		"&cate4=" & scate4 &_
		"&mfIdx=" & smfIdx &_
		"&modelIdx=" & smodelIdx &_
		"&usFg=" & susFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

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
		.CommandText      = "KETI_API_DEVICE_P"
		.Parameters("@actType").value        = actType
		.Parameters("@idx").value            = idx
		.Parameters("@name").value           = name
		.Parameters("@description").value    = description
		.Parameters("@file").value           = FileName
		.Parameters("@tag").value            = tag
		.Parameters("@mfIdx").value          = mfIdx
		.Parameters("@modelIdx").value       = modelIdx
		.Parameters("@cate1").value          = cate1
		.Parameters("@cate2").value          = cate2
		.Parameters("@cate3").value          = cate3
		.Parameters("@cate4").value          = cate4
		.Parameters("@usFg").value           = usFg
		.Parameters("@userIdx").value        = Session("Admin_Idx")
		.Parameters("@userFg").value         = 1
		.Parameters("@function").value       = ApiFunc
		.Parameters("@api").value            = ApiUrl
		.Parameters("@method").value         = ApiMethod
		.Parameters("@url").value            = ApiUrls
		.Parameters("@urlParameter").value   = ApiUrlParameter
		.Parameters("@apiDescription").value = ApiDescription
		.Parameters("@parameter").value      = Apiparameter
		.Parameters("@header").value         = Apiheader
		.Parameters("@body").value           = Apibody
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
		//top.location.href = "api_01_01_W.asp?<%=pageParams%>&Idx=<%=Idx%>";
		top.location.href = "api_02_05_L.asp?<%=pageParams%>";
	}else{
		top.location.href = "api_02_05_L.asp?<%=pageParams%>";
	}
	</script>
</head>
<body></body>
</html>