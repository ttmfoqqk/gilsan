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
Dim mname       : mname       = TagEncode ( UPLOAD__FORM("mname") )
Dim description : description = UPLOAD__FORM("contants")
Dim Order       : Order       = IIF( UPLOAD__FORM("order")="" , 0 , UPLOAD__FORM("order") )
Dim usFg        : usFg        = IIF( UPLOAD__FORM("usFg")="" , 0 , UPLOAD__FORM("usFg") )

Dim FileName    : FileName    = UPLOAD__FORM("FileName")
Dim oldFileName : oldFileName = UPLOAD__FORM("oldFileName")
Dim DellFileFg  : DellFileFg  = UPLOAD__FORM("DellFileFg")

Dim smname      : smname      = UPLOAD__FORM("smname")
Dim suserId     : suserId     = UPLOAD__FORM("suserId")
Dim susFg       : susFg       = UPLOAD__FORM("susFg")
Dim suserFg     : suserFg     = UPLOAD__FORM("suserFg")
Dim sinDate     : sinDate     = UPLOAD__FORM("sinDate")
Dim soutDate    : soutDate    = UPLOAD__FORM("soutDate")
Dim pageNo      : pageNo      = IIF( UPLOAD__FORM("pageNo")="" , "1" , UPLOAD__FORM("pageNo") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&mname=" & smname &_
		"&userId=" & suserId &_
		"&usFg=" & susFg &_
		"&userFg=" & suserFg &_
		"&inDate=" & sinDate &_
		"&outDate=" & soutDate

Call Expires()
Call dbopen()

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'���ۼ�
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath)
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
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath)
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
		.CommandText      = "KETI_PRODUCT_P"
		.Parameters("@actType").value     = actType
		.Parameters("@idx").value         = idx
		.Parameters("@name").value        = mname
		.Parameters("@description").value = description
		.Parameters("@tag").value         = tag
		.Parameters("@website").value     = website
		.Parameters("@file").value        = website
		.Parameters("@sw").value          = website
		.Parameters("@userIdx").value     = Session("Admin_Idx")
		.Parameters("@userId").value      = "������"
		.Parameters("@userFg").value      = 1
		.Parameters("@usFg").value        = usFg
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
		//top.location.href = "product_01_W.asp?<%=pageParams%>&Idx=<%=Idx%>";
		top.location.href = "product_01_L.asp?<%=pageParams%>";
	}else{
		top.location.href = "product_01_L.asp?<%=pageParams%>";
	}
	</script>
</head>
<body></body>
</html>