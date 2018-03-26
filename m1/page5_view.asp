<!-- #include file="../inc/top.asp" -->
<%

Dim idx        : idx        = IIF( request("idx")="","0",request("idx") )
Dim pageNo     : pageNo     = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim tap        : tap        = IIF(request("tap")="","1",request("tap"))
Dim PageParams : PageParams = "pageNo=" & pageNo & "&tap=" & tap

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
		.CommandText      = "M_BOARD_CONT_V"
		.Parameters("@Idx").value      = idx
		.Parameters("@BoardKey").value = 23
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
			<span class="home">H</span><span class="block1">고객센터</span><span class="block2">골프 갤러리</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">골프 갤러리</h3>

			<form name="AdminForm" id="AdminForm" method="POST" action="page5_proc.asp" enctype="multipart/form-data">
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
						<%
							If FI_File_name = "" Then 
								img = ""
							Else
								if FILE_CHECK_EXT( FI_File_name ) Then 
									img = "<img src=""../upload/board/"& FI_File_name &""" style=""width:100%;""><br><br>"
								Else
									img = ""
								End If
							End If
							Response.write img
						%>
						<%=FI_Contants%>
					</td>
				</tr>
			</table>
			
			<div style="text-align:right;margin-bottom:10px;">
				<button class="btn_bg" type="button" style="width:80px;float:left;margin:0px;" onclick="location.href='page5.asp?<%=PageParams%>'">목록보기</button>
				<%If FI_AdminIdx = "0" And FI_UserIdx = session("userIdx") Then %>
				<button class="btn_bg" type="button" style="width:80px;" onclick="location.href='page5_write.asp?<%=PageParams%>&idx=<%=idx%>&actType=mody'">수정</button>
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