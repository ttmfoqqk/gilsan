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
		alertMsg = "입력 되었습니다."
	ElseIf (actType = "UPDATE") Then
		alertMsg = "수정 되었습니다."
	ElseIf (actType = "DELETE") Then
		alertMsg = "삭제 되었습니다."
	else
		alertMsg = "actType[" & actType & "]이 정의되지 않았습니다."
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