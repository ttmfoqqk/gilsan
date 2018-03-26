<script type="text/javascript">
function submenu_open(obj){
	$obj = $(obj);
	if( $obj.is(':hidden') ){
		$obj.show();
	}else{
		$obj.hide();
	}
}
</script>
<div class="Admin_left">
<div><img src="../img/left_title_0<%=AdminTopmode%>.gif"></div>
<%If AdminTopmode = 1 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"Admin_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_01_L.asp">약관관리</a></li>
	<li style="<%=IIF(INSTR(g_url,"Admin_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_02_L.asp">사원관리</a></li>
	<li style="<%=IIF(INSTR(g_url,"Admin_03")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_03_L.asp">기초코드</a></li>
</ul>
<%elseIf AdminTopmode = 2 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"info_01")>0,"background-color:#f4f4f4;","")%>"><a href="../info/info_01_L.asp">설비현황관리</a></li>
</ul>

<%elseIf AdminTopmode = 3 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"staff_01")>0,"background-color:#f4f4f4;","")%>"><a href="../staff/staff_01_L.asp">영업사원관리</a></li>
</ul>
<%elseIf AdminTopmode = 4 Then%>
<ul>
	<li style="background-color:#f4f4f4;"><a href="../Member/Member_01_L.asp">회원관리</a></li>
</ul>
<%elseIf AdminTopmode = 5 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="19","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=19">추천사이트</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="20","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=20">질문과 답변</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="21","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=21">자료실</a></li>

	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="22","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=22">길산소개</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="23","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=23">길산행사</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="24","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=24">길산축제</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="27","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=27">길산뉴스</a></li>

	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="25","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=25">수상내역</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="26","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=26">인증서</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_02_L.asp">카테고리 관리</a></li>
</ul>
<%End If%>

</div>