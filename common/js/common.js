function bluring(){if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();}
document.onfocusin=bluring;

var ROOT_DIR = '/'

//파라미터 리퀘스트
var Request = function(){
	this.getParameter = function( name ){
	var rtnval = '';
	var nowAddress = unescape(location.href);
	var parameters = (nowAddress.slice(nowAddress.indexOf('#')+1,nowAddress.length)).split('&');
		for(var i = 0 ; i < parameters.length ; i++){
			var varName = parameters[i].split('=')[0];
			if(varName.toUpperCase() == name.toUpperCase()){
				rtnval = parameters[i].split('=')[1];break;
			}
		}
	return rtnval;
	}
}
var request = new Request();

/*=====================================================================
 * 달력.
 *=====================================================================*/
var calendarDivId    = "__DIV_CALENDAR__";
var calendarIframeId = "__IFRAME_CALENDAR__";
//달력 보여줄 위치 찾기:Top
function getRealOffsetTop(o) {
	return o ? o.offsetTop + getRealOffsetTop(o.offsetParent) : 3;
}
//달력 보여줄 위치 찾기:Left
function getRealOffsetLeft(o) {
	return o ? o.offsetLeft + getRealOffsetLeft(o.offsetParent) : 2;
}
function hideCalendar()	{
	var cal = document.getElementById(calendarDivId);
		if(cal) cal.style.display = "none";
}
function callCalendar(obj)	{
	var top  = getRealOffsetTop(obj)+17;
	var left = getRealOffsetLeft(obj)-6;
	
	var param = '';
	if(obj) {
		var tokens = obj.value.split("-");
		if(tokens.length==3)
		{
			param   = "&year="+tokens[0];
			param  += "&month="+tokens[1];
			param  += "&day="+tokens[2];
		}
	}
	url = "../../common/calender.asp?obj="+obj.form.name+"."+obj.name;	
	if(param!="") url += param;
	var width = 215;
	var height = 180;
	var ifrm = document.getElementById(calendarIframeId);
	var div = document.getElementById(calendarDivId);
	if(!div)
	{
		div = document.createElement("DIV");
		div.id = calendarDivId;
		div.style.display = "none";
		div.style.position = "absolute";
		div.style.left = left+'px';
		div.style.top = top+'px';
		div.style.zIndex = 2000;
		//obj.parentNode.appendChild(div);
		document.body.appendChild(div);
	}else{
		div.style.left = left+'px';
		div.style.top = top+'px';
	}
	if(!ifrm)
	{
		ifrm = document.createElement("IFRAME");
		ifrm.id = calendarIframeId;
		ifrm.width = width;
		ifrm.height = height;
		ifrm.frameBorder = 0;
		ifrm.scrolling = "no";
		ifrm.style.border = '1px solid #aaaaaa';
		div.appendChild(ifrm);
	}
	div.style.display = "inline";
	ifrm.src = url;
}

//-------------------------------------------------------
// 오늘 , 7일 , 30일후
//-------------------------------------------------------
function date_input(Indate,Outdate,value1,value2){
	Indate = document.getElementById(Indate);
	Outdate = document.getElementById(Outdate);
	Indate.value=value1;
	Outdate.value=value2;
}


/*===========================================================================
 * DIV 팝업창 열기
 *===========================================================================*/
function layerPopupOpen(wall_id,wall_zindex,pop_id,pop_zindex,top_px){
	var $tmp_wall = '<div class="wall" id="'+wall_id+'"></div>';
	var $layerPopupObj = $('#'+pop_id);
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 ); 
	var top_center = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 ); 
	var top_pix = ( $(window).scrollTop() + top_px ); 
	var top = top_px ? top_pix : top_center;

	$('body').append($tmp_wall);
	$('#'+wall_id).css({"z-index":wall_zindex,"height":$(document).height(),"opacity":0.5});

	$layerPopupObj.css({'left':left,'top':top,"z-index":pop_zindex});
}
/*===========================================================================
 * DIV 팝업창 삭제
 *===========================================================================*/
function layerPopupClose(wall_id,pop_id){
	var $tmp_wall = $('#'+wall_id);
	var $layerPopupObj = $('#'+pop_id);
	$tmp_wall.remove();
	$layerPopupObj.remove();
}

/*===========================================================================
 * 기초코드 콤보박스 옵션 추가하기 fc_lib.asp [fc_code_list]
 *===========================================================================*/
function getCodeAdd_combobox(objId,txt,mode,val,title){
	$(objId + ' option').remove();
	title = !title ? '선택' : title;
	var tmp_arry = txt.split('|_ARRY_|');
	var paramLi = '<option value="">'+title+'</option>';

	if(tmp_arry.length > 0){
		for(var i=0 ; i < tmp_arry.length ; i++) {
			var o = tmp_arry[i].split('|_KEY_|');
			var k = mode == 'idx' ? o[0] : o[1] ;
			var s = k == val ? 'selected' : '';
			
			paramLi += '<option value="' + k + '" '+s+'>';
			paramLi += o[1];
			paramLi += '</option>';
		}
		$(objId).html(paramLi);
	}
}

/*===========================================================================
 * TRIM 화이트스페이스 제거
 *===========================================================================*/
function trim(str){ 		
	str = str.replace(/^\s*/,'').replace(/\s*$/, '');
	return str; //변환한 스트링을 리턴.
}

/*===========================================================================
 * TagDecode script
 *===========================================================================*/
function TagDecode(str){
	var temp;
	temp = str.replace(/&quot;/gi,"\"")
	temp = temp.replace(/&#39;/gi,"\'")
	temp = temp.replace(/&lt;/gi,"<")
	temp = temp.replace(/&gt;/gi,">")
	temp = temp.replace(/<br>/gi,"\n")
	temp = temp.replace(/&amp;/gi,"&")
	return temp;
}

/*===========================================================================
 * 우편번호
 *===========================================================================*/
function zipAddrSearch(zip1,zip2,addr1,addr2){
	var html_txt = '' +
	'<div class="ZIP_POP" id="ZIP_POP">' + 
		'<div style="float:right;padding:10px 20px 10px 0px;" class="close"><a href="#"><img src="'+ROOT_DIR+'common/img/icon_close.gif" align=absmiddle></a></div>' +
		'<table cellpadding=0 cellspacing=0 border=0 width=400>' +
			'<tr>' +
				'<td align=center><img src="'+ROOT_DIR+'common/img/zip_01.jpg"></td>' +
			'</tr>' +
			'<tr>' +
				'<td align=center>' +
					'<table cellpadding=0 cellspacing=5 width=370 bgcolor="#eaeaea">' +
						'<tr>' +
							'<td style=padding:1 bgcolor="#ffffff">' +					
								'<table cellpadding=0 cellspacing=0 width=100% bgcolor="#eaeaea">' +
									'<tr><td height=10></td></tr>' +
									'<tr>' +
										'<td width=250 align=center><input type="text" name="schDong" id="schDong" class="input" style="width:225px;ime-mode:active;"></td>' +
										'<td><a href="#"><img src="'+ROOT_DIR+'common/img/zip_btn.jpg" align=absmiddle id="schDong_search_btn"></a></td>' +
									'</tr>' +
									'<tr><td height=10></td></tr>' +
								'</table>' +
							'</td>' +
						'</tr>' +
					'</table>' +
				'</td>' +
			'</tr>' +
			'<tr><td height=10></td></tr>' +
			'<tr>' +
				'<td align=center>' +
					'<div style="width:370px;margin:0 auto;background-color:#f6f6f6;border-top:1px solid #d9d9d9">' +
						'<div style="clear:both;float:left;width:61px;line-height:23px;color:#555555;border-right:1px solid #d9d9d9;border-bottom:1px solid #d9d9d9">우편번호</div>' +
						'<div style="float:left;width:308px;line-height:23px;border-bottom:1px solid #d9d9d9;">주소</div>' +
					'</div>'+
					'<div style="clear:both;width:370px;height:180px;margin:0 auto;overflow-y:auto;" id=zipArea></div>' +
				'</td>' +
			'</tr>' +
		'</table>' +
	"</div>";
		

	$('body').append(html_txt);
	$('#ZIP_POP .close a').click(function(e){
		e.preventDefault();
		layerPopupClose('wall_zip','ZIP_POP');
	});
	$('#schDong').keyup(function(e){
		if (e.keyCode == 13){
			zipAddrSearchData(zip1,zip2,addr1,addr2);
		}
	});
	$('#schDong_search_btn').click(function(e){
		e.preventDefault();
		zipAddrSearchData(zip1,zip2,addr1,addr2);
	});
	layerPopupOpen('wall_zip',500,'ZIP_POP',520);
	$('#schDong').focus();
}

function zipAddrSearchData(zip1,zip2,addr1,addr2){
	var html = '';
	$('#zipArea').html('<div style="text-align:center;line-height:23px;">로딩중입니다.</div>');
	$.ajax({
		type: "GET",
		dataType: "xml",
		url: ROOT_DIR + "common/zip_rss.asp",
		data: {
			schDong : $('#schDong').val()
		} ,
		success: function(xml){
			if ($(xml).find("data").find("item").length > 0) {
				$(xml).find("data").find("item").each(function(idx) {

					var zipcode = $(this).find("zipcode").text();
					var addr    = $(this).find("addr").text();
					var bunji   = $(this).find("bunji").text();

					html += '' +
					'<table cellpadding=0 cellspacing=0 height=23><tr align=center>' +
					'<td style="border-right:1px solid #d9d9d9;border-bottom:1px solid #d9d9d9" width=64><a href=# zipcode="'+zipcode+'" addr="'+addr+'" bunji="'+bunji+'">' + zipcode + '</a></td>' +
					'<td style="border-bottom:1px solid #d9d9d9;padding-left:5px;" width=308 align=left><a href=# zipcode="'+zipcode+'" addr="'+addr+'" bunji="'+bunji+'">'+ addr +'  '+ bunji +'</a></td>' +
					'</tr></table>';
				});
			}else{
				html = '<div style="text-align:center;line-height:23px;">데이터가 없습니다.</div>'
			}
			$('#zipArea').html(html);
			$('#zipArea a').click(function(e){
				e.preventDefault();
				var tmp_zip = $(this).attr('zipcode').split('-');
				$('#'+zip1).val( tmp_zip[0] );
				$('#'+zip2).val( tmp_zip[1] );
				$('#'+addr1).val( $(this).attr('addr') + ' ' + $(this).attr('bunji') );
				$('#'+addr2).focus();
				layerPopupClose('wall_zip','ZIP_POP');
			});
		},error:function(err){
			alert('ERR [502] : 고객센터에 문의하세요.' + err.responseText);
		}
	});
}

 //로딩
function pop_loading(){
	var html = '<div class="pop_box" id="pop_loading" style="text-align:center;width:200px;line-height:100px;"><b>LOADING..</b></div>';
	$('body').append(html);
	layerPopupOpen('wall_loading',1000,'pop_loading',1200);
}

function onlyNum() { 
  var keycode = window.event.keyCode;
 
  if(keycode == 8 || keycode == 9 || (keycode >= 35 && keycode <= 40) || (keycode >= 46 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 110 || keycode == 190) {
    window.event.returnValue = true;
    return;
  } else {
    window.event.returnValue = false;
    return;
  }
}

// 쿠키 생성
 function setCookie(cName, cValue, cDay){
	  var expire = new Date();
	  var domain = 'gilsan.co.kr';
	  expire.setDate(expire.getDate() + cDay);
	  cookies = cName + '=' + escape(cValue) + '; path=/;domain='+domain+' '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
	  if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	  document.cookie = cookies;
 }

 // 쿠키 가져오기
 function getCookie(cName) {
	  cName = cName + '=';
	  var cookieData = document.cookie;
	  var start = cookieData.indexOf(cName);
	  var cValue = '';
	  if(start != -1){
		   start += cName.length;
		   var end = cookieData.indexOf(';', start);
		   if(end == -1)end = cookieData.length;
		   cValue = cookieData.substring(start, end);
	  }
	  return unescape(cValue);
 }