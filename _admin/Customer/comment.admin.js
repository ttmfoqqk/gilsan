$comment_input  = $('#comment_input');
$comment_submit = $('#comment_submit');
$comment_list   = $('#comment_list');
$comment_page   = $('#comment_page');

$boardKey       = $('#boardKey').val();
$contIdx        = $('#Idx').val();

$pageNo = 1;
$rows   = 20;

$comment_submit.bind('click',function(){
	insertComent();
});

function getComentList( page ){
	var pageNo = !page ? 1 : page;
	var param  = 'pageNo='+pageNo+'&rows='+$rows+'&boardKey='+$boardKey+'&contIdx='+$contIdx;
	var url    = 'ajax.comment.list.asp';

	$.ajax({
		type    : 'GET',
		url     : url,
		data    : param,
		dataType: 'xml',
		cache: false,
		scriptCharset:'utf-8',
		success: function(xml){
			var $xml  = $(xml);
			var $item = $xml.find('item');
			var $cnt  = $xml.find('cnt').text();
			var $page = $xml.find('page').text();
			var html  = '';

			$pageNo   = pageNo;
		
			$item.each(function(index){
				var idx      = $(this).find('idx').text();
				var key      = $(this).find('key').text();
				var contIdx  = $(this).find('contIdx').text();
				var id       = $(this).find('id').text();
				var contants = $(this).find('contants').text();
				var btnFg    = $(this).find('btnFg').text();
				var inDate   = $(this).find('inDate').text();
				
				var btn_html = '';
				if( btnFg == '0' ){
					btn_html = '<a href="#" onclick="deleteComent('+idx+');return false;">����</a>';
				}else{
					btn_html = '<a href="#" onclick="updateComent('+idx+');return false;">����</a> / <a href="#" onclick="deleteComent('+idx+');return false;">����</a>';
				}

				html += '' +
				'<tr>' +
					'<td style="width:120px;padding-left:15px;">' + id + '</td>' +
					'<td><div id="comment'+idx+'" style="position:relative;top:0px;left:0px;z-index:'+($item.length-index)+';">' + contants + '</div><div style="color:#85868a;text-align:right;">' + btn_html + ' ['+inDate+']</div></td>' +
				'</tr>';
			});

			if( $item.length < 1 ){
				html  = '<tr><td align="center">��ϵ� ����� �����ϴ�.</td></tr>';
				$page = '';
			}

			$comment_list.find('tr').remove();
			$comment_list.html( html );
			$comment_page.html( $page );
		},error:function(err){
			//alert(err.responseText)
			$comment_list.find('.tr').remove();
			$comment_list.html( '<tr><td align="center">[err] ����Ŀ� �ٽ� �õ��� �ּ���.</td></tr>' );
			$comment_page.html('');
		}
	});
}

function insertComent(){
	var url    = 'ajax.comment.proc.asp';
	if( $comment_input.val().length < 1 ){
		alert('������ �Է����ּ���.');
		return false;
	}

	$comment_submit.unbind().text('������..');
	$.ajax({
		type    : 'POST',
		url     : url,
		data    : {
			 'BoardKey' : $boardKey
			,'contIdx'  : $contIdx
			,'actType'  : 'INSERT'
			,'comment'  : $comment_input.val()
		},
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			if( text == 'session' ){
				alert('�α��� ������ ����Ǿ����ϴ�.');
				document.location.reload();
			}else if( text == 'noparam' ){
				alert('�߸��� ��� �Դϴ�.');
				document.location.reload();
			}else if( text == 'nodata' ){
				alert('������ �Է����ּ���.');
			}else if( text == 'ok' ){
				getComentList(1);
				$comment_input.val('');
			}else{
				alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
			}

			$comment_submit.text('����').bind('click',function(){
				insertComent();
			});
		},error:function(err){
			alert(err.responseText)
			alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
			$comment_submit.text('����').bind('click',function(){
				insertComent();
			});
		}
	});
}
function updateComent(idx){
	$('#updateCommentWrap').remove();

	var obj   = $('#comment'+idx);
	var width = $comment_list.width();
	var text  = obj.html();


	var html = '' +
		'<div style="width:'+width+'px;" id="updateCommentWrap">'+
			'<textarea id="comment_input_update" class="input" style="width:660px;height:53px;line-height:120%;vertical-align:top;">'+text.replace(/<br>/gi, "\r\n")+'</textarea>&nbsp;' +
			'<button id="comment_submit_update" class="btn" style="width:100px;height:54px;background-color:#999999;">����</button>' + 
			'<div style="text-align:right;margin-right:10px;"><a href="#" onclick="$(\'#updateCommentWrap\').remove();return false;">[�ݱ�]</a><div>'
		'</div>';
	obj.append(html);

	$comment_input_update  = $('#comment_input_update');
	$comment_submit_update = $('#comment_submit_update');

	$comment_submit_update.bind('click',function(){
		ajax_updateComent(idx);
	});
}

function ajax_updateComent(idx){
	var url    = 'ajax.comment.proc.asp';
	if( $comment_input_update.val().length < 1 ){
		alert('������ �Է����ּ���.');
		return false;
	}

	$comment_submit_update.unbind().text('������..');
	$.ajax({
		type    : 'POST',
		url     : url,
		data    : {
			 'BoardKey' : $boardKey
			,'contIdx'  : $contIdx
			,'actType'  : 'UPDATE'
			,'Idx'      : idx
			,'comment'  : $comment_input_update.val()
		},
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			if( text == 'session' ){
				alert('�α��� ������ ����Ǿ����ϴ�.');
				document.location.reload();
			}else if( text == 'noparam' ){
				alert('�߸��� ��� �Դϴ�.');
				document.location.reload();
			}else if( text == 'nodata' ){
				alert('������ �Է����ּ���.');
			}else if( text == 'ok' ){
				getComentList($pageNo);
			}else{
				alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
			}

			$comment_submit_update.text('����').bind('click',function(){
				insertComent();
			});
		},error:function(err){
			//alert(err.responseText)
			alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
			$comment_submit.text('����').bind('click',function(){
				ajax_updateComent(idx);
			});
		}
	});
}

function deleteComent(idx){
	if( !confirm('���� �Ͻðڽ��ϱ�?') ){
		return false;
	}
	var url    = 'ajax.comment.proc.asp';

	$.ajax({
		type    : 'POST',
		url     : url,
		data    : {
			 'BoardKey' : $boardKey
			,'contIdx'  : $contIdx
			,'Idx'      : idx
			,'actType'  : 'DELETE'
		},
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			if( text == 'session' ){
				alert('�α��� ������ ����Ǿ����ϴ�.');
				document.location.reload();
			}else if( text == 'noparam' ){
				alert('�߸��� ��� �Դϴ�.');
				document.location.reload();
			}else if( text == 'ok' ){
				getComentList($pageNo);
				$comment_input.val('');
			}else{
				alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
			}
		},error:function(err){
			alert(err.responseText)
			alert('[err] ����Ŀ� �ٽ� �õ��� �ּ���.');
		}
	});
}

getComentList($pageNo);

//'���',"���"<���>,//���,/*���*/,<%=���%>