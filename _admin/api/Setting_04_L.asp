<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim rows      : rows      = 20
Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim pageURL   : pageURL   = g_url & "?pageNo=__PAGE__"

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
		.CommandText      = "KETI_IOT_SETTTING_NODATE_L"
		.Parameters("@rows").value      = rows 
		.Parameters("@pageNo").value    = pageNo
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList  = objRs.GetRows()
		cntList  = UBound(arrList, 2)
		cntTotal = arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>

<script type="text/javascript">

function openPop(mode,idx){
	var html_btn_write = '<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick=chec_fm()>';
	var html_btn_dell = '<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick=del_fm()>';
	var html_btn_area = html_btn_write;
	if(mode == 'UPDATE'){
		html_btn_area += html_btn_dell;
	}
	var d = new Date();
	var d_y = d.getFullYear();
	var d_m = (d.getMonth() + 1) < 10 ? '0'+(d.getMonth() + 1) : (d.getMonth() + 1);
	var d_d = d.getDate() < 10 ? '0'+d.getDate() : d.getDate();
	var y_txt;
	for( i=d_y ; i < d_y+3 ; i++){
		y_txt += '<option value="'+i+'">'+i+'</option>';
	}
	var m_txt,m_val;
	for( i=1 ; i <= 12 ; i++){
		m_val = i < 10 ? "0"+i : i;
		m_txt += '<option value="'+m_val+'">'+i+'</option>';
	}
	var d_txt,d_val;
	for( i=1 ; i <= 31 ; i++){
		d_val = i < 10 ? "0"+i : i;
		d_txt += '<option value="'+d_val+'">'+i+'</option>';
	}
	var html_txt = '' +
		
		'<div class="admin_popup" id="admin_popup">' +
		'<form name="fm" method="POST" action="Setting_04_P.asp">' +
		'<input type="hidden" name="actType" value="'+mode+'"><input type="hidden" name="idx" value="'+idx+'"><input type="hidden" name="pageNo" value="<%=pageNo%>">' +

			'<div class="top_area">' +
				'<div class="title"><img src="../img/pop/title_Setting_04.gif"></div>' +
				'<div class="close"><a href="#">[닫기]</a></div>' +
			'</div>' +
			'<div class="cont">' +
				'<table cellpadding=0 cellspacing=0 width=100%>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">순서</td>'+
						'<td class="line_box"><input type="text" id="ord" name="ord" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">예약불가일자</td>'+
						'<td class="line_box">'+
							'<select id="data_y" name="data_y">'+y_txt+'</select> 년 '+
							'<select id="data_m" name="data_m">'+m_txt+'</select> 월 '+
							'<select id="data_d" name="data_d">'+d_txt+'</select> 일 '+
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">사용여부</td>'+
						'<td class="line_box"><input type="radio" name="usfg" value=0 checked>사용 <input type="radio" name="usfg" value=1> 미사용</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">비고</td>'+
						'<td class="line_box"><textarea id="bigo" name="bigo" style="width:100%;height:80px;"></textarea></td>'+
					'</tr>'+
				'</table>'+
			'</div>' +
			'<div class="btn_area">' + html_btn_area + '</div>' +
		'</form>'+
		'</div>';
		

	$('body').append(html_txt);
	$('#admin_popup .close a').click(function(e){
		e.preventDefault();
		layerPopupClose('wall','admin_popup');
	});

	$("#data_y > option[value = " + d_y + "]").attr("selected", "ture");
	$("#data_m > option[value = " + d_m + "]").attr("selected", "ture");
	$("#data_d > option[value = " + d_d + "]").attr("selected", "ture");

	layerPopupOpen('wall',10,'admin_popup',20);

	if(mode == 'UPDATE'){
		pop_loading()
		$.ajax({
			type: "POST",
			dataType: "xml",
			url: "Setting_04_V.asp",
			data: {
				Idx : idx
			} ,
			success: function(xml){
				var admin_login = $(xml).find("admin_login").text();
				if(admin_login=='login'){
					alert('로그인 세션 만료!');location.reload();return false;
				}
				if ($(xml).find("data").find("item").length > 0) {
					$(xml).find("data").find("item").each(function(idx) {
						var idx      = $(this).find("idx").text();
						var ord      = $(this).find("ord").text();
						var name     = $(this).find("name").text();
						var usfg     = $(this).find("usfg").text();
						var bigo     = $(this).find("bigo").text();
						var indate   = $(this).find("indate").text();
						var tmp_name = name.split("-");

						$('#ord').val( ord );
						$("#data_y > option[value = " + tmp_name[0] + "]").attr("selected", "ture");
						$("#data_m > option[value = " + tmp_name[1] + "]").attr("selected", "ture");
						$("#data_d > option[value = " + tmp_name[2] + "]").attr("selected", "ture");
						$('input[name=usfg]').filter("input[value=" + usfg + "]").attr("checked", "checked");
						$('#bigo').val( bigo );
					});
				}
				layerPopupClose('wall_loading','pop_loading');
			},error:function(err){
				alert('ERR [502] : 고객센터에 문의하세요.' + err.responseText);
				layerPopupClose('wall_loading','pop_loading');
			}
		});
	}
}

function chec_fm(){
	var fm = document.fm;
	$('.btn_area').html("처리중입니다.");
	fm.submit();
}
function del_fm(){
	var fm = document.fm;
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
		$('.btn_area').html("처리중입니다.");
	}
}
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='check_idx']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}

$(document).ready( function() {
	
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=check_idx]').attr({"checked":"checked"}) : $('input[name=check_idx]').attr({"checked":""});
	});
} );
</script>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>

		<form name="AdminForm" method="post" action="Setting_04_P.asp">
		<input type="hidden" name="actType" value="">
		
			<table cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr>
					<td width="50%" style="padding-bottom:3px;"><img src="../img/center_title_02_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 시간설정 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_02_01.gif"></td>
				</tr>
				<tr>
					<td colspan=2>
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="10%">불가일자</td>
								<td class="line_box">비고</td>
								<td class="line_box" width="10%">등록일자</td>
								<td class="line_box" width="13%">등록자</td>
								<td class="line_box" width="10%">사용여부</td>
								<td class="line_box" width="10%">정보수정</td>
							</tr>
							<%for iLoop = 0 to cntList%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;" ><input type="checkbox" name="check_idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box"><%=arrList(FI_Name,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_Bigo,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_Indate,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_AdminName,iLoop)%></td>
								<td class="line_box"><%=IIF( arrList(FI_Usfg,iLoop)="0","사용","미사용" )%></td>
								<td class="line_box"><img src="../img/center_btn_edite_Setting.gif" style="cursor:pointer" onclick="openPop('UPDATE','<%=arrList(FI_Idx, iLoop)%>')"></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="7" align=center>등록된 내용이 없습니다.</td>
							</tr>
							<%end if%>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="openPop('INSERT','')"> &nbsp;&nbsp;
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		
		</form>

		</td>
	</tr>
</table>
<!-- #include file = "../inc/bottom.asp" -->