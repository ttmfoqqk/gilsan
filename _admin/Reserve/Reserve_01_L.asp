<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim rows      : rows      = 20

Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserId    : UserId    = request("UserId")
Dim UserName  : UserName  = request("UserName")
Dim IdxTime   : IdxTime   = request("IdxTime")
Dim IdxArea   : IdxArea   = request("IdxArea")
Dim IdxDevice : IdxDevice = request("IdxDevice")
Dim State     : State     = request("State")
Dim Indate    : Indate    = request("Indate")
Dim Outdate   : Outdate   = request("Outdate")

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&amp;UserId="    & UserId &_
		"&amp;UserName="  & UserName &_
		"&amp;IdxTime="   & IdxTime &_
		"&amp;IdxArea="   & IdxArea &_
		"&amp;IdxDevice=" & IdxDevice &_
		"&amp;State="     & State &_
		"&amp;Indate="    & Indate &_
		"&amp;Outdate="   & Outdate

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_IOT_RESERVE_L"
		.Parameters("@rows").value      = rows 
		.Parameters("@pageNo").value    = pageNo
		.Parameters("@UserId").value    = UserId
		.Parameters("@UserName").value  = UserName
		.Parameters("@IdxTime").value   = IdxTime
		.Parameters("@IdxArea").value   = IdxArea
		.Parameters("@IdxDevice").value = IdxDevice
		.Parameters("@State").value     = State
		.Parameters("@Indate").value    = Indate
		.Parameters("@Outdate").value   = Outdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

%>
<script type="text/javascript">
$(document).ready( function() {
	getCodeAdd_combobox('#IdxTime','<%=fc_reserve_code_list("time","","")%>','');
	getCodeAdd_combobox('#IdxArea','<%=fc_reserve_code_list("area","","")%>','idx');
	getCodeAdd_combobox('#IdxDevice','<%=fc_reserve_code_list("device","","")%>','');

	$("#IdxTime > option[value = <%=IdxTime%>]").attr("selected", "ture");
	$("#IdxArea > option[value = <%=IdxArea%>]").attr("selected", "ture");
	$("#IdxDevice > option[value = <%=IdxDevice%>]").attr("selected", "ture");
});
function loadView(idx){
	$('#reserve_tab_btn_area').attr({ "value" : idx });
	pop_loading();
	$.ajax({
		type: "POST",
		dataType: "xml",
		url: "Reserve_01_V.asp",
		data: {
			Idx : idx
		} ,
		success: function(xml){
			var admin_login = $(xml).find("admin_login").text();
			if(admin_login=='login'){
				alert('�α��� ���� ����!');location.reload();return false;
			}
			if ($(xml).find("data").find("item").length > 0) {
				$(xml).find("data").find("item").each(function(idx) {
					var idx         = $(this).find("idx").text();
					var Other1      = $(this).find("Other1").text();
					var Other2      = $(this).find("Other2").text();
					var UserIdx     = $(this).find("UserIdx").text();
					var UserId      = $(this).find("UserId").text();
					var UserName    = $(this).find("UserName").text();
					var UserJumin   = $(this).find("UserJumin").text();
					var UserPhone1  = $(this).find("UserPhone1").text();
					var UserPhone2  = $(this).find("UserPhone2").text();
					var UserPhone3  = $(this).find("UserPhone3").text();
					var UserHPhone0 = $(this).find("UserHPhone0").text();
					var UserHPhone1 = $(this).find("UserHPhone1").text();
					var UserHPhone2 = $(this).find("UserHPhone2").text();
					var UserHPhone3 = $(this).find("UserHPhone3").text();
					var UserEmail   = $(this).find("UserEmail").text();
					var UserZipcode = $(this).find("UserZipcode").text();
					var UserAddr1   = $(this).find("UserAddr1").text();
					var UserAddr2   = $(this).find("UserAddr2").text();
					var UserIndate  = $(this).find("UserIndate").text();
					var UserOutdate = $(this).find("UserOutdate").text();
					var UserDelFg   = $(this).find("UserDelFg").text();
					var UserEmailFg = $(this).find("UserEmailFg").text();
					var UserBigo    = $(this).find("UserBigo").text();

					

					$('#t_indate').html( UserIndate );
					$('#t_name').html( UserName );
					$('#t_id').html( UserId );
					$('#t_ssn').html( UserJumin );
					$('#t_email').html( UserEmail );
					$('#t_phone').html( UserPhone1 +'-'+ UserPhone2 +'-'+ UserPhone3 );
					$('#t_hphone').html( UserHPhone1 +'-'+ UserHPhone2 +'-'+ UserHPhone3 );
					$('#t_addr').html( '['+UserZipcode+'] ' + UserAddr1 +' '+ UserAddr2 );
					$('#t_state').html( UserDelFg );
					$('#t_bigo').html( UserBigo );
					$('#t_other1').html( Other1 );
					$('#t_other2').html( Other2 );

					tabChange();

					layerPopupClose('wall_loading','pop_loading');
				});
			}
		},error:function(err){
			alert('ERR [502] : �����Ϳ� �����ϼ���.' + err.responseText);
		}
	});
}
function tabChange(tindex){
	var UserIdx = $('#reserve_tab_btn_area').attr("value");
	if( !UserIdx ){
		alert("���õ� �����Ͱ� �����ϴ�.");
		return false;
	}
	var t = !tindex ? $('#reserve_tab_btn_area').attr('tab'):tindex ;
	$('#reserve_tab_btn_area').attr('tab',t)

	
	t == 1 ? $('#tap1').attr({ "src" : $('#tap1').attr("src").replace("_off","_on") }) : $('#tap1').attr({ "src" : $('#tap1').attr("src").replace("_on","_off") });
	t == 1 ? $('#tap2').attr({ "src" : $('#tap2').attr("src").replace("_on","_off") }) : $('#tap2').attr({ "src" : $('#tap2').attr("src").replace("_off","_on") });
	t == 1 ? $('#reserve_tab_01').show() : $('#reserve_tab_01').hide();
	t == 1 ? $('#reserve_tab_02').hide() : $('#reserve_tab_02').show();
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%" style="padding-bottom:3px;"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > ������Ȳ </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">��������</td>
								<td class="line_box" colspan=3>
								<input type="text" class="input" id="Indate" name="Indate" readonly value="<%=Indate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Indate);"> - 
								<input type="text" class="input" id="Outdate" name="Outdate" readonly value="<%=Outdate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Outdate);"> 
								<a href="javascript:date_input('Indate','Outdate','<%=Date%>','<%=Date%>')">[����]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7����]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30����]</a>
								&nbsp;
								<a href="javascript:date_input('Indate','Outdate','','')">[��¥�ʱ�ȭ]</a>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">������</td>
								<td class="line_box" width="250"><input type="text" class="input" name="UserName" value="<%=UserName%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">���̵�</td>
								<td class="line_box"><input type="text" class="input" name="UserId" value="<%=UserId%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">����ð�</td>
								<td class="line_box" width="250">
									<select id="IdxTime" name="IdxTime"><option value="">����</option></select>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">�¼�</td>
								<td class="line_box">
									<select id="IdxArea" name="IdxArea"><option value="">����</option></select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">����</td>
								<td class="line_box" width="250">
									<select id="IdxDevice" name="IdxDevice"><option value="">����</option></select>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">�����Ȳ</td>
								<td class="line_box">
									<select id="State" name="State">
										<option value="">����</option>
										<option value="0" <%=IIF( State = "0" , "selected" , "" )%>>����Ϸ�</option>
										<option value="1" <%=IIF( State = "1" , "selected" , "" )%>>���</option>
										<option value="9" <%=IIF( State = "9" , "selected" , "" )%>>����</option>
									</select>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align=center colspan=2><input type="image" src="../img/center_btn_Search.gif"></td>
				</tr>

				</form>
				
				<form name="fm" method="POST" action="Admin_03_P.asp">
				<input type="hidden" name="actType" value="">
				<tr>
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="40">��ȣ</td>
								<td class="line_box" width="10%">������</td>
								<td class="line_box" width="10%">���̵�</td>
								<td class="line_box" width="10%">��������</td>
								<td class="line_box" width="10%">����ð�</td>
								<td class="line_box" width="10%">�¼�</td>
								<td class="line_box">����</td>
								<td class="line_box" width="10%">�����Ȳ</td>
								<td class="line_box" width="10%">�������</td>
							</tr>
							<%
							Dim PageLink,StateTxt
							for iLoop = 0 to cntList
								PageLink   = "loadView("&arrList(FI_ReserveIdx,iLoop)&")"

								If arrList(FI_state,iLoop) = "0" Then 
									StateTxt = "<font color=red>����Ϸ�</font>"
								ElseIf arrList(FI_state,iLoop) = "1" Then
									StateTxt = "<font color=blue>���</font>"
								ElseIf arrList(FI_state,iLoop) = "9" Then
									StateTxt = "����"
								End If
							%>
							<tr height="30" align=center>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_UserName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_UserId,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_ReservDate,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrySort( arrList(FI_Time_name,iLoop) , ",")%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Area_name,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrySort( arrList(FI_Device_name,iLoop) , ",")%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=StateTxt%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Indate,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="9" align=center>��ϵ� ������ �����ϴ�.</td>
							</tr>
							<%end if%>
						</table>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=left colspan=2>
						<div id="reserve_tab_btn_area" value="" tab="1"><img src="../img/center_btn_reserve_tab_01_on.gif" onclick="tabChange(1)" style="cursor:pointer;" id="tap1"><img src="../img/center_btn_reserve_tab_02_off.gif" onclick="tabChange(2)" style="cursor:pointer;" id="tap2"></div>
						<div id="reserve_tab_01">
							<table cellpadding=0 cellspacing=0 width=100%>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">��������</td>
									<td class="line_box" colspan=3 id="t_indate"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">�̸�</td>
									<td class="line_box" width="250" id="t_name"></td>
									<td class="line_box" bgcolor="f0f0f0" width="140">���̵�</td>
									<td class="line_box" id="t_id"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">�ֹι�ȣ</td>
									<td class="line_box" width="250" id="t_ssn"></td>
									<td class="line_box" bgcolor="f0f0f0" width="140">�̸���</td>
									<td class="line_box" id="t_email"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">��ȭ��ȣ</td>
									<td class="line_box" width="250" id="t_phone"></td>
									<td class="line_box" bgcolor="f0f0f0" width="140">�ڵ���</td>
									<td class="line_box" id="t_hphone"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">�ּ�</td>
									<td class="line_box" colspan=3 id="t_addr"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">Ż�𿩺�</td>
									<td class="line_box" colspan=3 id="t_state"></td>
								</tr>
								<tr height="30">
									<td class="line_box" bgcolor="f0f0f0" width="140">���</td>
									<td class="line_box" colspan=3 id="t_bigo"></td>
								</tr>
							</table>
						</div>
						<div id="reserve_tab_02" style="display:none;">
							<table cellpadding=0 cellspacing=0 width=100%>
								<tr height="50">
									<td class="line_box" bgcolor="f0f0f0" width="140">��Ÿ����1</td>
									<td class="line_box" colspan=3 id="t_other1"></td>
								</tr>
								<tr height="50">
									<td class="line_box" bgcolor="f0f0f0" width="140">��Ÿ����2</td>
									<td class="line_box" colspan=3 id="t_other2"></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				</form>
			</table>

		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->