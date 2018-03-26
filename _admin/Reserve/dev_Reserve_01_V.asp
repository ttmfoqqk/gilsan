<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & "/_admin/Reserve/Reserve_01_L.asp" )

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0


Dim idx : idx = Request("idx")

Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim userName  : userName  = request("userName")
Dim area      : area      = request("area")
Dim state     : state     = request("state")
Dim cSdate    : cSdate    = request("cSdate")
Dim cEdate    : cEdate    = request("cEdate")
Dim Other1    : Other1    = request("Other1")

Dim pageParam
pageParam = "pageNo="& pageNo &_
		"&userName=" & userName   &_
		"&area="     & area   &_
		"&state="    & state  &_
		"&cSdate="   & cSdate &_
		"&cEdate="   & cEdate &_
		"&Other1="   & Other1


Call Expires()
Call dbopen()
	Call getView()
Call dbclose()


Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_IOT_NEW_RESERVE_V"
		.Parameters("@idx").value  = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")

	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "AREA")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If

	objRs.close	: Set objRs = Nothing
End Sub

%>
<STYLE type="text/css">
.line_box{padding:7px 10px 7px 10px;}
.btn_row_action{padding:0px;margin:0px;width:20px;height:20px;border:1px solid #7f9db9;color:#7f9db9;margin-left:5px;font-weight:bold;cursor:pointer;font-size:13px;background-color:#ffffff;}
</STYLE>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
			
			<form name="AdminForm" method="POST" action="Reserve_01_P.asp" onsubmit="return check()">
			<input type="hidden" name="pageParam" value="<%=Replace(pageParam,"=","%3D")%>">
			<input type="hidden" name="idx" value="<%=idx%>">

			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 예약현황 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_reserve.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed;">
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">예약자</td>
								<td class="line_box" style="word-break:break-all" width="280"><%=FI_UserName%></td>
								<td class="line_box" bgcolor="f0f0f0" width="100">등록일</td>
								<td class="line_box" style="word-break:break-all"><%=FI_indate%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">핸드폰</td>
								<td class="line_box" style="word-break:break-all" colspan="3"><%=FI_phone1%>-<%=FI_phone2%>-<%=FI_phone3%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">E-Mail</td>
								<td class="line_box" style="word-break:break-all" colspan="3"><%=FI_email%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">사용희망일</td>
								<td class="line_box" style="word-break:break-all" colspan="3"><%=FI_rSdate%> ~ <%=FI_rEdate%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">사용일</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="text" class="input" id="cSdate" name="cSdate" readonly value="<%=FI_cSdate%>" style="width:75px;"> 
									<img src="../img/center_icon_carender.gif" onclick="callCalendar(AdminForm.cSdate);"> - 
									<input type="text" class="input" id="cEdate" name="cEdate" readonly value="<%=FI_cEdate%>" style="width:75px;"> 
									<img src="../img/center_icon_carender.gif" onclick="callCalendar(AdminForm.cEdate);"> 
								</td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">사용인원</td>
								<td class="line_box" style="word-break:break-all" colspan="3"><%=FI_rCnt%>명</td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100" style="border-bottom:0px;">사용희망좌석</td>
								<td class="line_box" style="word-break:break-all;border-bottom:0px;" colspan="3">
									<select id="rArea" name="rArea" style="width:98px;">
										<option value="">선택</option>
										<option value="1" <%=IIF(FI_rArea="1","selected","")%>>회의실</option>
										<option value="2" <%=IIF(FI_rArea="2","selected","")%>>연구실</option>
									</select>
								</td>
							</tr>
						</table>

						<table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;" id="block_area">
						</table>

						<table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;border:0px;">
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100" style="border-top:0px;">사용목적</td>
								<td class="line_box" style="word-break:break-all;border-top:0px" colspan="3"><%=TagEncode(FI_Other1)%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">가타요구사항</td>
								<td class="line_box" style="word-break:break-all" colspan="3"><%=TagEncode(FI_Other2)%></td>
							</tr>
							<tr>
								<td class="line_box" bgcolor="f0f0f0" width="100">진행상황</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<select id="state" name="state">
										<option value="">선택</option>
										<option value="0" <%=IIF(FI_state="0","selected","")%>>예약완료</option>
										<option value="1" <%=IIF(FI_state="1","selected","")%>>신청</option>
										<option value="2" <%=IIF(FI_state="2","selected","")%>>본인취소</option>
										<option value="3" <%=IIF(FI_state="3","selected","")%>>대리취소</option>
									</select>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_save.gif">
						<img src="../img/center_btn_list.gif" onclick="location.href='dev_Reserve_01_L.asp?<%=pageParam%>'" style="cursor:pointer">
					</td>
				</tr>
			</table>
			</form>
		
		</td>
	</tr>
</table>

<SCRIPT type="text/javascript">

var area_code = '<%=fc_reserve_code_list("area","","")%>';

$parent_wrap  = $('#block_area');
$cSdate       = $('#cSdate');
$cEdate       = $('#cEdate');


function check(){
	var _cArea = $('select[name="cArea"]');
	var _check = 0;
	_cArea.each(function(){
		if( $(this).val() ){
			_check ++ ;
		}
	});

	if( ($('#state').val()=='0') && ( !$('#cSdate').val() || !$('#cEdate').val() ) ){
		alert('사용일을 입력해 주세요.');
		return false;
	}
	if( !$('#rArea').val() ){
		alert('사용희망좌석을 선택해 주세요.');
		return false;
	}
	if( $('#state').val()=='0' && _check <= 0 ){
		alert('좌석번호 선택해 주세요.');
		return false;
	}
	if( !$('#state').val() ){
		alert('진행상황 선택해 주세요.');
		return false;
	}
}




function createBlock1( value ){
	var _html = '' +
	'<tr>'+
		'<td class="line_box" bgcolor="f0f0f0" width="100">좌석번호</td>'+
		'<td class="line_box">'+
			'<select name="cArea" style="width:98px;">'+
			'</select>'+
			'<button type="button" class="btn_row_action btn_plus">+</button>'+
			'<button type="button" class="btn_row_action btn_minus">-</button>'+
		'</td>'+
	'</tr>';

	$parent_wrap.append(_html);
	var _block      = $parent_wrap.find('tr:last');
	var _btn_wrap   = _block.find('.btn_row_action');

	_btn_wrap.filter('.btn_plus').bind('click',function(){
		createBlock1();
	});
	_btn_wrap.filter('.btn_minus').bind('click',function(){
		deleteBlock( $parent_wrap , 'tr' , _block );
	});
	area_set( _block.find('select') , value );
}

function deleteBlock( parent , selecter , obj ){
	var _blocks = parent.find(selecter);
	if( _blocks.length <= 1 ){
		alert('모두 삭제할수 없습니다.');
		return false;
	}
	obj.remove();
}

function area_set(obj,val){
	var tmp_arry = area_code.split('|_ARRY_|');
	var paramLi = '<option value="">선택</option>';

	if(tmp_arry.length > 0){
		for(var i=0 ; i < tmp_arry.length ; i++) {
			var o = tmp_arry[i].split('|_KEY_|');
			var k = o[0];
			var s = k == val ? 'selected' : '';
			
			paramLi += '<option value="' + k + '" '+s+'>';
			paramLi += o[1];
			paramLi += '</option>';
		}
		$(obj).html(paramLi);
	}
	$(obj).change(function(){
		if( !$cSdate.val() || !$cEdate.val() ){
			alert('사용일을 먼저 입력해주세요.');
			return false;
		}
		var _cArea = $('select[name="cArea"]');
		var _check = 0;
		var _val   = $(this).val();
		if( !_val ){return false;}

		_cArea.each(function(){
			if( _val == $(this).val() ){
				_check ++;
			}
		});
		if( _check > 1 ){
			alert('이미 선택한 좌석번호 입니다.');
			$(this).val('');
			return false;
		}
		ajax_check( $(this) )
	});
}

function ajax_check(obj){
	var _val = $(obj).val();
	var _sDate = $cSdate.val();
	var _eDate = $cEdate.val();

	$.ajax({
		type: "POST",
		dataType: "text",
		url: "ajax.area_check.asp",
		data: {
			ridx  : <%=idx%> ,
			aidx  : _val ,
			sDate : _sDate ,
			sEate : _eDate
		} ,
		success: function(text){
			if(text > 0 ){
				alert('이미 예약된 좌석번호 입니다.');
				$(obj).val('');
			}
		},error:function(err){
			alert('ERR [502] : 고객센터에 문의하세요.' + err.responseText);
		}
	});
}


<%for iLoop = 0 to cntList%>
createBlock1('<%=arrList(AREA_aIdx,iLoop)%>');
<%next%>
createBlock1('');
</SCRIPT>

<!-- #include file = "../inc/bottom.asp" -->