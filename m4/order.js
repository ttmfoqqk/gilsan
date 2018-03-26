/* 주문작성 인풋 */
$orderCode   = $('#orderCode');
$companyCode = $('#companyCode');
$itemCode    = $('#itemCode');
$productCode = $('#productCode');
$thickCode   = $('#thickCode');
$widthCode   = $('#widthCode');
$length      = $('#length');
$qty         = $('#qty');
$duedate     = $('#duedate');
$unloadplace = $('#unloadplace');
$remark      = $('#remark');

/* 팝업창 */
$more_pop      = $('#more_pop');
$favorites_pop = $('#favorites_pop');
$wall          = $('.wall');
$loading       = $('#loading');
/* 팝업창 - 날짜검색 인풋 */
$more_indate       = $('#more_indate');
$more_outdate      = $('#more_outdate');

$hidden_length     = $('#hidden_length');
$hidden_length.hide();

$hidden_length.find('button').click(function(){
	$hidden_length.find('button').removeClass('reserve_btn_on');
	$(this).addClass('reserve_btn_on');
	$length.val( $(this).val() );
});

/* 길이/수량 숫자만 */
var reg_num = /^[0-9]{1,12}$/;
$length.keyup(function(){
	if( !$(this).val() ){
		return false;
	}
	var reg = reg_num;
	if( !reg.test( $(this).val() ) ){
		alert('숫자만 입력해주세요.');
		$(this).val('');
	}
});
$qty.keyup(function(){
	if( !$(this).val() ){
		return false;
	}
	var reg = reg_num;
	if( !reg.test( $(this).val() ) ){
		alert('숫자만 입력해주세요.');
		$(this).val('');
	}
});

/* 주문 FORM 체크 */
function check(){
	if( ! $companyCode.val() ){
		alert('판매처를 선택하세요.');
		return false;
	}
	if( ! $itemCode.val() ){
		alert('품목을 선택하세요.');
		return false;
	}
	if( ! $productCode.val() ){
		alert('품명을 선택하세요.');
		return false;
	}
	if( ! $thickCode.val() ){
		alert('두께를 선택하세요.');
		return false;
	}
	if( ! $widthCode.val() ){
		alert('호칭경을 선택하세요.');
		return false;
	}
	if( ! $length.val() ){
		alert('길이를 입력하세요.');
		return false;
	}
	if( ! $qty.val() ){
		alert('수량을 입력하세요.');
		return false;
	}
	if( $duedate.length > 0 && ! $duedate.val()  ){
		alert('희망납기일을 입력하세요.');
		return false;
	}
	/*
	if( $unloadplace.length > 0 && ! $unloadplace.val()  ){
		alert('하차장소를 입력하세요.');
		return false;
	}
	*/
	$('#submit_area').html('주문처리중 입니다.');
	//alert('준비중입니다.');
	//return false;
}


/* 최근 거래현황 열기 */
function loading_old_reserve(top){
	var pageNo = 1;

	$wall.height( $(document).height() ).css('z-index','1000').show();
	if(top){
		$more_pop.css('top',top+'px');
	}
	$more_pop.css('z-index','1100').show();
	getMyOrder('old');

	$more_indate.val('');
	$more_outdate.val('');
	$('#'+calendarDivId).hide();

}
/* 자주 사용하는 거래현황 열기 */
function loading_favorites(top){
	var pageNo = 1;

	$wall.height( $(document).height() ).css('z-index','1000').show();
	if(top){
		$favorites_pop.css('top',top+'px');
	}
	$favorites_pop.css('z-index','1100').show();

	getMyOrder('favorites');
	$('#'+calendarDivId).hide();
}
/* 팝업 닫기 */
function close_old_reserve(){
	$wall.hide();
	$favorites_pop.hide();
	$more_pop.hide();
	$loading.hide();
	$('#'+calendarDivId).hide();

	$more_indate.val('');
	$more_outdate.val('');
}

/* 팝업 내용 불러오기 */
function getMyOrder( actType , page ){
	var pageNo = !page ? 1 : page;
	var param  = 'pageNo='+pageNo;
	var url,obj;
	if( actType=='old' ){
		url    = 'ajax.order.asp';
		obj    = $more_pop;
		param += '&indate='+ $more_indate.val() +'&outdate=' + $more_outdate.val();
	}else if( actType=='favorites' ){
		url = 'ajax.favorites_list.asp';
		obj = $favorites_pop;
	}else{
		return false;
	}

	var colspan = obj.find('.reserve_table tr:first th').length;

	obj.find('.reserve_table tr.list').remove();
	obj.find('.reserve_table').append('<tr class="list"><td colspan="'+colspan+'">로딩중입니다.</td></tr>');
	obj.find('.page_wrap').html('');

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
			
			$item.each(function(index){
				var idx        = $(this).find('idx').text();/* favorites */
				var id         = $(this).find('id').text();
				var rownum     = $(this).find('rownum').text();
				var typename   = $(this).find('typename').text();
				var product    = $(this).find('product').text();
				var thick      = $(this).find('thick').text();
				var extdia     = $(this).find('extdia').text();
				var length     = $(this).find('length').text();
				var qty        = $(this).find('qty').text();
				var status     = $(this).find('status').text();
				var indatetime = $(this).find('indatetime').text();

				var companyCode = $(this).find('companyCode').text();
				var typeCode    = $(this).find('typeCode').text();
				var productCode = $(this).find('productCode').text();
				var key         = companyCode +'||'+ typeCode +'||'+ productCode +'||'+ thick + '||' + extdia + '||' + length + '||' + qty ;
				/*
				판매처 || 품목 || 품명[강종-표면-품명] || 두께 || 호칭경 || 길이 || 수량
				*/
				
				var btn_html = '';
				var status_html = '';


				if( actType=='old' ){
					btn_html    = '<td style="cursor:auto;"><button type="button" class="btn" onclick="setFavorites(\''+key+'\')">등록</button></td>';
					status_html = '<td onclick="action_myOrder(\''+key+'\')">' + status     + '</td>';

				}else if( actType=='favorites' ){
					btn_html    = '<td style="cursor:auto;"><button type="button" class="btn" onclick="deleteFavorites(\''+idx+'\')">삭제</button></td>';
					status_html = '';

				}

				html += '' +
				'<tr class="list">' +
					'<td onclick="action_myOrder(\''+key+'\')">' + rownum     + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + id     + '</td>' + 
					'<td onclick="action_myOrder(\''+key+'\')">' + typename   + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + product    + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + thick      + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + extdia     + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + length     + '</td>' +
					'<td onclick="action_myOrder(\''+key+'\')">' + qty        + '</td>' +
					status_html +
					'<td onclick="action_myOrder(\''+key+'\')">' + indatetime + '</td>' +
					btn_html +
				'</tr>';
			});

			var noTxt = '';
			if( $item.length < 1 ){
				if( actType=='favorites' ){
					noTxt = '최근 거래현황의 등록버튼을 클릭해주세요.';
				}

				html = '<tr class="list"><td colspan="'+colspan+'">등록된 내용이 없습니다. '+noTxt+'</td></tr>';
			}

			obj.find('.reserve_table tr.list').remove();
			obj.find('.reserve_table').append( html );
			obj.find('.page_wrap').html( $page );
		},error:function(err){
			//alert(err.responseText)
			obj.find('.reserve_table tr.list').remove();
			obj.find('.reserve_table').append( '<tr class="list"><td colspan="'+colspan+'">[err] 잠시후에 다시 시도해 주세요.</td></tr>' );
			obj.find('.page_wrap').html('');
		}
	});
}

/* 팝업 내용 주문서에 적용 */
$setOrderCnt   = 0;
$setOrderCheck = 5;
function action_myOrder( key ){
	$wall.css('z-index','1200');
	$loading.css({ 'z-index':'1300' , 'margin-left':'-'+($loading.width()/2)+'px' , 'margin-top':(( $(document).scrollTop()+$loading.height() )/2)+'px' }).show();
	
	/*
	판매처 || 품목 || 품명[강종-표면-품명] || 두께 || 호칭경 || 길이 || 수량
	*/
	var _arry = key.split('||');
	
	if( !$orderCode.val() ){
		$companyCode.val( _arry[0] );
	}	
	$itemCode.val( _arry[1] );
	$productCode.val( _arry[2] );
	$thickCode.val( _arry[3] );
	$widthCode.val( _arry[4] );

	$length.val( _arry[5] );
	$qty.val( _arry[6] );
	
	if( !$orderCode.val() ){
		getList( $('#company') , 'company', true );
	}else{
		$setOrderCheck = 4;
	}
	getList( $('#item')    , 'item'   , true );
	getList( $('#product') , 'product', true );
	getList( $('#thick')   , 'thick'  , true );
	getList( $('#width')   , 'width'  , true );

	return false;
}

/* 비동기 내용 불러오기 -> 버튼 생성 */
function getList( obj , actType , setFg ){
	var setFg = !setFg ? false : setFg;
	var param = 'actType='+actType;
	
	if( actType == 'item' ){
		obj.html('로딩중입니다..');
		param += '&companyCode='+encodeURIComponent($companyCode.val());
		
		if(!setFg){
			$('#product').html('품목을 선택해주세요.');
			$('#thick').html('품명을 선택해주세요.');
			$('#width').html('두께를 선택해주세요.');
			$itemCode.val('');
			$productCode.val('');
			$thickCode.val('');
			$widthCode.val('');
		}
	}else if( actType == 'product' ){
		obj.html('로딩중입니다..');
		param += '&typeCode='+encodeURIComponent($itemCode.val());
		
		if(!setFg){
			$('#thick').html('품명을 선택해주세요.');
			$('#width').html('두께를 선택해주세요.');		
			$productCode.val('');
			$thickCode.val('');
			$widthCode.val('');
		}
	}else if( actType=='thick' ){
		obj.html('로딩중입니다..');
		param += '&typeCode='+encodeURIComponent($itemCode.val())+'&productCode='+encodeURIComponent($productCode.val());
		if(!setFg){
			$('#width').html('두께를 선택해주세요.');
			$thickCode.val('');
			$widthCode.val('');
		}
	}else if( actType=='width' ){
		param += '&typeCode='+encodeURIComponent($itemCode.val())+'&productCode='+encodeURIComponent($productCode.val())+'&thickCode='+encodeURIComponent($thickCode.val());
		if(!setFg){
			$widthCode.val('');
		}
	}

	$.ajax({
		type    : 'GET',
		url     : 'ajax.list.asp',
		data    : param,
		dataType: 'xml',
		cache: false,
		scriptCharset:'utf-8',
		success: function(xml){
			var $xml  = $(xml);
			var $item = $xml.find('item');
			var $cnt  = $xml.find('cnt').text();
			var html  = '';
			var html1 = '';
			var html2 = '';
			var html3 = '<button type="button" class="reserve_more_btn">&nbsp;<span class="blind">더보기</span></button>';
			
			$item.each(function(index){
				var code = $(this).find('code').text();
				var name = $(this).find('name').text();
				
				if( index < 4 ){
					html1 += '<button type="button" class="reserve_btn" value="'+code+'">'+name+'</button>';
				}else{
					html2 += '<a href="#" value="'+code+'">'+name+'</a>';
				}
			});
			if( $cnt > 4 ){
				html = html1 + html3 + '<div class="reserve_more_wrap"><div class="item">' + html2 + '</div><div class="footer"><a href="#" onclick="action_reserve_close_btn( $(this) );return false;">닫기</a></div></div>';
			}else if($cnt == 0){
				html = '내용이 없습니다.';
			}else{
				html = html1;
			}
			obj.html( html );
			
			var reserve_more_wrap = obj.find('.reserve_more_wrap');
			if( reserve_more_wrap.height() > 300 ){
				reserve_more_wrap.find('.item').css('height','300px');
			}

			var more_link = reserve_more_wrap.find('.item a');
			var more_btn  = obj.find('.reserve_btn');
			var arrow_btn = obj.find('.reserve_more_btn');

			more_link.each(function(){
				$(this).bind('click',function(){
					action_more_item( $(this),actType );
					return false;
				});
			});

			more_btn.each(function(){
				$(this).bind('click',function(){
					action_reserve_btn( $(this) , actType );
				});
			});

			arrow_btn.bind('click',function(){
				action_reserve_more_btn( $(this) );
			});


			if( setFg ){
				$setOrderCnt ++;
				if( $setOrderCheck <= $setOrderCnt ){
					close_old_reserve();
				}
				
				var selecter  = $('#'+actType+'Code').val();
				var set_link = more_link.filter('[value="'+selecter+'"]');
				var set_btn  = more_btn.filter('[value="'+selecter+'"]');

				if( set_link.length > 0 ){
					set_link.unbind().bind('click',function(){
						action_more_item( $(this),actType,true );
						return false;
					});
					set_link.click();
					return false;
				}
				if( set_btn.length > 0 ){
					set_btn.unbind().bind('click',function(){
						action_reserve_btn( $(this) , actType , true );
					});
					set_btn.click();
					set_btn.unbind().bind('click',function(){
						action_reserve_btn( $(this) , actType );
					});
					return false;
				}
				if( set_link.length < 1 && set_btn.length < 1 ){
					$('#'+actType+'Code').val('');
				}
			}

			
		},error:function(err){
			//alert(err.responseText)
			obj.html( '[err] 잠시후에 다시 시도해 주세요.' );
		}
	});
}

/* 내용버튼 클릭시 */
function action_reserve_btn( _this , actType ,setFg ){
	var setFg    = !setFg ? false : setFg;

	_this.parent().find('.reserve_btn').removeClass('reserve_btn_on');
	_this.addClass('reserve_btn_on');
	$('.reserve_more_wrap').hide();
	$('.reserve_more_btn').removeClass('reserve_more_btn_on').unbind().bind('click',function(){
		action_reserve_more_btn($(this));
	});
	
	/* 강관 */
	if( actType=='item' && _this.val() == 'A00' ){
		$hidden_length.find('button').removeClass('reserve_btn_on');
		$hidden_length.show();
	}else if( actType=='item' && _this.val() != 'A00' ){
		$hidden_length.hide();
	}else if( actType=='company' ){
		$hidden_length.hide();
	}

	if(!setFg){
		if( actType=='company' ){
			$companyCode.val( _this.val() );
			getList( $('#item') , 'item' );
		}else if( actType=='item' ){
			$itemCode.val( _this.val() );
			getList( $('#product') , 'product');
		}else if( actType=='product' ){
			$productCode.val( _this.val() );
			getList( $('#thick') , 'thick');
		}else if( actType=='thick' ){
			$thickCode.val( _this.val() );
			getList( $('#width') , 'width');
		}else if( actType=='width' ){
			$widthCode.val( _this.val() );
			$length.focus();
		}
	}
}

/* 내용 더보기 */
function action_reserve_more_btn( _this ){
	$('.reserve_more_btn').removeClass('reserve_more_btn_on').unbind().bind('click',function(){
		action_reserve_more_btn($(this));
	});
	_this.addClass('reserve_more_btn_on').unbind().bind('click',function(){
		action_reserve_close_btn2($(this));
	});

	$('.reserve_more_wrap').hide();
	_this.parent().find('.reserve_more_wrap').show();
}

/* 내용 더보기 닫기 */
function action_reserve_close_btn2( _this ){
	_this.unbind().bind('click',function(){
		action_reserve_more_btn($(this));
	});
	_this.parent().find('.reserve_more_wrap').hide();
	_this.removeClass('reserve_more_btn_on');
}
function action_reserve_close_btn( _this ){
	var parent = _this.parent().parent().parent();
	parent.find('.reserve_more_wrap').hide();
	parent.find('.reserve_more_btn').removeClass('reserve_more_btn_on').unbind().bind('click',function(){
		action_reserve_more_btn($(this));
	});
}

/* 내용 더보기속 링크 클릭 */
function action_more_item( _this , actType ,setFg ){
	var setFg    = !setFg ? false : setFg;
	var obj      = _this.parent().parent().parent();

	var lastBtn  = obj.find('.reserve_btn:last');
	var lastCode = lastBtn.val();
	var lastName = lastBtn.text();

	lastBtn.remove();
	obj.prepend('<button type="button" class="reserve_btn" value="'+_this.attr('value')+'">'+_this.text()+'</button>');
	obj.find('.reserve_btn:first').bind('click',function(){
		action_reserve_btn( $(this), actType , setFg );
	});
	obj.find('.reserve_btn:first').click();
	_this.remove();
	obj.find('.reserve_more_wrap .item').prepend('<a href="#" value="'+lastCode+'">'+lastName+'</a>');
	obj.find('.reserve_more_wrap .item a:first').bind('click',function(){
		action_more_item( $(this), actType );
		return false;
	});
	obj.find('.reserve_more_wrap').hide();
}

/* 자주 사용하는 거래현황 등록 */
function setFavorites( key ){
	if(!confirm('등록 하시겠습니까?')){
		return false;
	}
	$wall.css('z-index','1200');
	$loading.css({ 'z-index':'1300' , 'margin-left':'-'+($loading.width()/2)+'px' , 'margin-top':(( $(document).scrollTop()+$loading.height() )/2)+'px' }).show();

	/*
	판매처 || 품목 || 품명[강종-표면-품명] || 두께 || 호칭경 || 길이 || 수량
	*/
	var _arry = key.split('||');

	var param = 'actType=insert' +
		'&companyCode='+encodeURIComponent(_arry[0])+
		'&itemCode='+encodeURIComponent( _arry[1] )+
		'&productCode='+encodeURIComponent(_arry[2])+
		'&thickCode='+encodeURIComponent(_arry[3])+
		'&widthCode='+encodeURIComponent(_arry[4])+
		'&length='+encodeURIComponent(_arry[5])+
		'&qty='+encodeURIComponent(_arry[6]);
	$.ajax({
		type    : 'GET',
		url     : 'ajax.favorites_proc.asp',
		data    : param,
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			if( text == '0' ){
				alert('등록되었습니다.');
			}else if(text == '1'){
				alert('로그인 세션이 만료되었습니다.');
				document.location.reload();
			}else if(text == '2'){
				alert('누락된 항목이 있습니다.');
			}else if(text == '3'){
				alert('길이,수량은 숫자로만 입력해주세요.');
			}else{
				alert('[err] 알수없는 에러, 관리자에게 문의하세요.');
			}
			$wall.css('z-index','1000');
			$loading.hide();
			
		},error:function(err){
			//alert(err.responseText)
			$wall.css('z-index','1000');
			$loading.hide();
			alert('[err] 잠시후에 다시 시도해 주세요.')
		}
	});
}

/* 자주 사용하는 거래현황 삭제 */
function deleteFavorites( idx ){
	if(!confirm('삭제 하시겠습니까?')){
		return false;
	}
	$wall.css('z-index','1200');
	$loading.css({ 'z-index':'1300' , 'margin-left':'-'+($loading.width()/2)+'px' , 'margin-top':(( $(document).scrollTop()+$loading.height() )/2)+'px' }).show();

	var param = 'actType=delete&idx='+idx;

	$.ajax({
		type    : 'GET',
		url     : 'ajax.favorites_proc.asp',
		data    : param,
		dataType: 'text',
		cache: false,
		scriptCharset:'utf-8',
		success: function(text){
			if( text == '0' ){
				alert('삭제 되었습니다.');
				getMyOrder('favorites');
			}else if(text == '1'){
				alert('로그인 세션이 없습니다.');
				document.location.reload();
			}else{
				alert('[err] 알수없는 에러, 관리자에게 문의하세요.');
			}
			$wall.css('z-index','1000');
			$loading.hide();
			
		},error:function(err){
			//alert(err.responseText)
			$wall.css('z-index','1000');
			$loading.hide();
			alert('[err] 잠시후에 다시 시도해 주세요.')
		}
	});
}


/* 하차장소 팝업 */
function pop_unloadplace(){
	window.open('pop_unloadplace.asp?unloadplace='+$unloadplace.val() ,'하차장소','width=520,height=590,status=no,resizable=no,scrollbars=no');
}

/* 주문서 현황 - 주문 수정 팝업 */
function pop_modify(seq){
	window.open('pop_modify.asp?orderCode='+$orderCode.val()+'&seq='+seq ,'주문수정','width=800,height=700,status=no,resizable=no,scrollbars=no');
}
/* 주문서 현황 - 삭제 */
function basket_delete(seq){
	if( !confirm('삭제 하시겠습니까?') ){
		return false;
	}
	$('#actType').val('delete');
	$('#seq').val(seq);
	$('#mForm').submit();

	$('#submit_area').html('삭제처리중 입니다.');
}
/* 주문서 현황 - 최종 주문 */
function basket_insert(){
	if( !confirm('주문 하시겠습니까?') ){
		return false;
	}
	$('#actType').val('insert');
	$('#seq').val('');
	$('#mForm').submit();

	$('#submit_area').html('주문처리중 입니다.');
}

/* 주문 - 최초 내용 로딩 [판매처/품목구분] */
getList( $('#company') , 'company' );

if( $orderCode.val() ){
	getList( $('#item')    , 'item' );
}