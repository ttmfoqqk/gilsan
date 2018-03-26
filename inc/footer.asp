
<div id="footer_navi">
	<div class="width_wrap">
		<ul>
			<li class="title">회사소개</li>
			<li><a href="../m1/page1.asp">길산파이프소개</a></li>
			<li><a href="../m1/page2.asp">인사말</a></li>
			<li><a href="../m1/page3.asp">주요연혁</a></li>
			<!--li><a href="../m1/page7.asp">사회봉사활동</a></li-->
			<li><a href="../m1/page6.asp">조직도</a></li>
			<li><a href="../m1/page4.asp">수상내역</a></li>
			<li><a href="../m1/page5.asp">인증서</a></li>
		</ul>
		<ul>
			<li class="title">제품소개</li>
			<li><a href="../m2/page1_1.asp">SHeet&Coil</a></li>
			<li><a href="../m2/page2_1_1.asp">Pipe</a></li>
			<li><a href="../m2/page3_1.asp">환봉</a></li>
			<li><a href="../m2/page4_1.asp">평철</a></li>
			<li><a href="../m2/page5_1.asp">앵글</a></li>
			<li><a href="../m2/page6_1.asp">배관</a></li>
			<li><a href="../m2/page7_1_1.asp">각봉</a></li>
			<li><a href="../m2/page8_1.asp">앙카</a></li>
		</ul>
		<ul>
			<li class="title">계열사현황</li>
			<li><a href="../m3/page1.asp">계열사소개</a></li>
			<li><a href="../m3/page2.asp">설비현황</a></li>
			<li><a href="../m3/page3.asp">판매현황</a></li>
			<li><a href="../m3/page4.asp">오시는길</a></li>
		</ul>
		<ul>
			<li class="title">온라인주문</li>
			<li><a href="../m4/page1_1.asp">온라인주문</a></li>
			<li><a href="../m4/page2.asp">나의 주문현황</a></li>
			<!--li><a href="../m4/page3.asp" onclick="alert('준비중입니다.');return false;">재고조회</a></li-->
		</ul>
		<ul>
			<li class="title">고객센터</li>
			<li><a href="../m5/page1.asp">추천사이트</a></li>
			<li><a href="../m5/page2.asp">SALES</a></li>
			<li><a href="../m5/page3.asp">길산공부방</a></li>
			<li><a href="../m5/page4.asp">길산소개</a></li>
			<li><a href="../m5/page5.asp">길산행사</a></li>
			<li><a href="../m5/page6.asp">길산축제</a></li>
			<li><a href="../m5/page7.asp">길산뉴스</a></li>
		</ul>
	</div>
</div>
<div id="footer">
	<div class="width_wrap">
		<div class="logo"><span class="blind"><h1>(주)길산골프클럽</h1></span></div>
		<div class="copy">
			<p>
				<a href="../agree/page1.asp">이용약관</a>
				&nbsp;&nbsp;·&nbsp;&nbsp;
				<a href="../agree/page2.asp">개인정보취급방침</a>
				&nbsp;&nbsp;·&nbsp;&nbsp;
				<a href="#" onclick="return false;">이메일 무단수집 거부</a>
				<br><br>
				충남 논산시 부적면 감곡1길 7-24(감곡리 112-14) 길산파이프    TEL. 041-732-9994 / 계룡 코일센타 042-551-9994<br>
				Copyright (C) 2014 GILSAN. All Rights Reserved. 
			</p>
		</div>
		<div class="option">
			<select id="FamilySite">
				<option value="">Family Site</option>
				<option value="http://www.gilsangolf.co.kr/">(주)길산골프클럽</option>
				<option value="http://www.gilsan.co.kr/">(주)길산스틸</option>
				<option value="http://www.gilsan.co.kr/">(주)길산에스티</option>
				<option value="http://www.gilsan.co.kr/">(주)길산에스에스티</option>
				<option value="http://www.gilsan.co.kr/">(주)석진길산에스에스티</option>
			</select><br>

			<!--a href="#" onclick="snsShare('facebook');return false;" class="facebook"><span class="blind">페이스북 알리기</span></a>
			<a href="#" onclick="snsShare('twitter');return false;" class="twitter"><span class="blind">트위터 알리기</span></a-->
		</div>
	</div>
</div>

<!-- 퀵메뉴 -->
<div id="quick_menu" style="clear:both;position:absolute;top:-1000px;left:-1000px;width:40px;z-index:100;"> 
<a href="#" onclick="$(document).scrollTop(0);return false;"><img src="../img/btn_quick.gif"></a>
</div>

<script type="text/javascript">

$FamilySite = $('#FamilySite');
$FamilySite.change(function(){
	var v = $(this).val();
	if(!v){
		return false;
	}
	window.open( v , '' , '' );
	$(this).val('');
});



var quick_menu = $('#quick_menu');
var quick_top = 498;
var left = ( ($(document).width() - quick_menu.width()) / 2 ) + 520;

/* quick menu initialization */
quick_menu.css( {'top': $(window).height() ,'left': left + 'px' } );
$(document).ready(function(){
	quick_menu.animate( { "top": $(document).scrollTop() + quick_top +"px" }, 500 ); 
	$(window).scroll(function(){
		quick_menu.stop();
		quick_menu.animate( { "top": $(document).scrollTop() + quick_top + "px" }, 1000 );
	});
});

$(window).resize(function(){
	var left = (  $(document).width()  / 2 ) + 500;
	quick_menu.css( { 'left': left + 'px' } );
})

</script>
<!-- 퀵메뉴 -->

<body>
</html>