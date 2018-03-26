<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & "/_admin/Member/Member_01_L.asp" )

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim userId   : userId   = request("userId")
Dim userName : userName = request("userName")
Dim CUSTNAME : CUSTNAME = request("CUSTNAME")
Dim state    : state    = request("state")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim Id       : Id       = request("Id")

Dim pageParams
pageParams	= "pageNo=" & pageNo &_
		"&userId="   & userId &_
		"&userName=" & userName &_
		"&CUSTNAME="   & CUSTNAME &_
		"&state="    & state &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate


Call Expires()
Call dbopen()
	Call getView()
Call dbclose()

Dim email : email = Split( IIF(FI_email="","@",FI_email) ,"@")

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_user_member_info_v"
		.Parameters("@id").value  = Id
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_04_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 회원관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><!--img src="../img/center_sub_board_write.gif"--></td>
				</tr>

				<form name="AdminForm" method="POST" action="Member_01_P.asp" onsubmit="return check()">
				<input type="hidden" name="Id" value="<%=FI_id%>">
				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">아이디</td>
								<td class="line_box"><%=FI_id%></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">비밀번호</td>
								<td class="line_box">
									<input type="password" name="pwd" id="pwd" maxlength="20" style="ime-mode:disabled;">
									비밀번호 변경시에만 작성해주세요.
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">상호</td>
								<td class="line_box"><input type="text" name="CUSTNAME" id="CUSTNAME" maxlength="200" value="<%=FI_CUSTNAME%>" size="80"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">사업자번호</td>
								<td class="line_box"><input type="text" name="SANO" id="SANO" maxlength="20" value="<%=FI_SANO%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">주소</td>
								<td class="line_box"><input type="text" name="JUSO" id="JUSO" maxlength="200" value="<%=FI_JUSO%>" size="80"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">담당자명</td>
								<td class="line_box"><input type="text" name="MEMNAME" id="MEMNAME" maxlength="200" value="<%=FI_MEMNAME%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">HP</td>
								<td class="line_box"><input type="text" name="HP" id="HP" maxlength="20" value="<%=FI_HP%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">TEL</td>
								<td class="line_box"><input type="text" name="TEL" id="TEL" maxlength="50" value="<%=FI_TEL%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">FAX</td>
								<td class="line_box"><input type="text" name="FAX" id="FAX" maxlength="50" value="<%=FI_FAX%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">이메일</td>
								<td class="line_box">
									<input type="text" id="email1" name="email1" class="input" size="12" value="<%=email(0)%>"> @ 
									<input type="text" id="email3" name="email3" class="input" size="12" value="<%=email(1)%>">
									<select id="email2" name="email2"></select>
									<!--input type="checkbox" name="email_write"> 직접입력-->
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select name="state" id="state">
										<option value="0" <%=IIF( FI_secede="","selected","" )%>>사용</option>
										<option value="1" <%=IIF( FI_secede="1","selected","" )%>>탈퇴</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">가입일자</td>
								<td class="line_box"><%=FI_indate%></td>
							</tr>
							<%If FI_secede = "1" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140" height="30">탈퇴일자</td>
								<td class="line_box"><%=FI_secedeDate%></td>
							</tr>
							<%End If%>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_save.gif" style="border:0px;">
						<a href="Member_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
</form>
</table>
<script type="text/javascript">

getCodeAdd_combobox('#email2','<%=fc_code_list(11)%>','','<%=email(1)%>','선택');
$('#email2').change(function(e){
	$('#email3').val( $(this).val() );
});
/*
$('input[name=email_write]').click(function(e){
	$(this).attr('checked') == true ? $('#email3').css({"display":""}) : $('#email3').css({"display":"none"});
});
*/


function check(){
	if( !trim($('#CUSTNAME').val()) ){
		alert('상호를 입력해주세요.');
		return false;
	}
	if( !trim($('#SANO').val()) ){
		alert('사업자번호를 입력해주세요.');
		return false;
	}
	if( !trim($('#JUSO').val()) ){
		alert('주소를 입력해주세요.');
		return false;
	}
	if( !trim($('#MEMNAME').val()) ){
		alert('담당자명을 입력해주세요.');
		return false;
	}
	if( !trim($('#state').val()) ){
		alert('사용여부를 선택해주세요.');
		return false;
	}
}
</script>
<!-- #include file = "../inc/bottom.asp" -->