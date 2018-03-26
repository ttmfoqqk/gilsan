	<% If INSTR(LCase(g_url),"/m1/")>0 Then %>
	<div id="left_menu">
		<h2>회사소개</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>길산파이프소개</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>인사말</span></a></li>
			<li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>주요연혁</span></a></li>
			<!--li><a href="page7.asp" class="<%=IIF( INSTR(LCase(g_url),"page7") > 0 ,"over" , "" )%>"><span>사회봉사활동</span></a></li-->
			<li><a href="page6.asp" class="<%=IIF( INSTR(LCase(g_url),"page6") > 0 ,"over" , "" )%>"><span>조직도</span></a></li>
			<li><a href="page4.asp" class="<%=IIF( INSTR(LCase(g_url),"page4") > 0 ,"over" , "" )%>"><span>수상내역</span></a></li>
			<li><a href="page5.asp" class="<%=IIF( INSTR(LCase(g_url),"page5") > 0 ,"over" , "" )%>"><span>인증서</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m2/")>0 Then %>
	<div id="left_menu">
		<h2>제품소개</h2>
		<ul>
			<li><a href="page1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>Sheet&Coil</span></a></li>
			<li><a href="page2_1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>Pipe</span></a></li>
			<li><a href="page3_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>환봉</span></a></li>
			<li><a href="page4_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page4") > 0 ,"over" , "" )%>"><span>평철</span></a></li>
			<li><a href="page5_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page5") > 0 ,"over" , "" )%>"><span>앵글</span></a></li>
			<li><a href="page6_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page6") > 0 ,"over" , "" )%>"><span>배관</span></a></li>
			<li><a href="page7_1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page7") > 0 ,"over" , "" )%>"><span>각봉</span></a></li>
			<li><a href="page8_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page8") > 0 ,"over" , "" )%>"><span>앙카</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m3/")>0 Then %>
	<div id="left_menu">
		<h2>계열사현황</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>계열사소개</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>설비현황</span></a></li>
<!--			<li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>판매자정보</span></a></li>-->
			<li><a href="page4.asp" class="<%=IIF( INSTR(LCase(g_url),"page4") > 0 ,"over" , "" )%>"><span>오시는길</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m4/")>0 Then %>
	<div id="left_menu">
		<h2>온라인주문</h2>
		<ul>
			<li><a href="page1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>온라인주문</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>나의 주문현황</span></a></li>
			<!--li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>" onclick="alert('준비중입니다.');return false;"><span>재고조회</span></a></li-->
			<li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>재고조회(테스트중입니다!!)</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m5/")>0 Then %>
	<div id="left_menu">
		<h2>고객센터</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>추천사이트</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>SALES</span></a></li>
			<li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>길산공부방</span></a></li>
			<li><a href="page4.asp" class="<%=IIF( INSTR(LCase(g_url),"page4") > 0 ,"over" , "" )%>"><span>길산소개</span></a></li>
			<li><a href="page5.asp" class="<%=IIF( INSTR(LCase(g_url),"page5") > 0 ,"over" , "" )%>"><span>길산행사</span></a></li>
			<li><a href="page6.asp" class="<%=IIF( INSTR(LCase(g_url),"page6") > 0 ,"over" , "" )%>"><span>길산축제</span></a></li>
			<li><a href="page7.asp" class="<%=IIF( INSTR(LCase(g_url),"page7") > 0 ,"over" , "" )%>"><span>길산뉴스</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/mypage/")>0 Then %>
	<div id="left_menu">
		<h2>마이페이지</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>청약접수처</span></a></li>
			<li><a href="page5.asp" class="<%=IIF( INSTR(LCase(g_url),"page5") > 0 ,"over" , "" )%>"><span>나의 주문현황</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>비밀번호 변경</span></a></li>
			<li><a href="page3.asp" class="<%=IIF( INSTR(LCase(g_url),"page3") > 0 ,"over" , "" )%>"><span>회원정보 변경</span></a></li>
			<li><a href="page4.asp" class="<%=IIF( INSTR(LCase(g_url),"page4") > 0 ,"over" , "" )%>"><span>회원탈퇴</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/find/")>0 Then %>
	<div id="left_menu">
		<h2>회원정보</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>아이디 찾기</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>비밀번호 재발급</span></a></li>
		</ul>
	</div>
	<% elseIf INSTR(LCase(g_url),"/agree/")>0 Then %>
	<div id="left_menu">
		<h2>약관 및 정책</h2>
		<ul>
			<li><a href="page1.asp" class="<%=IIF( INSTR(LCase(g_url),"page1") > 0 ,"over" , "" )%>"><span>이영약관</span></a></li>
			<li><a href="page2.asp" class="<%=IIF( INSTR(LCase(g_url),"page2") > 0 ,"over" , "" )%>"><span>개인정보보호정책</span></a></li>
		</ul>
	</div>
	<% End If %>