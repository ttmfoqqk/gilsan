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
	<li style="<%=IIF(INSTR(g_url,"Admin_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_01_L.asp">�������</a></li>
	<li style="<%=IIF(INSTR(g_url,"Admin_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_02_L.asp">�������</a></li>
	<li style="<%=IIF(INSTR(g_url,"Admin_03")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_03_L.asp">�����ڵ�</a></li>
</ul>
<%elseIf AdminTopmode = 2 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"info_01")>0,"background-color:#f4f4f4;","")%>"><a href="../info/info_01_L.asp">������Ȳ����</a></li>
</ul>

<%elseIf AdminTopmode = 3 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"staff_01")>0,"background-color:#f4f4f4;","")%>"><a href="../staff/staff_01_L.asp">�����������</a></li>
</ul>
<%elseIf AdminTopmode = 4 Then%>
<ul>
	<li style="background-color:#f4f4f4;"><a href="../Member/Member_01_L.asp">ȸ������</a></li>
</ul>
<%elseIf AdminTopmode = 5 Then%>
<ul>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="19","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=19">��õ����Ʈ</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="20","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=20">������ �亯</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="21","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=21">�ڷ��</a></li>

	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="22","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=22">���Ұ�</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="23","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=23">������</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="24","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=24">�������</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="27","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=27">��괺��</a></li>

	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="25","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=25">���󳻿�</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_01")>0 And BoardKey="26","background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=26">������</a></li>
	<li style="<%=IIF(INSTR(g_url,"Customer_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_02_L.asp">ī�װ� ����</a></li>
</ul>
<%End If%>

</div>