<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\Api/" '÷�� ������.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 30 * 1024 * 1024 '5�ް�



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

'������ǲ
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

'������ǲ

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
	Elseif (actType = "INSERT") Then	'���ۼ�
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,84)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 30MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		End If
		
		Call insert()
		alertMsg = "�Է� �Ǿ����ϴ�."

	ElseIf (actType = "UPDATE") Then	'�ۼ���
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,84)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 30MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If

			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' ���� �̸��� ������ ���� �� ����
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
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' ���� �̸��� ������ ���� �� ����
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If

			FileName = ""
		End If

		Call insert()
		alertMsg = "���� �Ǿ����ϴ�."
	ElseIf (actType = "DELETE") Then	'�ۻ���
		
		'�� ������ ���� ����
		'If FI_FileName <> "" Then
		'	Set FSO = CreateObject("Scripting.FileSystemObject")
		'		If (FSO.FileExists(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)) Then	' ���ϻ���
		'			fso.deletefile(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)
		'		End If
		'	set FSO = Nothing
		'End If

		Call insert()
		alertMsg = "���� �Ǿ����ϴ�."
	else
		alertMsg = "actType[" & actType & "]�� ���ǵ��� �ʾҽ��ϴ�."
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