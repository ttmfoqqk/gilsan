<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\board/" '÷�� ������.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 50 * 1024 * 1024 '5�ް�


Dim alertMsg

	
Dim actType       : actType      = Trim( UPLOAD__FORM("actType") )
Dim Idx           : Idx          = IIF( UPLOAD__FORM("Idx")="" , "0" , UPLOAD__FORM("Idx") )
Dim BoardKey      : BoardKey     = UPLOAD__FORM("BoardKey")
Dim UserId        : UserId      = IIF( UPLOAD__FORM("UserId")="" , 0 , UPLOAD__FORM("UserId") )
Dim Title         : Title        = TagEncode( Trim( UPLOAD__FORM("Title") ) )
Dim Contants      : Contants     = Trim( UPLOAD__FORM("Contants") )
Dim FileName      : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg    : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName   : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )
Dim FileName2     : FileName2    = Trim( UPLOAD__FORM("FileName2") )
Dim DellFileFg2   : DellFileFg2  = UPLOAD__FORM("DellFileFg2")
Dim oldFileName2  : oldFileName2 = Trim( UPLOAD__FORM("oldFileName2") )
Dim tag           : tag          = TagEncode( Trim( UPLOAD__FORM("tag") ) )
Dim website       : website      = TagEncode( Trim( UPLOAD__FORM("website") ) )
Dim Notice        : Notice       = IIF( UPLOAD__FORM("Notice")="" , 0 , UPLOAD__FORM("Notice") )
Dim Secret        : Secret       = IIF( UPLOAD__FORM("Secret")="",0,UPLOAD__FORM("Secret") )
Dim tap           : tap          = UPLOAD__FORM("tap")
Dim userEmail     : userEmail    = UPLOAD__FORM("userEmail")
Dim AdminIdx      : AdminIdx     = Session("Admin_Idx")
Dim Order         : Order        = IIF( UPLOAD__FORM("Order")="" , "0" , UPLOAD__FORM("Order") )

Dim PageParams    : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))


Call Expires()
Call dbopen()
	Call BoardCodeView()
	If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then
		
		Call dbclose()
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('�߸��� �Խ��� �ڵ� �Դϴ�.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'���ۼ�
		
		If FileName <>"" Then 
			'If FILE_CHECK_EXT2(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 50MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			'Else
			'	With Response
			'	 .Write "<script language='javascript' type='text/javascript'>"
			'	 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
			'	 .Write "history.go(-1);"
			'	 .Write "</script>"
			'	 .End
			'	End With
			'End If
		End If

		If FileName2 <>"" Then 
			'If FILE_CHECK_EXT2(FileName2) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName2").FileLen Then 
					FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 50MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			'Else
			'	With Response
			'	 .Write "<script language='javascript' type='text/javascript'>"
			'	 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
			'	 .Write "history.go(-1);"
			'	 .Write "</script>"
			'	 .End
			'	End With
			'End If
		End If
		
		Call insert()
		alertMsg = "�Է� �Ǿ����ϴ�."

	ElseIf (actType = "UPDATE") Then	'�ۼ���
		
		If FileName <>"" Then 
			'If FILE_CHECK_EXT2(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 50MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			'Else
			'	With Response
			'	 .Write "<script language='javascript' type='text/javascript'>"
			'	 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
			'	 .Write "history.go(-1);"
			'	 .Write "</script>"
			'	 .End
			'	End With
			'End If

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

		If FileName2 <>"" Then 
			'If FILE_CHECK_EXT2(FileName2) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName2").FileLen Then 
					FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('������ ũ��� 50MB �� �ѱ�� �����ϴ�.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			'Else
			'	With Response
			'	 .Write "<script language='javascript' type='text/javascript'>"
			'	 .Write "alert('�߸��� �����Դϴ�. [asp,php,jsp,html,js] ������ ���ε� �Ҽ� �����ϴ�.');"
			'	 .Write "history.go(-1);"
			'	 .Write "</script>"
			'	 .End
			'	End With
			'End If

			If oldFileName2 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then	' ���� �̸��� ������ ���� �� ����
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
					End If
				set FSO = Nothing
			End If
		Else
			FileName2 = oldFileName2
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

		If DellFileFg2 = "1" Then 
			If oldFileName2 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then	' ���� �̸��� ������ ���� �� ����
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
					End If
				set FSO = Nothing
			End If

			FileName2 = ""
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
		.Parameters("@File_name2").value= FileName2
		.Parameters("@Notice").value    = Notice
		.Parameters("@Secret").value    = Secret
		.Parameters("@Ip").value        = g_uip
		.Parameters("@AdminIdx").value  = AdminIdx
		.Parameters("@website").value   = website
		.Parameters("@tag").value       = tag
		If tap <> "" Then 
		.Parameters("@tap").value       = tap
		End If
		If BoardKey = "25" or BoardKey = "26" Then 
		.Parameters("@order").value     = order
		End If
		.Parameters("@email").value     = userEmail
		.Execute
	End with
	set objCmd = nothing
End Sub

Sub BoardCodeView()
'���ü�����
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
		if("<%=actType%>" == "UPDATE"){
			top.location.href = "Customer_01_V.asp?<%=pageParams%>&Idx=<%=Idx%>";
		}else{
			top.location.href = "Customer_01_L.asp?<%=pageParams%>";
		}
	//-->
	</script>
</head>
<body></body>
</html>