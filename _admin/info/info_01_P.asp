<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\m3/" '÷�� ������.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 5 * 1024 * 1024 '5�ް�


Dim alertMsg

Dim actType     : actType      = Trim( UPLOAD__FORM("actType") )
Dim idx         : idx          = IIF( UPLOAD__FORM("idx")="" , "0" , UPLOAD__FORM("idx") )

Dim tap         : tap          = IIF( UPLOAD__FORM("tap")="" , "0" , UPLOAD__FORM("tap") )
Dim position    : position     = UPLOAD__FORM("position")
Dim userName    : userName     = UPLOAD__FORM("userName")
Dim spec        : spec         = UPLOAD__FORM("spec")
Dim ea          : ea           = UPLOAD__FORM("ea")

Dim bigo         : bigo         = Trim( UPLOAD__FORM("bigo") )
Dim FileName    : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg  : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )
Dim Order       : Order        = IIF( UPLOAD__FORM("Order")="" , "0" , UPLOAD__FORM("Order") )

Dim PageParams  : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))


Call Expires()
Call dbopen()
	

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'���ۼ�
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 5MB �� �ѱ�� �����ϴ�.');"
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
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 5MB �� �ѱ�� �����ϴ�.');"
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
		.CommandText      = "M_SYSTEM_P"
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = idx
		.Parameters("@tap").value       = tap
		.Parameters("@position").value  = position
		.Parameters("@name").value      = userName
		.Parameters("@spec").value      = spec
		.Parameters("@ea").value        = ea
		.Parameters("@bigo").value      = bigo
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
		top.location.href = "info_01_L.asp?<%=pageParams%>";
	//-->
	</script>
</head>
<body></body>
</html>