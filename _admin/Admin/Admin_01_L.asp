<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Call Expires()
Call dbopen()
	Call AgreeView()
Call dbclose()

Sub AgreeView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_COMM_AGREE_V"
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

		<form name="AdminForm" method="post" action="Admin_01_P.asp">
		
			<table cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_01_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > �������</td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_01_01_01.gif"></td>
				</tr>
				<tr>
					<td colspan=2 class="line_box" height="300">
						<textarea name="Agree1" id="Agree1" rows="10" cols="100" style="width:100%;height:300px;display:none;"><%=FI_Agree1%></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_01_01_02.gif"></td>
				</tr>
				<tr>
					<td colspan=2 class="line_box" height="300">
						<textarea name="Agree2" id="Agree2" rows="10" cols="100" style="width:100%;height:300px;display:none;"><%=FI_Agree2%></textarea>
					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2 class="btnArea"><img src="../img/center_btn_write_ok.gif" onclick="submitContents()" style="cursor:pointer;"></td>
				</tr>
			</table>
		
		</form>

		</td>
	</tr>
</table>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Agree1",
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

var oEditors2 = [];
nhn.husky.EZCreator2.createInIFrame({
	oAppRef: oEditors2,
	elPlaceHolder: "Agree2",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors2.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function submitContents(elClickedObj) {
	var form=document.AdminForm;
	$('.btnArea').html("ó�����Դϴ�.");
	oEditors.getById["Agree1"].exec("UPDATE_CONTENTS_FIELD", []);	// �������� ������ textarea�� ����˴ϴ�.
	oEditors2.getById["Agree2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	// �������� ���뿡 ���� �� ������ �̰����� document.getElementById("content").value�� �̿��ؼ� ó���ϸ� �˴ϴ�.
	
	try {
		form.submit();
	} catch(e) {}
}

</script>
<!-- #include file = "../inc/bottom.asp" -->