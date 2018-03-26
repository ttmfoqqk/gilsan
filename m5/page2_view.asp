<!-- #include file="../inc/top.asp" -->
<%
checkLogin(g_host & g_url)
Dim idx        : idx        = IIF( request("idx")="","0",request("idx") )
Dim pageNo     : pageNo     = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim PageParams : PageParams = "pageNo=" & pageNo

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

If FI_Idx = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 경로입니다.');"
	 .Write "history.back(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_BOARD_CONT_V"
		.Parameters("@Idx").value      = idx
		.Parameters("@BoardKey").value = 20
		.Parameters("@actType").value  = "VIEW"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">

<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">SALES</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">SALES</h3>

			<form name="AdminForm" id="AdminForm" method="POST" action="page2_proc.asp" enctype="multipart/form-data">
			<input type="hidden" name="actType" id="actType" value="">
			<input type="hidden" name="Idx" value="<%=FI_Idx%>">

			<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">


			<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:14px;line-height:150%;margin-bottom:10px;">
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:125px;padding-left:15px;background-color:#fafafa;">제목</td>
					<td style="border-bottom:1px solid #4f4f4f;background-color:#fafafa;"><%= TagDecode( FI_Title )%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;color:#85868a;padding-left:15px;" colspan="2"><%=FI_ContName%> | <%=FI_Indate%> | Views <%=FI_Read_cnt%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;padding:20px 0px 20px 15px;" valign="top">내용</td>
					<td style="border-bottom:1px solid #4f4f4f;padding:20px 0px 20px 0px;">
						<%=FI_Contants%>
					</td>
				</tr>
				<%If FI_File_name <> "" Then %>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;color:#85868a;padding-left:15px;" colspan="2"><a href="../common/download.asp?pach=/upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a></td>
				</tr>
				<%End If%>

			</table>
			
			<div style="text-align:right;margin-bottom:10px;">
				<button class="btn_bg" type="button" style="width:80px;float:left;margin:0px;" onclick="location.href='page2.asp?<%=PageParams%>'">목록보기</button>
				<%If FI_AdminIdx = 0 And FI_UserId = session("userId") Then %>
				<button class="btn_bg" type="button" style="width:80px;" onclick="location.href='page2_write.asp?<%=PageParams%>&idx=<%=idx%>&actType=mody'">수정</button>
				<button class="btn_bg" type="button" style="width:80px;" onclick="check();">삭제</button>
				<%End If%>
			</div>

			</form>

		</div>
	</div>


</div>
<script type="text/javascript">
function check(){
	var fm = document.AdminForm;
	if(confirm("삭제 하시겠습니까?")){
		$('#actType').val('DELETE');
		$('#AdminForm').submit();
	}
}

</script>
<!-- #include file="../inc/footer.asp" -->