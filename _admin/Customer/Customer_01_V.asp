<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrList , arrComment
Dim cntList    : cntList    = -1
Dim cntComment : cntComment = -1
Dim cntTotal   : cntTotal   = 0
Dim rows       : rows       = 20
Dim pageNo     : pageNo     = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName   : UserName   = request("UserName")
Dim UserId     : UserId     = request("UserId")
Dim Indate     : Indate     = request("Indate")
Dim Outdate    : Outdate    = request("Outdate")
Dim BoardKey   : BoardKey   = request("BoardKey")
Dim tap        : tap        = IIF( request("tap")="",0,request("tap") )
Dim Title      : Title      = request("Title")

Dim Idx        : Idx        = IIF( request("Idx")="" , 0 , request("Idx") )

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&tap="      & tap &_
		"&Title="    & Title


Call Expires()
Call dbopen()
	Call BoardCodeList()
	BoardKey = IIF( BoardKey="" , BC_FIRST_KEY , BoardKey )
	Call BoardCodeView()
	Call GetList()
Call dbclose()


Sub BoardCodeList()
'왼쪽메뉴용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CODE_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "BoardCode")
	If NOT(objRs.BOF or objRs.EOF) Then
		BC_ARRY_LIST = objRs.GetRows()
		BC_CNT_LIST  = UBound(BC_ARRY_LIST, 2)
		BC_FIRST_KEY = BC_ARRY_LIST(BoardCode_Idx, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub


Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_V"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = BoardKey
		.Parameters("@Comment").value  = BoardCodeView_CommentFg
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<style type="text/css">
.Commonbox{clear:both;width:100%;border-bottom:1px solid #dbdbdb;}
.repArea{clear:both;width:100%;}
</style>
<script type="text/javascript">
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}

</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		<%
		If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then 
			Response.write "잘못된 게시판 코드 입니다."
		ElseIf FI_Idx = "" Then 
			Response.write "내용이 없습니다."
		Else 
		%>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="Customer_01_P.asp" enctype="multipart/form-data">
				<input type="hidden" name="actType" value="">
				<input type="hidden" name="Idx" id="Idx" value="<%=FI_Idx%>">
				<input type="hidden" name="UserIdx" value="<%=FI_UserIdx%>">
				<input type="hidden" name="BoardKey" id="boardKey" value="<%=BoardKey%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed">
							<%If BoardKey = "22" Or BoardKey = "23" Or BoardKey = "24" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">카테고리</td>
								<td class="line_box" style="word-break:break-all"><%=FI_cateName%></td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성자</td>
								<td class="line_box" style="word-break:break-all"><%=FI_ContName%></td>
							</tr>
							<%If BoardKey = "20" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이메일</td>
								<td class="line_box" style="word-break:break-all"><%=FI_email%></td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box" style="word-break:break-all"><%=TagDecode( FI_Title )%></td>
							</tr>
					
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box" style="word-break:break-all" height="300" valign=top><%=FI_Contants%></td>
							</tr>
							<%If BoardKey <> "19" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">첨부파일</td>
								<td class="line_box" style="word-break:break-all"><a href="../../common/download.asp?pach=/upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a></td>
							</tr>
							<%End If%>
							<%If BoardKey = "25" Or BoardKey = "26" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box" style="word-break:break-all"><%=FI_order%></td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">등록일</td>
								<td class="line_box" style="word-break:break-all"><%=FI_Indate%></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="Customer_01_W.asp?<%=PageParams%>&Idx=<%=Idx%>"><img src="../img/center_btn_edite.gif"></a>
						<%If BoardCodeView_Replylfg = "1" And FI_Depth_no < 1 Then %>
						<a href="Customer_01_W.asp?<%=PageParams%>&Idx=<%=Idx%>&actType=ANS"><img src="../img/center_btn_Replyl.gif"></a>
						<%End If%>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
						<a href="Customer_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>

			</table>

			</form>


			<%If BoardKey = "27" Then %>
			<!-- 댓글 -->
			<STYLE type="text/css">
				#updateCommentWrap{position:absolute;top:-5px;left:-135px;height:70px;background-color:#eeeeee;border-bottom:1px solid #000000;z-index:100;padding:10px 0px 10px 0px;}
				.board_table{border-top:2px solid #4f4f4f;width:100%;font-size:12px;line-height:150%;margin-bottom:10px;}
				.board_table td{border-bottom:1px solid #4f4f4f;padding:5px 0px 5px 0px;}
			</STYLE>

			<div style="margin-bottom:20px;margin-top:10px;clear:both;">
				<textarea id="comment_input" class="input" style="width:660px;height:53px;line-height:120%;vertical-align:top;"></textarea>&nbsp;
				<button id="comment_submit" class="btn" style="width:100px;height:54px;background-color:#999999;">전송</button>
			</div>			
			<table cellpadding="0" cellspacing="0" class="board_table" id="comment_list">
				<tr>
					<td align="center">로딩중입니다.</td>
				</tr>
			</table>
			<center>
				<div class="page_wrap" id="comment_page"></div>
			</center>
			<script type="text/JavaScript" src="comment.admin.js"></script>
			<!-- 댓글 -->
			<%End If%>


		<%End If%>
		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->