<!-- #include file="../inc/top.asp" -->
<%
Dim arrList , arrNoti
Dim cntList  : cntList  = -1
Dim cntNoti  : cntNoti  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 10
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"
Dim PageParams : PageParams = "pageNo=" & pageNo


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@Key").value      = 19
		.Parameters("@UserName").value = UserName
		.Parameters("@UserId").value   = UserId
		.Parameters("@Indate").value   = Indate
		.Parameters("@Outdate").value  = Outdate
		.Parameters("@tap").value      = tap
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	'공지사항
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "NOTICE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrNoti		= objRs.GetRows()
		cntNoti		= UBound(arrNoti, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">자주 묻는 질문</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">자주 묻는 질문</h3>
			
			<div class="faq">
				<%for iLoop = 0 to cntList%>
				<div class="title"><a href="#"><%=arrList(FI_Title,iLoop)%></a></div>
				<div class="cont">
					<%=arrList(FI_Contants,iLoop)%>
				</div>
				<%Next%>
				<%If cntList < 0 Then %>
				<div class="title" style="background:url();">등록된 내용이 없습니다.</div>
				<%End If%>
			</div>

			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>

		</div>
		
		
	</div>


</div>

<SCRIPT type="text/javascript">
$faq_title = $('.faq .title');
$faq_cont  = $('.faq .cont');

$faq_title.find('a').click(function(e){
	e.preventDefault();
	$faq_title.removeClass('on');
	$faq_cont.hide();
	$(this).parent().addClass('on').next().show();
});

</SCRIPT>

<!-- #include file="../inc/footer.asp" -->