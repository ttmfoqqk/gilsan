<!-- #include file = "../../common/Carset_utf8.asp" -->
<!-- #include file = "../../common/connectdb.asp" -->
<!-- #include file = "../../common/fn.lib.asp" -->
<%
Response.Expires = 0   
Response.AddHeader "Pragma","no-cache"   
Response.AddHeader "Cache-Control","no-cache,must-revalidate"   
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> Gilsan Pipe Co., LTD. </title>
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
/*
var mCookie = getCookie('mCookie');

if(device != 'pc'){
	if(mCookie == ''){
		document.location.href='http://m.gilsan.co.kr/main/';
	}
}
*/
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
			<a href="http://mail.gilsan.co.kr/" target="_blank">Gilsan Mail</a> ㅣ
			<a href="http://gw.gilsan.co.kr/" target="_blank">GIlsan Groupware</a>
		</div>
		<%If session("userId") ="" Then%>
		<!--a href="../login/">로그인</a> 
		<a href="../join/page1.asp">회원가입</a-->
		<%Else%>
		<!--a href="../login/logout.asp">로그아웃</a> ㅣ
		<a href="../mypage/page1.asp">마이페이지</a-->
		<%End If%>
		
		&nbsp;&nbsp;<a href="../../" class="language_off">Korean</a><a class="language_on">English</a>
	</div>
</div>
<div id="top_navi">
	<div class="wrap">
		<div class="width_wrap">
			<ul class="mainmenu">
				<li class="logo"><a href="../main/"><h1><span class="blind">Gilsan Golf Club</span></h1></a></li>
				<li><a href="../m1/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/")>0,"over","")%>">Introduction</a>
					<ul class="submenu">
						<li><a href="../m1/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page1")>0,"over","")%>"><span>Gilsan Pipe Co., LTD.</span></a></li>
						<li><a href="../m1/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page2")>0,"over","")%>"><span>Greetings</span></a></li>
						<li><a href="../m1/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page3")>0,"over","")%>"><span>History</span></a></li>
						<!--li><a href="../m1/page7.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page7")>0,"over","")%>"><span>사회봉사활동</span></a></li-->
						<li><a href="../m1/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page4")>0,"over","")%>"><span>Awards</span></a></li>
						<!--li><a href="../m1/page6.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page6")>0,"over","")%>"><span>Organization</span></a></li-->
						<li><a href="../m1/page5.asp" class="<%=IIF(INSTR(LCase(g_url),"/m1/page5")>0,"over","")%>"><span>Certificates</span></a></li>
					</ul>
				</li>
				<li><a href="../m2/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/")>0,"over","")%>">Products</a>
					<ul class="submenu">
						<li><a href="../m2/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page1")>0,"over","")%>"><span>Sheet&Coil</span></a></li>
						<li><a href="../m2/page2_1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page2")>0,"over","")%>"><span>STS Pipe</span></a></li>
						<li><a href="../m2/page3_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page3")>0,"over","")%>"><span>STS Round Rod</span></a></li>
						<li><a href="../m2/page4_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page4")>0,"over","")%>"><span>Plain STS</span></a></li>
						<li><a href="../m2/page5_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page5")>0,"over","")%>"><span>Angular STS</span></a></li>
						<li><a href="../m2/page6_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page6")>0,"over","")%>"><span>STS Transmitting Pipe</span></a></li>
						<li><a href="../m2/page7_1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page7")>0,"over","")%>"><span>STS Square Rod</span></a></li>
						<li><a href="../m2/page8_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m2/page8")>0,"over","")%>"><span>STS Anchor</span></a></li>
					</ul>
				</li>
				<li><a href="../m3/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/")>0,"over","")%>">Subsidiaries</a>
					<ul class="submenu">
						<li><a href="../m3/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page1")>0,"over","")%>"><span>Affiliates</span></a></li>
						<!--li><a href="../m3/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page2")>0,"over","")%>"><span>설비현황</span></a></li>
						<li><a href="../m3/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page3")>0,"over","")%>"><span>Sales Status</span></a></li-->
						<li><a href="../m3/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m3/page4")>0,"over","")%>"><span>Approaching Route</span></a></li>
					</ul>
				</li>
				<!--li><a href="../m4/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/")>0,"over","")%>">온라인주문</a>
					<ul class="submenu">
						<li><a href="../m4/page1_1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/page1")>0,"over","")%>"><span>온라인주문</span></a></li>
						<li><a href="../m4/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m4/page2")>0,"over","")%>"><span>나의 주문현황</span></a></li>
					</ul>
				</li-->
				<!--li style="padding-right:0px;"><a href="../m5/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/")>0,"over","")%>">고객센터</a>
					<ul class="submenu">
						<li><a href="../m5/page1.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page1")>0,"over","")%>"><span>자주 묻는 질문</span></a></li>
						<li><a href="../m5/page2.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page2")>0,"over","")%>"><span>질문과 답변</span></a></li>
						<li><a href="../m5/page3.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page3")>0,"over","")%>"><span>자료실</span></a></li>
						<li><a href="../m5/page4.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page4")>0,"over","")%>"><span>길산소개</span></a></li>
						<li><a href="../m5/page5.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page5")>0,"over","")%>"><span>길산행사</span></a></li>
						<li><a href="../m5/page6.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page6")>0,"over","")%>"><span>길산축제</span></a></li>
						<li><a href="../m5/page7.asp" class="<%=IIF(INSTR(LCase(g_url),"/m5/page7")>0,"over","")%>"><span>길산 갤러리</span></a></li>
					</ul>
				</li-->
			</ul>
		</div>
	</div>
</div>
