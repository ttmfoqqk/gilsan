<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim rows      : rows      = 20
Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim AdminId   : AdminId   = request("AdminId")
Dim AdminName : AdminName = request("AdminName")
Dim Indate    : Indate    = request("Indate")
Dim Outdate   : Outdate   = request("Outdate")
Dim pageURL,PageLink
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&amp;AdminId="   & AdminId &_
		"&amp;AdminName=" & AdminName &_
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
		.CommandText      = "M_ADMIN_MEMBER_L"
		.Parameters("@rows").value      = rows 
		.Parameters("@pageNo").value    = pageNo
		.Parameters("@AdminId").value   = AdminId
		.Parameters("@AdminName").value = AdminName
		.Parameters("@Indate").value    = Indate
		.Parameters("@Outdate").value   = Outdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)	' ù��°���� �࿡�� ��ü �Ǽ� ����.
	End If
	objRs.close	: Set objRs = Nothing
End Sub

%>
<table cellpadding=0 cellspacing=0 width="1000" height="84%" align=center border=0>
	<tr>
		<td width="200" height="100%" valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td valign=top style="padding:10px" height="100%">
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%">��<%=AdminLeftName%></td>
					<td width="50%" align=right>��<%=AdminLeftName%> > �����ڵ�</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td colspan=2>���˻�</td>
				</tr>

				<form name="SearchForm" method="get">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">����</td>
								<td class="line_box" colspan=3>
								<input type="text" class="input" id="Indate" name="Indate" readonly value="<%=Indate%>" size=15> 
								<input type="button" class="btn" value="�޷�" onclick="callCalendar(SearchForm.Indate);"> - 
								<input type="text" class="input" id="Outdate" name="Outdate" readonly value="<%=Outdate%>" size=15> 
								<input type="button" class="btn" value="�޷�" onclick="callCalendar(SearchForm.Outdate);"> 
								<a href="javascript:date_input('Indate','Outdate','<%=Date%>','<%=Date%>')">[����]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7����]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30����]</a>
								&nbsp;
								<a href="javascript:date_input('Indate','Outdate','','')">[��¥�ʱ�ȭ]</a>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">���̵�</td>
								<td class="line_box" width="250"><input type="text" class="input" name="AdminId" value="<%=AdminId%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">�̸�</td>
								<td class="line_box"><input type="text" class="input" name="AdminName" value="<%=AdminName%>"></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align=right colspan=2 class="btnArea"><input type="submit" class="btn" value=" �� �� " ></td>
				</tr>

				</form>
				
				<form name="fm" method="POST" action="Admin_03_P.asp">
				<input type="hidden" name="actType" value="">
				<tr>
					<td colspan=2>����ȸ���</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50"><input type="checkbox"></td>
								<td class="line_box" width="12%">ID</td>
								<td class="line_box" width="15%">�̸�</td>
								<td class="line_box" width="15%">�ڵ���</td>
								<td class="line_box">�̸���</td>
								<td class="line_box" width="15%">��������</td>
							</tr>
							<%for iLoop = 0 to cntList
							PageLink = "location.href='Member_03_V.asp?UserIdx=" & arrList(FI_UserIdx, iLoop)
							%>
							<tr height="30" align=center>
								<td class="line_box"><input type="checkbox"></td>
								<td class="line_box" onclick="" style="cursor:hand"><%=arrList(FI_Id,iLoop)%></td>
								<td class="line_box" onclick="" style="cursor:hand"><%=arrList(FI_Name,iLoop)%></td>
								<td class="line_box" onclick="" style="cursor:hand"><%=arrList(FI_Hphone,iLoop)%></td>
								<td class="line_box" onclick="" style="cursor:hand"><%=arrList(FI_Email,iLoop)%></td>
								<td class="line_box" onclick="" style="cursor:hand"><%=arrList(FI_Indate,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>��ϵ� ȸ���� �����ϴ�.</td>
							</tr>
							<%end if%>
						</table>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align=right colspan=2>
						<input type="button" class="btn" value=" �� �� ">
						<input type="button" class="btn" value=" �� �� ">
					</td>
				</tr>
				</form>
				<tr><td height="20"></td></tr>

			</table>

		</td>
	</tr>
</form>
</table>

<!-- #include file = "../inc/bottom.asp" -->