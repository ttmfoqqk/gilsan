<!-- #include file = "../inc/header.asp" -->
<%
Dim alertMsg

Dim actType    : actType    = Request("actType")
Dim Idx        : Idx        = IIF( Request("Idx")="" , "0" , Request("Idx") )
Dim BoardKey   : BoardKey   = Request("BoardKey")
Dim name       : name       = TagEncode( Request("name") )
Dim Order      : Order      = IIF( Request("Order")="" , "0" , Request("Order") )
Dim PageParams : PageParams = URLDecode( Request("PageParams") )


Call Expires()
Call dbopen()

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then
		alertMsg = "�Է� �Ǿ����ϴ�."
	ElseIf (actType = "UPDATE") Then
		alertMsg = "���� �Ǿ����ϴ�."
	ElseIf (actType = "DELETE") Then
		alertMsg = "���� �Ǿ����ϴ�."
	else
		alertMsg = "actType[" & actType & "]�� ���ǵ��� �ʾҽ��ϴ�."
	end If

	Call proc()
Call dbclose()

Sub proc()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection	= objConn
		.prepared				= true
		.CommandType		= adCmdStoredProc
		.CommandText		= "M_BOARD_TAP_P"
		.Parameters("@actType").value = actType
		.Parameters("@Idx").value     = Idx
		.Parameters("@key").value     = BoardKey
		.Parameters("@name").value    = name
		.Parameters("@order").value   = Order
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
		if("<%=actType%>" == "UPDATE"){
			top.location.href = "Customer_02_L.asp?<%=pageParams%>";
		}else{
			top.location.href = "Customer_02_L.asp?<%=pageParams%>";
		}
	//-->
	</script>
</head>
<body></body>
</html>