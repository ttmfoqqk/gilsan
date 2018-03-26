<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )
Dim mname    : mname    = request("mname")
Dim userId   : userId   = request("userId")
Dim usFg     : usFg     = request("usFg")
Dim userFg   : userFg   = request("userFg")
Dim inDate   : inDate   = request("inDate")
Dim outDate  : outDate  = request("outDate")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&mname=" & mname &_
		"&userId=" & userId &_
		"&usFg=" & usFg &_
		"&userFg=" & userFg &_
		"&inDate=" & inDate &_
		"&outDate=" & outDate

Call Expires()
Call dbopen()
	Call GetView()
Call dbclose()

Sub GetView()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_PRODUCT_V"
		.Parameters("@Idx").value = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<script type="text/javascript">
function save(){
	if( !trim( $('#name').val() ) ){
		alert('분류명을 입력해주세요.');
		return false;
	}
	if( !trim( $('#order').val() ) ){
		alert('순서를 입력해주세요.');
		return false;
	}
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_03_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 제품관리 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form name="AdminForm" method="POST" action="product_01_P.asp" enctype="multipart/form-data" onsubmit="return submitContents();">
				<input type="hidden" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="idx" value="<%=FI_idx%>">
				<input type="hidden" name="smname" value="<%=mname%>">
				<input type="hidden" name="susFg" value="<%=usFg%>">
				<input type="hidden" name="suserFg" value="<%=userFg%>">
				<input type="hidden" name="suserId" value="<%=userId%>">
				<input type="hidden" name="sinDate" value="<%=inDate%>">
				<input type="hidden" name="soutDate" value="<%=outDate%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성자</td>
								<td class="line_box">
								<%
									Dim writer : writer = ""

									If FI_idx = "" Then 
										writer = "관리자 ["& Session("Admin_Id") &"]"
									Else
										If FI_userFg = "1" Then 
											writer = "관리자"
										ElseIf FI_userFg = "2" Then 
											writer = "sk data ["& FI_userId &"]"
										Else
											writer = "일반회원 ["& FI_userId &"]"
										End If										
									End If

									Response.write writer
								%></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">API명</td>
								<td class="line_box"><input type="text" style="width:100%" id="mname" name="mname" class="input" value="<%= TagDecode( FI_name )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">설명</td>
								<td class="line_box">
									<textarea name="contants" id="contants" style="width:100%;height:300px;display:none;"><%=FI_description%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box"><input type="text" id="order" name="order" class="input" size="7" maxlength="7" onkeyup="onlyNumber(this)" value="<%=IIF(FI_order="",0,FI_order)%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select id="usFg" name="usFg">
										<option value="0" <%=IIF( FI_usFg = "0" , "selected" , "" )%>>사용</option>
										<option value="1" <%=IIF( FI_usFg = "1" , "selected" , "" )%>>미사용</option>
									</select>
								</td>
							</tr>
							
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_write_ok.gif">
						<a href="product_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>

</table>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contants",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function submitContents() {
	var form=document.AdminForm;
	if( !trim( form.mname.value ) ){
		alert("API명을 입력하세요.");
		return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	//document.getElementById("content").value
	try {
		//form.submit();
	} catch(e) {}
}

</script>
<!-- #include file = "../inc/bottom.asp" -->