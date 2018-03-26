<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
%>
<script type="text/javascript">
$(document).ready( function() {
	getCodelist(1,0)
} );
function openPop(mode,CodeNum,Idx){
	var html_btn_write = '<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" value="'+mode+'">';
	var html_btn_dell = ' <img src="../img/center_btn_delete.gif" style="cursor:pointer;" value="DELETE">';
	var html_btn_area = html_btn_write;
	if(mode == 'UPDATE'){
		html_btn_area += html_btn_dell;
	}
	var html_txt = '' +
		'<div class="admin_popup" id="admin_popup">' +
			'<div class="top_area">' +
				'<div class="title"><img src="../img/pop/title_common_code.gif"></div>' +
				'<div class="close"><a href="#">[�ݱ�]</a></div>' +
			'</div>' +
			'<div class="cont">' +
				'<table cellpadding=0 cellspacing=0 width=100%>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">����</td>'+
						'<td class="line_box"><input type="text" id="code_ord" name="code_ord" class="input" size=7 maxlength=7 onkeyup=onlyNumber(this)></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">����</td>'+
						'<td class="line_box"><input type="text" id="code_name" name="code_name" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">��뿩��</td>'+
						'<td class="line_box"><input type="radio" name="code_usfg" value=0 checked>��� <input type="radio" name="code_usfg" value=1> �̻��</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">���</td>'+
						'<td class="line_box"><textarea id="code_bigo" name="code_bigo" style="width:100%;height:80px;"></textarea></td>'+
					'</tr>'+
				'</table>'+
			'</div>' +
			'<div class="btn_area pop_btn">' + html_btn_area + '</div>' +
		'</div>';
	
	if(mode == 'UPDATE'){
		pop_loading()
		$.ajax({
			type: "POST",
			dataType: "xml",
			url: "ADMIN_03_V.asp",
			data: {
				CodeNum   : CodeNum ,
				Idx       : CodeNum == 1 ? Idx : $('#code2').attr('value') ,
				code2_Idx : Idx
			} ,
			success: function(xml){
				$('body').append(html_txt);

				var admin_login = $(xml).find("admin_login").text();
				if(admin_login=='login'){
					alert('�α��� ���� ����!');location.reload();return false;
				}
				if ($(xml).find("data").find("item").length > 0) {
					$(xml).find("data").find("item").each(function(idx) {
						var code_idx   = $(this).find("code_idx").text();
						var code_name  = $(this).find("code_name").text();
						var code_order = $(this).find("code_order").text();
						var code_bigo  = $(this).find("code_bigo").text();
						var code_usfg  = $(this).find("code_usfg").text();

						$('#code_ord').val( code_order );
						$("#code_name").val( code_name );
						$('input[name=code_usfg]').filter("input[value="+code_usfg+"]").attr("checked", "checked");
						$('#code_bigo').val( code_bigo );
					});
				}
				$('#admin_popup .close a').click(function(e){
					e.preventDefault();
					layerPopupClose('wall','admin_popup');
				});
				$('.pop_btn img').click(function(e){
					e.preventDefault();
					goAction( $(this).attr('value') , CodeNum , Idx )
				});
				layerPopupOpen('wall',10,'admin_popup',20);
				layerPopupClose('wall_loading','pop_loading');

			},error:function(err){
				alert('ERR [502] : �����Ϳ� �����ϼ���.' + err.responseText);
				layerPopupClose('wall_loading','pop_loading');
			}
		});
	}else{
		$('body').append(html_txt);
		$('#admin_popup .close a').click(function(e){
			e.preventDefault();
			layerPopupClose('wall','admin_popup');
		});
		$('.pop_btn img').click(function(e){
			e.preventDefault();
			goAction( $(this).attr('value') , CodeNum , Idx )
		});
		layerPopupOpen('wall',10,'admin_popup',20);		
	}
	
}

function goAction( actType , CodeNum , Idx ){
	if(actType == 'DELETE'){
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			
		}else{
			return false;
		}
	}
	$('.pop_btn').html('ó�����Դϴ�.');
	var html_btn_write = '<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" value="'+actType+'">';
	var html_btn_dell = ' <img src="../img/center_btn_delete.gif" style="cursor:pointer;" value="DELETE">';
	var html_btn_area = html_btn_write;
	if(actType == 'UPDATE'){
		html_btn_area += html_btn_dell;
	}

	$.ajax({
		type: "POST",
		url: "ADMIN_03_P.asp",
		data: {
			actType : actType ,
			CodeNum : CodeNum ,
			Name    : $('#code_name').val() ,
			Ord     : $('#code_ord').val() ,
			Idx     : Idx ,
			UsFg    : $(':radio[name="code_usfg"]:checked').val() ,
			Bigo    : $('#code_bigo').val()
		} ,
		success: function(msg){
			if(msg == 'login'){
				alert('�α��� ������ ����Ǿ����ϴ�.');
				location.reload();
			}else if(msg == 'success'){
				alert('����ó�� �Ǿ����ϴ�');
				layerPopupClose('wall','admin_popup');
				getCodelist(CodeNum, CodeNum == 1 ? Idx : $('#code2').attr('value') )
			}else{
				alert('������ ó�� ����');
				layerPopupClose('wall','admin_popup');
			}
		},error:function(err){
			alert('ERR [502] : �����Ϳ� �����ϼ���.' + err.responseText);
		}
	});
}

function getCodelist(CodeNum,Idx){
	var tmp_idx = CodeNum == 1 ? '' : Idx;
	$('#code2').attr({ "value":CodeNum == 2 ? Idx : $('#code2').attr('value') });
	$('#code'+CodeNum).html('<ul><li style="width:100%;">������ �ε����Դϴ�.</li></ul>');
	$.ajax({
		type: "POST",
		dataType: "xml",
		url: "ADMIN_03_V.asp",
		data: {
			CodeNum : CodeNum ,
			Idx     : tmp_idx
		} ,
		success: function(xml){
			var tmp_html = '';
			var tmp_style= CodeNum == 1 ? 'cursor:pointer;' : '';

			if ($(xml).find("data").find("item").length > 0) {
				$(xml).find("data").find("item").each(function(idx) {
					var code_idx   = $(this).find("code_idx").text();
					var code_name  = $(this).find("code_name").text();
					var code_order = $(this).find("code_order").text();
					var code_bigo  = $(this).find("code_bigo").text();
					var code_usfg  = $(this).find("code_usfg").text();
					var usfg_txt   = code_usfg == 0 ? '���' : '�̻��';
					var tmp_click= CodeNum == 1 ? 'getCodelist(2,' + code_idx + ')' : '';

					tmp_html += '<ul>' +
						'<li style="width:29px;"><input type="checkbox" name="codecheck" style="margin-top:3px" value="'+code_idx+'"></li>' +
						'<li style="width:50px;'+tmp_style+'" onclick="'+tmp_click+'">'+code_order+'</li>' +
						'<li style="width:89px;'+tmp_style+'" onclick="'+tmp_click+'">'+code_name+'</li>' +
						'<li style="width:50px;'+tmp_style+'" onclick="'+tmp_click+'">'+usfg_txt+'</li>' +
						'<li style="width:50px;"><img src="../img/center_btn_edite_Code.gif" style="margin-top:3px;cursor:pointer;" onclick="openPop(\'UPDATE\',\''+CodeNum+'\',\''+code_idx+'\')"></li>' +
					'</ul>';
				});
			}
			if(!tmp_html){
				tmp_html = '<ul><li style="width:100%;">��ϵ� ������ �����ϴ�.</li></ul>';
			}
			$('#code'+CodeNum).html(tmp_html);
		},error:function(err){
			alert('ERR [502] : �����Ϳ� �����ϼ���.' + err.responseText);
		}
	});
}

function go_delete(CodeNum){
	if( $( "#code"+CodeNum+" :checkbox[name='codecheck']:checked").length==0 ){
		alert("������ �׸��� �ϳ��̻� üũ���ּ���.");
		return;
	}
	if(!confirm("���� �Ͻðڽ��ϱ�?")){
		return false;
	}

	var chked_val = "";
	$( "#code"+CodeNum+" :checkbox[name='codecheck']:checked").each(function(pi,po){
		chked_val += ","+po.value;
	});
	if(chked_val!="")chked_val = chked_val.substring(1);

	$.ajax({
		type: "POST",
		url: "ADMIN_03_P.asp",
		data: {
			actType   : "DELETE" ,
			CodeNum   : CodeNum ,
			Idx       : chked_val ,
			code2_Idx : chked_val
		} ,
		success: function(msg){
			if(msg == 'login'){
				alert('�α��� ������ ����Ǿ����ϴ�.');
				location.reload();
			}else if(msg == 'success'){
				alert('����ó�� �Ǿ����ϴ�');
				getCodelist(CodeNum, CodeNum == 1 ? 0 : $('#code2').attr('value') );
				CodeNum == 1 ? getCodelist( 2 , 0 ) : '' ;
			}else{
				alert('������ ó�� ����');
			}
		},error:function(err){
			alert('ERR [502] : �����Ϳ� �����ϼ���.' + err.responseText);
		}
	});
}


</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>

		<form name="AdminForm" method="post" action="Admin_02_P.asp">
		
			<table cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_01_03.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > �����ڵ�</td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_01_03.gif"></td>
				</tr>
				<tr>
					<td colspan=2>

						<table cellpadding=0 cellspacing=0 width="770" >
							<tr>
								<td width="360">
									<div class="center_code_area">
										<div class="title">�� ��з�</div>
										<div class="box_scroll">
											<ul>
												<li style="width:29px;background-color:#f0f0f0;">&nbsp;</li>
												<li style="width:50px;background-color:#f0f0f0;">����</li>
												<li style="width:89px;background-color:#f0f0f0;">����</li>
												<li style="width:50px;background-color:#f0f0f0;">��뿩��</li>
												<li style="width:50px;background-color:#f0f0f0;">����</li>
											</ul>
											<div id="code1">
												<ul>
													<li style="width:100%;">������ �ε����Դϴ�.</li>
												</ul>
											</div>
										</div>
										<div class="btn_area">
											<img src="../img/center_btn_write_Code.gif" style="cursor:pointer" onclick="openPop('INSERT',1,0)">
											<img src="../img/center_btn_dell_Code.gif" style="cursor:pointer" onclick="go_delete(1)">
										</div>
									</div>
								</td>
								<td width="50" align=center><img src="../img/center_icon_code_arrow.gif"></td>
								<td width="360">
									<div class="center_code_area">
										<div class="title">�� �ߺз�</div>
										<div class="box_scroll">
											<ul>
												<li style="width:29px;background-color:#f0f0f0;">&nbsp;</li>
												<li style="width:50px;background-color:#f0f0f0;">����</li>
												<li style="width:89px;background-color:#f0f0f0;">����</li>
												<li style="width:50px;background-color:#f0f0f0;">��뿩��</li>
												<li style="width:50px;background-color:#f0f0f0;">����</li>
											</ul>
											<div id="code2" value="">
												<ul>
													<li style="width:100%;">��ϵ� ������ �����ϴ�.</li>
												</ul>
											</div>
										</div>
										<div class="btn_area">
											<img src="../img/center_btn_write_Code.gif" style="cursor:pointer" onclick="$('#code2').attr('value')==''?alert('��з��� �������ּ���.'):openPop( 'INSERT' , 2 , $('#code2').attr('value') );">
											<img src="../img/center_btn_dell_Code.gif" style="cursor:pointer" onclick="go_delete(2)">
										</div>
									</div>
								</td>
							</tr>							
						</table>

					</td>
				</tr>
			</table>
		
		</form>

		</td>
	</tr>
</table>

<!-- #include file = "../inc/bottom.asp" -->