<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
checkLoginPOP()
Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 10
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim unloadplace : unloadplace = request("unloadplace")

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"
Dim PageParams : PageParams = "pageNo=" & pageNo

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_UNLOADPLACE_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@ID").value     = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 길산파이프(주)-하차장소 </title>
<meta name="Generator" content="EditPlus">
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script type="text/javascript" src="../common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/JavaScript" src="../common/js/common.js"></script>
<script type="text/JavaScript" src="../inc/js/default.js"></script>
<link rel="stylesheet" type="text/css" href="../inc/css/default.css">
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
</head>

<body>
<STYLE type="text/css">
html {overflow:hidden;} 
body{
	min-width:500px;overflow:hidden
}
.order_pop{
	position:relative;top:0px;left:0px;width:480px;display:block;margin:0px auto;padding:0px;margin-top:20px;
}
</STYLE>
<div id="middle_sub">
	
	<div class="order_pop">

			<div class="title">
				<h3>나의 하차장소</h3>
				<a href="#" onclick="window.close();"><span class="blind">닫기</span></a>
			</div>
			
			<form name="mForm" id="mForm" method="post" action="pop_unloadplace_proc.asp" onsubmit="return check()">
			<input type="hidden" name="actType" value="insert">
			<div class="form_wrap" style="width:100%;">
				<div class="row" style="z-index:50;">
					<label style="width:80px;">새 하차장소</label>
					<input type="text" id="unloadplace" name="unloadplace" class="input" style="width:300px;ime-mode:active;vertical-align:middle;" maxlength="200" value="<%=unloadplace%>">
					&nbsp;<button type="submit" class="btn" style="height:32px;width:70px;vertical-align:middle;">등록</button>
				</div>
			</div>
			</form>

			<table class="reserve_table" cellpadding="0" cellspacing="0">
				<tr>
					<th style="width:40px;">번호</th>
					<th style="width:100px;">등록ID</th>
					<th>하차장소</th>
					<th style="width:70px;">삭제</th>
				</tr>
				<%for iLoop = 0 to cntList
					
					onclick="selectText('" & arrList(FI_UNLOADPLACE,iLoop) & "')"
				%>
				<tr class="list">
					<td onclick="<%=onclick%>"><%=arrList(FI_rownum,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_ID,iLoop)%></td>
					<td onclick="<%=onclick%>"><%=arrList(FI_UNLOADPLACE,iLoop)%></td>
					<td style="cursor:auto;"><button type="button" class="btn" onclick="Delete(<%=arrList(FI_idx,iLoop)%>)">삭제</button></td>
				</tr>
				<%Next%>
				<%If cntList < 0 Then %>
				<tr>
					<td colspan="3" style="cursor:auto;">등록된 내용이 없습니다.</td>
				</tr>
				<%End If%>
			</table>
			
			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>

	</div>
	
</div>


<SCRIPT type="text/javascript">
$unloadplace = $('#unloadplace');

function check(){
	if( !trim( $unloadplace.val() ) ){
		alert('하차장소를 입력해주세요.');
		return false;
	}	
}
function Delete(idx){
	if( !confirm('삭제 하시겠습니까?') ){
		return false;
	}
	document.location.href='pop_unloadplace_proc.asp?actType=delete&idx='+idx;
}
function selectText( txt ){
	opener.document.mForm.unloadplace.value = txt;
	window.close();
}
</SCRIPT>
<body>
</html>