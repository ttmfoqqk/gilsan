<!-- #include file="../inc/top.asp" -->
<%
Dim arrList , arrNoti
Dim cntList  : cntList  = -1
Dim cntNoti  : cntNoti  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 10
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap      : tap      = IIF(request("tap")="","1",request("tap"))

Dim title    : title = "길산파이프(주)"

If tap = "1" Then
	title = "길산파이프(주)"
ElseIf tap = "2" Then 
	title = "길산스틸(주) 계룡본사"
ElseIf tap = "3" Then 
	title = "길산스틸(주) 대전지점"
ElseIf tap = "4" Then 
	title = "길산스틸(주) 광주지점"
ElseIf tap = "5" Then 
	title = "길산에스티(주)"
ElseIf tap = "6" Then 
	title = "길산에스티(주) 코일센터"
ElseIf tap = "7" Then 
	title = "길산에스에스티(주)"
ElseIf tap = "8" Then 
	title = "(주)길산골프클럽 원내점"
ElseIf tap = "9" Then 
	title = "(주)길산골프클럽 장대점"
ElseIf tap = "10" Then 
	title = "석진길산에스에스티(주)"
ElseIf tap = "11" Then 
	title = "(주)길산종합건설"
ElseIf tap = "12" Then 
	title = "(주)길산로지스"
End If


Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"
Dim PageParams : PageParams = "pageNo=" & pageNo & "&tap=" & tap


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_SYSTEM_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
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
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">계열사현황</span><span class="block2">설비현황</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">설비현황</h3>

			<div class="product_tap_area">
				<div class="tap"><a href="page2.asp?tap=1" class="<%=IIF( tap = "1","over","" )%>">길산파이프(주)</a></div>
				<div class="tap"><a href="page2.asp?tap=2" class="<%=IIF( tap = "2","over","" )%>">길산스틸(주) 계룡본사</a></div>
				<div class="tap"><a href="page2.asp?tap=3" class="<%=IIF( tap = "3","over","" )%>">길산스틸(주) 대전지점</a></div>
				<div class="tap"><a href="page2.asp?tap=4" class="<%=IIF( tap = "4","over","" )%>">길산스틸(주) 광주지점</a></div>
				<div class="tap"><a href="page2.asp?tap=5" class="<%=IIF( tap = "5","over","" )%>">길산에스티(주)</a></div>
				<div class="tap"><a href="page2.asp?tap=6" class="<%=IIF( tap = "6","over","" )%>">길산에스티(주) 코일센터</a></div>
				<div class="tap"><a href="page2.asp?tap=7" class="<%=IIF( tap = "7","over","" )%>">길산에스에스티(주)</a></div>
				<div class="tap"><a href="page2.asp?tap=8" class="<%=IIF( tap = "8","over","" )%>">(주)길산골프클럽 원내점</a></div>
				<div class="tap"><a href="page2.asp?tap=9" class="<%=IIF( tap = "9","over","" )%>">(주)길산골프클럽 장대점</a></div>
				<div class="tap"><a href="page2.asp?tap=10" class="<%=IIF( tap = "10","over","" )%>">석진길산에스에스티(주)</a></div>
				<div class="tap"><a href="page2.asp?tap=11" class="<%=IIF( tap = "11","over","" )%>">(주)길산종합건설</a></div>
				<div class="tap"><a href="page2.asp?tap=12" class="<%=IIF( tap = "12","over","" )%>">(주)길산로지스</a></div>
			</div>

			<h6 class="msg underline" style="margin-bottom:40px;"><%=title%></h6>
			
			<table cellpadding="0" cellspacing="0" style="width:100%">
				<%for iLoop = 0 to cntList
					If arrList(FI_File_name,iLoop) = "" Then 
						img = "<img alt=""NO IMAGE"" style=""width:155px;height:207px;"">"
					Else
						if FILE_CHECK_EXT( arrList(FI_File_name,iLoop) ) Then 
							img = "<img src=""../upload/m3/s_"& arrList(FI_File_name,iLoop) &""" style=""max-width:155px;max-height:207px;cursor:pointer;"" onclick=""pop_open( '"& arrList(FI_position,iLoop) &"' , '../upload/m3/" & arrList(FI_File_name,iLoop) & "' )"">"
						Else
							img = "<img alt=""NO IMAGE"" style=""width:155px;height:207px;"">"
						End If
					End If
				%>
				<tr>
					<td style="width:195px;" valign="top"><%=img%></td>
					<td  valign="top">
						<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:14px;line-height:150%;color:#61656e;margin-bottom:40px;table-layout:fixed">
							<tr style="height:40px;">
								<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">종류</td>
								<td style="border-bottom:1px solid #4f4f4f;"><%=arrList(FI_position,iLoop)%></td>
							</tr>
							<tr style="height:40px;">
								<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">모델명</td>
								<td style="border-bottom:1px solid #4f4f4f;"><%=arrList(FI_name,iLoop)%></td>
							</tr>
							<tr style="height:40px;">
								<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">기계사양</td>
								<td style="border-bottom:1px solid #4f4f4f;"><%=arrList(FI_spec,iLoop)%></td>
							</tr>
							<tr style="height:40px;">
								<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">보유대수</td>
								<td style="border-bottom:1px solid #4f4f4f;"><%=arrList(FI_ea,iLoop)%></td>
							</tr>
							<tr>
								<td style="border-bottom:1px solid #4f4f4f;width:100px;padding:10px 0px 10px 20px;" valign="top">비고</td>
								<td style="border-bottom:1px solid #4f4f4f;padding:10px 0px 10px 0px;"><%=arrList(FI_bigo,iLoop)%></td>
							</tr>
						</table>
					</td>
				</tr>
				<%Next%>
				<%if cntList < 0 then%>
				<tr>
					<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:12px;line-height:150%;color:#61656e;margin-bottom:40px;">
						<tr style="height:40px;">
							<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;" align="center">등록된 내용이 없습니다.</td>
						</tr>
					</table>
				</tr>
				<%End If%>
			</table>

			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>



		</div>
	</div>


</div>

<STYLE type="text/css">
	.order_pop{width:auto;top:0px;left:50%;margin:0px;}
</STYLE>
<div class="wall" style="display:none;"></div>
<div id="more_pop" class="order_pop">
	<div class="wrap">
		<div class="title" style="border-bottom:2px solid #4f4f4f;margin-bottom:20px;">
			<h3 id="pop_title">인증서</h3>
			<a href="#" onclick="pop_close();return false;"><span class="blind">닫기</span></a>
		</div>

		<div><img id="pop_img" onload="pop_position()"></div>
	</div>
</div>

<SCRIPT type="text/javascript">
$more_pop  = $('#more_pop');
$pop_img   = $('#pop_img');
$pop_title = $('#pop_title');
$wall      = $('.wall');
function pop_open( title , src ){
	$pop_img.attr('src',src);
	$pop_title.text(title)
	$wall.height( $(document).height() ).css('z-index','1000').show();
	$more_pop.show();
}
function pop_close(){
	$pop_img.attr( 'src' , '' );
	$wall.hide();
	$more_pop.hide();
}
function pop_position(){
	//alert( (( $(document).scrollTop()+$more_pop.height() )/2) +' , '+ $(document).scrollTop())
	var h = $more_pop.height() > 500 ? 500 : $more_pop.height();
	$more_pop.css({ 'z-index':'1100' , 'margin-left':'-'+($more_pop.width()/2)+'px' ,'margin-top': $(document).scrollTop()+((h-200)/2) +'px' }).show();
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->