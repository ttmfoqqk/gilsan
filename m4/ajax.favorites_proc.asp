<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Dim actType     : actType     = Request("actType")
Dim idx         : idx         = Request("idx")
Dim companyCode : companyCode = Request("companyCode")
Dim itemCode    : itemCode    = Request("itemCode")
Dim productCode : productCode = Request("productCode")
Dim thickCode   : thickCode   = Request("thickCode")
Dim widthCode   : widthCode   = Request("widthCode")
Dim length      : length      = Request("length")
Dim qty         : qty         = Request("qty")

If session("userId") = "" Or IsNull(session("userId")) = True Then 
	Response.write "1"
	Response.End
End If

If actType = "insert" Then 
	
	Dim steelCode   : steelCode   = Split( productCode,"-" )(0)
	Dim surfaceCode : surfaceCode = Split( productCode,"-" )(2)
	Dim shapeCode   : shapeCode   = Split( productCode,"-" )(1)

	If companyCode = "" Or itemCode = "" Or productCode = "" Or thickCode = "" Or widthCode = "" Or length = "" Or qty = "" Then 
		Response.write "2"
		Response.End
	End If

	If IsNumeric(length) = False Or IsNumeric(qty) = False Then 
		Response.write "3"
		Response.End
	End If

	Call Expires()
	Call dbopen()
		Call insert()
	Call dbclose()

	Response.write "0"
	Response.End
ElseIf actType = "delete" Then 
	
	If idx = "" Or IsNumeric(idx) = False Then 
		Response.write "1"
		Response.End
	End If

	Call Expires()
	Call dbopen()
		Call delete()
	Call dbclose()

	Response.write "0"
	Response.End

End If

Sub insert()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_FAVORITES_INSERT"
		.Parameters("@ID").value          = session("userId")
		.Parameters("@COCODE").value      = companyCode
		.Parameters("@TYPECODE").value    = itemCode
		.Parameters("@STEELCODE").value   = steelCode
		.Parameters("@SURFACE").value     = surfaceCode
		.Parameters("@EXTDIA").value      = widthCode
		.Parameters("@THICK").value       = thickCode
		.Parameters("@QTY").value         = qty
		.Parameters("@IP").value          = Request.ServerVariables("REMOTE_ADDR")
		.Parameters("@LENGTH").value      = length
		.Parameters("@shape").value       = shapeCode
		.Execute
	End with
	set objCmd = nothing
End Sub

Sub delete()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_FAVORITES_DELETE"
		.Parameters("@ID").value  = session("userId")
		.Parameters("@IDX").value = idx
		.Execute
	End with
	set objCmd = nothing
End Sub
%>