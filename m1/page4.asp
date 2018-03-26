<!-- #include file="../inc/top.asp" -->
<%
Dim arrList
Dim cntList : cntList  = -1

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
		.CommandText      = "M_BOARD_CONT_MINI_L"
		.Parameters("@Key").value = 25
		.Parameters("@CNT").value = 100
		Set objRs = .Execute
	End with
	set objCmd = nothing

	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">회사소개</span><span class="block2">수상내역</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">수상내역</h3>
			<h6 class="msg">길산파이프(주) 수상내역</h6>
			<p class="msg underline">
				특정 대회의 수상 실적을 확인하고 이를 증명하기 위하여 수상내역을 공개합니다.<br>
				길산파이프의 업적과 우수한 기술력을 확인하실 수 있습니다. 
			</p>
			
			
			<div class="m1_photo_wrap">
				<%for iLoop = 0 to cntList
					If arrList(FI_File_name,iLoop) = "" Then 
						img = "<img alt=""NO IMAGE"">"
					Else
						if FILE_CHECK_EXT( arrList(FI_File_name,iLoop) ) Then 
							img = "<img src=""../upload/board/s_"& arrList(FI_File_name,iLoop) &""" style=""cursor:pointer;"" onclick=""pop_open( '../upload/board/" & arrList(FI_File_name,iLoop) & "' )"">"
						Else
							img = "<img alt=""NO IMAGE"">"
						End If
					End If
				%>
				<div class="box" style="<%=IIF((iLoop+1) Mod 4 =0 ,"width:170px;","")%>">
					<div class="item"><%=img%>
						<div class="title"><%=arrList(FI_title,iLoop)%></div>
					</div>
				</div>
				<%Next%>
				<%If cntList < 0 Then %>
				<div style="text-align:center;">등록된 내용이 없습니다.</div>
				<%End If%>
			</div>
			


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
			<h3>수상내역</h3>
			<a href="#" onclick="pop_close();return false;"><span class="blind">닫기</span></a>
		</div>

		<div><img id="pop_img" onload="pop_position()"></div>
	</div>
</div>

<SCRIPT type="text/javascript">
$(function(){
	$m1_photo_wrap = $('.m1_photo_wrap');
	$m1_photo_wrap.find('img').each(function(){
		$(this).css({ 'margin-left':'-' + ($(this).width()/2) + 'px' , 'margin-top':'-'+ ($(this).height()/2) + 'px' });
		$(this).load(function(){
			$(this).css({ 'margin-left':'-' + ($(this).width()/2) + 'px' , 'margin-top':'-'+ ($(this).height()/2) + 'px' });
		});
	});
	$m1_photo_wrap.find('.item').hover(
		function(){
			$(this).find('.title').stop().animate({'bottom':'0px'},300);
		},
		function(){
			$(this).find('.title').stop().animate({'bottom':'-30px'},300);
		}
	)
});

$more_pop = $('#more_pop');
$pop_img  = $('#pop_img');
$wall     = $('.wall');
function pop_open( src ){
	$pop_img.attr('src',src);
	$wall.height( $(document).height() ).css('z-index','1000').show();
	$more_pop.show();	
}
function pop_close(){
	$pop_img.attr( 'src' , '' );
	$wall.hide();
	$more_pop.hide();
}
function pop_position(){
	var h = $more_pop.height() > 300 ? 300 : $more_pop.height();
	$more_pop.css({ 'z-index':'1100' , 'margin-left':'-'+($more_pop.width()/2)+'px' ,'margin-top': $(document).scrollTop()+((h-200)/2) +'px' }).show();
}
</SCRIPT>
<!-- #include file="../inc/footer.asp" -->