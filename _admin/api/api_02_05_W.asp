<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrFunc
Dim cntFunc  : cntFunc  = -1

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )
Dim sname     : sname     = request("sname")
Dim cate1    : cate1    = request("cate1")
Dim cate2    : cate2    = request("cate2")
Dim cate3    : cate3    = request("cate3")
Dim cate4    : cate4    = request("cate4")
Dim usFg     : usFg     = request("usFg")

Dim mfIdx    : mfIdx    = request("mfIdx")
Dim modelIdx : modelIdx = request("modelIdx")
Dim inDate   : inDate   = request("inDate")
Dim outDate  : outDate  = request("outDate")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&sname=" & sname &_
		"&cate1=" & cate1 &_
		"&cate2=" & cate2 &_
		"&cate3=" & cate3 &_
		"&cate4=" & cate4 &_
		"&mfIdx=" & mfIdx &_
		"&modelIdx=" & modelIdx &_
		"&usFg=" & usFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

Call Expires()
Call dbopen()
	Call GetView()
Call dbclose()

Sub GetView()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_API_DEVICE_V"
		.Parameters("@Idx").value = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")

	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "Func")
	If Not(objRs.Eof or objRs.Bof) Then
		arrFunc  = objRs.GetRows()
		cntFunc  = UBound(arrFunc, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<script type="text/javascript">
$(function(){
	deviceCategoryOption(1,0,'#cate1','<%=FI_cate1%>');
	deviceCategoryOption(2,'<%=FI_cate1%>','#cate2','<%=FI_cate2%>');
	deviceCategoryOption(3,'<%=FI_cate2%>','#cate3','<%=FI_cate3%>');
	deviceCategoryOption(4,'<%=FI_cate3%>','#cate4','<%=FI_cate4%>');
	$('#cate1').change(function(){
		deviceCategoryOption(2,$(this).val(),'#cate2','<%=FI_cate2%>');
	});
	$('#cate2').change(function(){
		deviceCategoryOption(3,$(this).val(),'#cate3','<%=FI_cate3%>');
	});
	$('#cate3').change(function(){
		deviceCategoryOption(4,$(this).val(),'#cate4','<%=FI_cate3%>');
	})

	deviceCategoryOption(10,0,'#mfIdx','<%=FI_manufactureIdx%>');
	deviceCategoryOption(11,'<%=FI_manufactureIdx%>','#modelIdx','<%=FI_modelIdx%>');
	$('#mfIdx').change(function(){
		deviceCategoryOption(11,$(this).val(),'#modelIdx','<%=FI_modelIdx%>');
	})
});

function activeInput(t){

	if(t=='m' && $('.activeInput_item').length > 1){
		$('.activeInput_item').last().remove();
	}
	if(t=='p'){
		var html = '' +
		'<div class="activeInput_item" style="border-top:1px solid #000000;margin-top:10px;padding-top:10px;">' +
			'API명 : <input type="text" style="width:27%" name="arrayApiFunc" class="input" maxlength="200" value="">&nbsp;&nbsp;' +
			'API설명 : <input type="text" style="width:45%" name="arrayApiUrl" class="input" maxlength="200" value="">&nbsp;&nbsp;' +
			'<input type="button" class="btn" value="상세입력" onclick="apiDetailView($(this))">' +
			'<input type="hidden" name="arrayApiMethod" maxlength="200" value="">' +
			'<input type="hidden" name="arrayApiUrls" maxlength="200" value="">' +
			'<input type="hidden" name="arrayApiUrlParameter" maxlength="200" value="">' +
			'<textarea name="arrayApiDescription" style="width:0px;height:0px;display:none;"></textarea>' +
			'<textarea name="arrayApiParameter" style="width:0px;height:0px;display:none;"></textarea>' +
			'<textarea name="arrayApiHeader" style="width:0px;height:0px;display:none;"></textarea>' +
			'<textarea name="arrayApiBody" style="width:0px;height:0px;display:none;"></textarea>' +
		'</div>' ;

		$('#activeInputArea').append(html);
	}
}

function apiDetailView(obj){
	var $btn = obj;
	var $obj = $btn.parent('.activeInput_item');

	var $thisMethod = $obj.find('input[name=arrayApiMethod]');
	var $thisUrl = $obj.find('input[name=arrayApiUrls]');
	var $thisUrlParameter = $obj.find('input[name=arrayApiUrlParameter]');

	var $thisDescription = $obj.find('textarea[name=arrayApiDescription]');
	var $thisParameter = $obj.find('textarea[name=arrayApiParameter]');
	var $thisHeader = $obj.find('textarea[name=arrayApiHeader]');
	var $thisBody = $obj.find('textarea[name=arrayApiBody]');

	var html_txt = '' +
		
		'<div class="admin_popup" id="admin_popup">' +
			'<div class="top_area">' +
				'<div class="title">상세정보</div>' +
				'<div class="close"><a href="#">[닫기]</a></div>' +
			'</div>' +
			'<div class="cont">' +
				'<table cellpadding=0 cellspacing=0 width=100%>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">Method</td>'+
						'<td class="line_box"><input type="text" id="popMethod" name="popMethod" class="input" style="width:100%;" maxlength="200" value="'+$thisMethod.val()+'"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">URL</td>'+
						'<td class="line_box"><input type="text" id="popUrl" name="popUrl" class="input" style="width:100%;" maxlength="200" value="'+$thisUrl.val()+'"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">URL Parameter</td>'+
						'<td class="line_box"><input type="text" id="popUrlParameter" name="popUrlParameter" class="input" style="width:100%;" maxlength="200" value="'+$thisUrlParameter.val()+'"></td>'+
					'</tr>'+

					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">Header</td>'+
						'<td class="line_box"><textarea id="popDescription" name="popDescription" style="width:100%;height:80px;">'+$thisDescription.val()+'</textarea></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">Body Attribute</td>'+
						'<td class="line_box"><textarea id="popParameter" name="popParameter" style="width:100%;height:80px;">'+$thisParameter.val()+'</textarea></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">Body</td>'+
						'<td class="line_box"><textarea id="popHeader" name="popHeader" style="width:100%;height:80px;">'+$thisHeader.val()+'</textarea></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">예제</td>'+
						'<td class="line_box"><textarea id="popBody" name="popBody" style="width:100%;height:80px;">'+$thisBody.val()+'</textarea></td>'+
					'</tr>'+
				'</table>'+
			'</div>' +
			'<div class="btn_area"><input type="button" value=" 입력 " class="btn insert"> <input type="button" value=" 닫기 " class="btn" onclick="layerPopupClose(\'wall\',\'admin_popup\');"></div>' +
		'</div>';
		

	$('body').append(html_txt);
	layerPopupOpen('wall',10,'admin_popup',20);
	
	var $admin_popup = $('#admin_popup');

	var $popMethod = $('#popMethod');
	var $popUrl = $('#popUrl');
	var $popUrlParameter = $('#popUrlParameter');

	var $popDescription = $('#popDescription');
	var $popParameter = $('#popParameter');
	var $popHeader = $('#popHeader');
	var $popBody = $('#popBody');
	
	$admin_popup.find('.close a').click(function(e){
		e.preventDefault();
		layerPopupClose('wall','admin_popup');
	});

	$admin_popup.find('.insert').click(function(e){
		/*
		if( !trim($popMethod.val()) ){
			alert('Method를 입력해주세요.');
			return false;
		}
		if( !trim($popUrl.val()) ){
			alert('URL을 입력해주세요.');
			return false;
		}
		if( !trim($popUrlParameter.val()) ){
			alert('URL Parameter를 입력해주세요.');
			return false;
		}
		if( !trim($popDescription.val()) ){
			alert('Header를 입력해주세요.');
			return false;
		}
		if( !trim($popParameter.val()) ){
			alert('Body Attribute를 입력해주세요.');
			return false;
		}
		if( !trim($popHeader.val()) ){
			alert('Body를 입력해주세요.');
			return false;
		}
		if( !trim($popBody.val()) ){
			alert('예제를 입력해주세요.');
			return false;
		}
		*/
		$thisMethod.val( $popMethod.val() );
		$thisUrl.val( $popUrl.val() );
		$thisUrlParameter.val( $popUrlParameter.val() );
		$thisDescription.val( $popDescription.val() );
		$thisParameter.val( $popParameter.val() );
		$thisHeader.val( $popHeader.val() );
		$thisBody.val( $popBody.val() );

		layerPopupClose('wall','admin_popup');
	});
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 디바이스 API 분류4 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form name="AdminForm" method="POST" action="api_02_05_P.asp" enctype="multipart/form-data" onsubmit="return submitContents();">
				<input type="hidden" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="idx" value="<%=FI_idx%>">
				<input type="hidden" name="sname" value="<%=sname%>">
				<input type="hidden" name="scate1" value="<%=cate1%>">
				<input type="hidden" name="scate2" value="<%=cate2%>">
				<input type="hidden" name="scate3" value="<%=cate3%>">
				<input type="hidden" name="scate4" value="<%=cate4%>">
				<input type="hidden" name="susFg" value="<%=usFg%>">
				<input type="hidden" name="smfIdx" value="<%=mfIdx%>">
				<input type="hidden" name="smodelIdx" value="<%=modelIdx%>">
				<input type="hidden" name="sinDate" value="<%=inDate%>">
				<input type="hidden" name="soutDate" value="<%=outDate%>">

				<input type="hidden" name="oldFileName" value="<%=FI_file%>">
				<input type="hidden" name="ApiUrl" value="">
				<input type="hidden" name="ApiFunc" value="">
				<input type="hidden" name="ApiMethod" value="">
				<input type="hidden" name="ApiUrls" value="">
				<input type="hidden" name="ApiUrlParameter" value="">

				<textarea name="ApiDescription" style="width:0px;height:0px;display:none;"></textarea>
				<textarea name="Apiparameter" style="width:0px;height:0px;display:none;"></textarea>
				<textarea name="Apiheader" style="width:0px;height:0px;display:none;"></textarea>
				<textarea name="Apibody" style="width:0px;height:0px;display:none;"></textarea>

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<select id="cate1" name="cate1" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate2" name="cate2" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate3" name="cate3" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="cate4" name="cate4" style="width:145px;">
										<option value="">선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제조사/모델</td>
								<td class="line_box">

									<select id="mfIdx" name="mfIdx" style="width:145px;">
										<option value="">선택</option>
									</select>

									<select id="modelIdx" name="modelIdx" style="width:145px;">
										<option value="">선택</option>
									</select>

								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">디바이스명</td>
								<td class="line_box"><input type="text" style="width:20%" id="dname" name="dname" class="input" value="<%= TagDecode( FI_name )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">설명</td>
								<td class="line_box">
									<textarea name="contants" id="contants" style="width:100%;height:300px;display:none;"><%=TagEncode(FI_description)%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">태그</td>
								<td class="line_box"><input type="text" style="width:100%" id="tag" name="tag" class="input" value="<%= TagDecode( FI_tag )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">지원기능 및 API</td>
								<td class="line_box">
									<div style="margin:0;padding:0">

										<div id="activeInputArea">
										<% For iLoop = 0 to cntFunc %>
											<div class="activeInput_item" style="<%If iLoop > 0 Then %>border-top:1px solid #000000;margin-top:10px;padding-top:10px;<%End If%>">
												API명 : <input type="text" style="width:27%" name="arrayApiFunc" class="input" maxlength="200" value="<%=arrFunc(Func_function,iLoop)%>">&nbsp;&nbsp;API설명 : <input type="text" style="width:45%" name="arrayApiUrl" class="input" maxlength="200" value="<%=arrFunc(Func_api,iLoop)%>">&nbsp;&nbsp;<input type="button" class="btn" value="상세입력" onclick="apiDetailView($(this))">
												<input type="hidden" name="arrayApiMethod" maxlength="200" value="<%=arrFunc(Func_method,iLoop)%>">
												<input type="hidden" name="arrayApiUrls" maxlength="200" value="<%=arrFunc(Func_url,iLoop)%>">
												<input type="hidden" name="arrayApiUrlParameter" maxlength="200" value="<%=arrFunc(Func_urlParameter,iLoop)%>">
												<textarea name="arrayApiDescription" style="width:0px;height:0px;display:none;"><%=TagDecode( arrFunc(Func_description,iLoop) )%></textarea>
												<textarea name="arrayApiParameter" style="width:0px;height:0px;display:none;"><%=TagDecode( arrFunc(Func_parameter,iLoop) )%></textarea>
												<textarea name="arrayApiHeader" style="width:0px;height:0px;display:none;"><%=TagDecode( arrFunc(Func_header,iLoop) )%></textarea>
												<textarea name="arrayApiBody" style="width:0px;height:0px;display:none;"><%=TagDecode( arrFunc(Func_body,iLoop) )%></textarea>
											</div>
										<%Next%>
										<%if cntFunc < 0 then%>
											<div class="activeInput_item">
												API명 : <input type="text" style="width:27%" name="arrayApiFunc" class="input" maxlength="200" value="">&nbsp;&nbsp;API설명 : <input type="text" style="width:45%" name="arrayApiUrl" class="input" maxlength="200" value="">&nbsp;&nbsp;<input type="button" class="btn" value="상세입력" onclick="apiDetailView($(this))">
												
												<input type="hidden" name="arrayApiMethod" maxlength="200" value="">
												<input type="hidden" name="arrayApiUrls" maxlength="200" value="">
												<input type="hidden" name="arrayApiUrlParameter" maxlength="200" value="">
												<textarea name="arrayApiDescription" style="width:0px;height:0px;display:none;"></textarea>
												<textarea name="arrayApiParameter" style="width:0px;height:0px;display:none;"></textarea>
												<textarea name="arrayApiHeader" style="width:0px;height:0px;display:none;"></textarea>
												<textarea name="arrayApiBody" style="width:0px;height:0px;display:none;"></textarea>
											</div>
										<%End If%>
										<!--div style="margin-top:3px;padding:0px;">
											<div style="background-color:#d7d7d7;padding:2px;width:125px;"><b>지원기능</b></div>
											<div style="margin-top:3px;"><input type="text" style="width:100%;" name="arrayApiFunc" class="input" maxlength="200"></div>
										</div>
										<div style="margin-top:3px;padding:0px;">
											<div style="background-color:#d7d7d7;padding:2px;width:125px;"><b>API</b></div>
											<div style="margin-top:3px;"><input type="text" style="width:100%" name="arrayApiUrl" class="input" maxlength="200"></div>
										</div-->
										</div>

										<div style="text-align:right;margin-top:5px;">
											<a href="javascript:activeInput('p')"><img src="../../img/btn_plus_input.gif"></a>
											<a href="javascript:activeInput('m')"><img src="../../img/btn_minus_input.gif"></a>
										</div>

									</div>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이미지</td>
								<td class="line_box">
									<input type="file" name="FileName" class="input">
									<%If FI_file <>"" Then %>
									<br><a href="/common/download.asp?pach=/upload/api&file=<%=FI_file%>"><%=FI_file%></a>
									<input type="checkbox" value="1" name="DellFileFg"> 기존이미지 삭제
									<%End If%>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select id="usFg" name="usFg">
										<option value="0" <%=IIF( FI_usFg = "0" , "selected" , "" )%>>사용</option>
										<option value="1" <%=IIF( FI_usFg = "1" , "selected" , "" )%>>미사용</option>
									</select>
								</td>
							</tr>

						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2 class="btnArea">
						<input type="image" src="../img/center_btn_write_ok.gif">
						<a href="api_02_05_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>

</table>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contants",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function submitContents() {
	var form=document.AdminForm;
	/*
	if( !trim( $('#cate1').val() ) ){
		alert('[분류1] 를 선택해주세요.');
		return false;
	}
	if( !trim( $('#cate2').val() ) ){
		alert('[분류2] 를 선택해주세요.');
		return false;
	}
	if( !trim( $('#cate3').val() ) ){
		alert('[분류3] 를 선택해주세요.');
		return false;
	}
	if( !trim( $('#dname').val() ) ){
		alert('분류명을 선택해주세요.');
		return false;
	}
	*/

	var checkArray1 = 0;
	var checkArray2 = 0;
	for(i=0;i< $('input[name=arrayApiUrl]').length; i++){
		if( !trim($('input[name=arrayApiUrl]').eq(i).val()) ){
			checkArray1 ++;
		}else{
			if( !trim($('input[name=arrayApiFunc]').eq(i).val()) ){
				alert('지원기능 및 API를 입력해주세요.');return false;
			}
		}
		if( !trim($('input[name=arrayApiFunc]').eq(i).val()) ){
			checkArray2 ++;
		}else{
			if( !trim($('input[name=arrayApiUrl]').eq(i).val()) ){
				alert('지원기능 및 API를 입력해주세요.');return false;
			}
		}
		if( checkArray1 >= $('input[name=arrayApiUrl]').length || checkArray2 >= $('input[name=arrayApiUrl]').length ){
			alert('지원기능 및 API를 입력해주세요.');return false;
		}
	}

	$('input[name=ApiUrl]').val('');
	$('input[name=ApiFunc]').val('');
	$('input[name=ApiMethod]').val('');
	$('input[name=ApiUrls]').val('');
	$('input[name=ApiUrlParameter]').val('');

	$('textarea[name=ApiDescription]').val('');
	$('textarea[name=Apiparameter]').val('');
	$('textarea[name=Apiheader]').val('');
	$('textarea[name=Apibody]').val('');

	$('input[name=arrayApiUrl]').each(function(index,elem){
		if($(elem).val()){
			$('input[name=ApiUrl]').val( $('input[name=ApiUrl]').val() + $(elem).val() + '|SPWEB|' );
			$('input[name=ApiFunc]').val( $('input[name=ApiFunc]').val() + $('input[name=arrayApiFunc]').eq(index).val() + '|SPWEB|' );
			$('input[name=ApiMethod]').val( $('input[name=ApiMethod]').val() + $('input[name=arrayApiMethod]').eq(index).val() + '|SPWEB|' );
			$('input[name=ApiUrls]').val( $('input[name=ApiUrls]').val() + $('input[name=arrayApiUrls]').eq(index).val() + '|SPWEB|' );
			$('input[name=ApiUrlParameter]').val( $('input[name=ApiUrlParameter]').val() + $('input[name=arrayApiUrlParameter]').eq(index).val() + '|SPWEB|' );

			$('textarea[name=ApiDescription]').val( $('textarea[name=ApiDescription]').val() + $('textarea[name=arrayApiDescription]').eq(index).val() + '|SPWEB|' );
			$('textarea[name=Apiparameter]').val( $('textarea[name=Apiparameter]').val() + $('textarea[name=arrayApiParameter]').eq(index).val() + '|SPWEB|' );
			$('textarea[name=Apiheader]').val( $('textarea[name=Apiheader]').val() + $('textarea[name=arrayApiHeader]').eq(index).val() + '|SPWEB|' );
			$('textarea[name=Apibody]').val( $('textarea[name=Apibody]').val() + $('textarea[name=arrayApiBody]').eq(index).val() + '|SPWEB|' );
		}
	})
	$('input[name=ApiUrl]').val( $('input[name=ApiUrl]').val().substr(0,$('input[name=ApiUrl]').val().length-7) );
	$('input[name=ApiFunc]').val( $('input[name=ApiFunc]').val().substr(0,$('input[name=ApiFunc]').val().length-7) );
	$('input[name=ApiMethod]').val( $('input[name=ApiMethod]').val().substr(0,$('input[name=ApiMethod]').val().length-7) );
	$('input[name=ApiUrls]').val( $('input[name=ApiUrls]').val().substr(0,$('input[name=ApiUrls]').val().length-7) );
	$('input[name=ApiUrlParameter]').val( $('input[name=ApiUrlParameter]').val().substr(0,$('input[name=ApiUrlParameter]').val().length-7) );
	$('textarea[name=ApiDescription]').val( $('textarea[name=ApiDescription]').val().substr(0,$('textarea[name=ApiDescription]').val().length-7) );
	$('textarea[name=Apiparameter]').val( $('textarea[name=Apiparameter]').val().substr(0,$('textarea[name=Apiparameter]').val().length-7) );
	$('textarea[name=Apiheader]').val( $('textarea[name=Apiheader]').val().substr(0,$('textarea[name=Apiheader]').val().length-7) );
	$('textarea[name=Apibody]').val( $('textarea[name=Apibody]').val().substr(0,$('textarea[name=Apibody]').val().length-7) );

	$('.btnArea').html("처리중입니다.");
	oEditors.getById["contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	//document.getElementById("content").value
	try {
		//form.submit();
	} catch(e) {}
}

</script>
<!-- #include file = "../inc/bottom.asp" -->