<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
Response.Expires = 0   
Response.AddHeader "Pragma","no-cache"   
Response.AddHeader "Cache-Control","no-cache,must-revalidate"   
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 길산파이프(주) </title>
<meta name="Generator" content="EditPlus">
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script type="text/javascript" src="../common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/JavaScript" src="../common/js/common.js"></script>
<script type="text/JavaScript" src="../inc/js/default.js"></script>
<link rel="stylesheet" type="text/css" href="../inc/css/default.css">
<SCRIPT type="text/javascript">
var mCookie = getCookie('mCookie');

if(device != 'pc'){
	if(mCookie == ''){
		document.location.href='http://m.gilsan.co.kr/main/';
	}
}
</SCRIPT>
</head>

<body>
<SCRIPT type="text/javascript">
$(function(){
	$mainmenu = $('.mainmenu > li');
	
	$mainmenu.hover(
		function(){
			$(this).find('ul').stop().slideDown('fast');
		},
		function(){
			$(this).find('ul').stop().slideUp('fast');
		}
	)
});
</SCRIPT>
<div id="top_mini_menu">
	<div class="bgL"></div>
	<div class="bgR"></div>
	<div class="width_wrap">
		<div style="float:left;">
			<!--<a href="http://mail.gilsan.co.kr/" target="_blank">길산메일</a> ㅣ-->
			<a href="http://ep.gilsan.co.kr/" target="_blank">길산 메일/그룹웨어</a>
		</div>
		<%If session("userId") ="" Then%>
		<a href="../login/">로그인</a> ㅣ
		<a href="../join/page1.asp">회원가입</a>
		<%Else%>
		<a href="../login/logout.asp">로그아웃</a> ㅣ
		<a href="../mypage/page1.asp">마이페이지</a>
		<%End If%>
		
		&nbsp;&nbsp;<a class="language_on">Korean</a><a href="../en/" class="language_off">English</a>
	</div>
</div>
<div id="top_navi">
	<div class="wrap">
		<div class="width_wrap">
			<ul class="mainmenu">
				<li class="logo"><a href="../main/"><h1><span class="blind">(주)길산골프클럽</span></h1></a></li>
				<li><a href="../m1/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/")>0,"over","")%>">회사소개</a>
					<ul class="submenu">
						<li><a href="../m1/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page1")>0,"over","")%>"><span>길산파이프소개</span></a></li>
						<li><a href="../m1/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page2")>0,"over","")%>"><span>인사말</span></a></li>
						<li><a href="../m1/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page3")>0,"over","")%>"><span>주요연혁</span></a></li>
						<!--li><a href="../m1/page7.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page7")>0,"over","")%>"><span>사회봉사활동</span></a></li-->
						<li><a href="../m1/page6.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page6")>0,"over","")%>"><span>조직도</span></a></li>
						<li><a href="../m1/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page4")>0,"over","")%>"><span>수상내역</span></a></li>
						<li><a href="../m1/page5.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page5")>0,"over","")%>"><span>인증서</span></a></li>
					</ul>
				</li>
				<li><a href="../m2/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/")>0,"over","")%>">제품소개</a>
					<ul class="submenu">
						<li><a href="../m2/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page1")>0,"over","")%>"><span>Sheet&Coil</span></a></li>
						<li><a href="../m2/page2_1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page2")>0,"over","")%>"><span>Pipe</span></a></li>
						<li><a href="../m2/page3_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page3")>0,"over","")%>"><span>환봉</span></a></li>
						<li><a href="../m2/page4_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page4")>0,"over","")%>"><span>평철</span></a></li>
						<li><a href="../m2/page5_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page5")>0,"over","")%>"><span>앵글</span></a></li>
						<li><a href="../m2/page6_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page6")>0,"over","")%>"><span>배관</span></a></li>
						<li><a href="../m2/page7_1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page7")>0,"over","")%>"><span>각봉</span></a></li>
						<li><a href="../m2/page8_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page8")>0,"over","")%>"><span>앙카</span></a></li>
					</ul>
				</li>
				<li><a href="../m3/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/")>0,"over","")%>">계열사현황</a>
					<ul class="submenu">
						<li><a href="../m3/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page1")>0,"over","")%>"><span>계열사소개</span></a></li>
						<li><a href="../m3/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page2")>0,"over","")%>"><span>설비현황</span></a></li>
<!--						<li><a href="../m3/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page3")>0,"over","")%>"><span>판매자정보</span></a></li>-->
						<li><a href="../m3/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page4")>0,"over","")%>"><span>오시는길</span></a></li>
					</ul>
				</li>
				<li><a href="../m4/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/")>0,"over","")%>">온라인주문</a>
					<ul class="submenu">
						<li><a href="../m4/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/page1")>0,"over","")%>"><span>온라인주문</span></a></li>
						<li><a href="../m4/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/page2")>0,"over","")%>"><span>나의 주문현황</span></a></li>
						<!--li><a href="../m4/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/page3")>0,"over","")%>" onclick="alert('준비중입니다.');return false;"><span>재고조회</span></a></li-->
					</ul>
				</li>
				<li style="padding-right:0px;"><a href="../m5/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/")>0,"over","")%>">고객센터</a>
					<ul class="submenu">
						<li><a href="../m5/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page1")>0,"over","")%>"><span>추천사이트</span></a></li>
						<li><a href="../m5/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page2")>0,"over","")%>"><span>SALES</span></a></li>
						<li><a href="../m5/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page3")>0,"over","")%>"><span>길산공부방</span></a></li>
						<li><a href="../m5/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page4")>0,"over","")%>"><span>길산소개</span></a></li>
						<li><a href="../m5/page5.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page5")>0,"over","")%>"><span>길산행사</span></a></li>
						<li><a href="../m5/page6.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page6")>0,"over","")%>"><span>길산축제</span></a></li>
						<li><a href="../m5/page7.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page7")>0,"over","")%>"><span>길산뉴스</span></a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>
