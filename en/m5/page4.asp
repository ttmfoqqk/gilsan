<!-- #include file="../inc/top.asp" -->
<%
Dim arrList , arrNoti  , arrCate
Dim cntList  : cntList  = -1
Dim cntNoti  : cntNoti  = -1
Dim cntCate  : cntCate  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 12
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap      : tap      = IIF( request("tap")="",0,request("tap") )

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"  & "&tap=" & tap
Dim PageParams : PageParams = "pageNo=" & pageNo & "&tap=" & tap


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@Key").value    = 22
		.Parameters("@tap").value    = tap
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
	'카테고리
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "CATE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrCate		= objRs.GetRows()
		cntCate		= UBound(arrCate, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">길산소개</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<form name="sForm" id="sForm" method="GET">
			<h3 class="title">길산소개
				<span style="font-size:14px;vertical-align:middle;margin-left:20px;">카테고리</span>
				<select name="tap" id="tap" onchange="$('#sForm').submit();" style="vertical-align:middle;height:32px;">
					<option value="">선택</option>
					<%for iLoop = 0 to cntCate%>
					<option value="<%=arrCate(CATE_Idx,iLoop)%>" <%=IIF( CStr(tap) = CStr(arrCate(CATE_Idx,iLoop)) ,"selected","" )%>><%=arrCate(CATE_name,iLoop)%></option>
					<%next%>
				</select>
			</h3>
			</form>

			<div id="gallery">
				<!-- 아이템 -->
				<%for iLoop = 0 to cntList
					If arrList(FI_File_name,iLoop) = "" Then 
						img = "<img alt=""NO IMAGE"">"
					Else
						if FILE_CHECK_EXT( arrList(FI_File_name,iLoop) ) Then 
							img = "<img src=""../upload/board/s_"& arrList(FI_File_name,iLoop) &""">"
						Else
							img = "<img alt=""NO IMAGE"">"
						End If
					End If
				%>
				<div class="item">
					<div class="img"><a href="page4_view.asp?<%=PageParams%>&idx=<%=arrList(FI_idx,iLoop)%>"><%=img%></a></div>
					<div class="title"><a href="page4_view.asp?<%=PageParams%>&idx=<%=arrList(FI_idx,iLoop)%>"><%=arrList(FI_Title,iLoop)%></a></div>
					<div class="date"><%=arrList(FI_indate,iLoop)%></div>
				</div>
				<%Next%>
				<%If cntList < 0 Then %>
				<div style="text-align:center;">등록된 내용이 없습니다.</div>
				<%End If%>
				<!-- 아이템 -->

			</div>
			<center>
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</center>

		</div>
	</div>


</div>
<SCRIPT type="text/javascript">

var _xy  = [ [0,0] , [251,0] , [502,0] ];

$(window).load(function(){
	$('#gallery .item').each(function(index){
		var _temp_xy    = _xy[0];
		var _temp_index = 0;

		for( var i=_xy.length-1; i >= 0 ; i-- ){
			if( _temp_xy[1] >= _xy[i][1]){
				_temp_xy = _xy[i];
				_temp_index = i;
			}
		}
		$(this).css({ 'left' : _temp_xy[0]+'px' , 'top' : _temp_xy[1]+'px' });
		_xy[_temp_index][1] = _temp_xy[1] +  $(this).height() + 40;
	});

	var _temp_xy = _xy[0];
	
	for( var i=_xy.length-1; i >= 0 ; i-- ){
		if( _temp_xy[1] <= _xy[i][1]){
			_temp_xy = _xy[i];
		}
	}
	$('#gallery').height(_temp_xy[1] + 30);
	$('#gallery').height(_temp_xy[1] + 30);
});
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->