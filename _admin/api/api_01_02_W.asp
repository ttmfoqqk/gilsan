<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrCate
Dim cntCate  : cntCate  = -1

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = request("idx")
Dim pname    : pname    = request("pname")
Dim tag      : tag      = request("tag")
Dim parent   : parent   = request("parent")
Dim usFg     : usFg     = request("usFg")
Dim inDate   : inDate   = request("inDate")
Dim outDate  : outDate  = request("outDate")


Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&pname=" & pname &_
		"&tag=" & tag &_
		"&parent=" & parent &_
		"&usFg=" & usFg &_
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
		.CommandText      = "KETI_API_PLATFORM_V"
		.Parameters("@Idx").value = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")

	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "CATE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrCate		= objRs.GetRows()
		cntCate		= UBound(arrCate, 2)
	End If

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
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 플랫폼 API 관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form name="AdminForm" method="POST" action="api_01_02_P.asp" enctype="multipart/form-data" onsubmit="return submitContents();">
				<input type="hidden" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="idx" value="<%=FI_idx%>">
				<input type="hidden" name="pageNo" value="<%=pageNo%>">
				<input type="hidden" name="spname" value="<%=pname%>">
				<input type="hidden" name="stag" value="<%=tag%>">
				<input type="hidden" name="susFg" value="<%=usFg%>">
				<input type="hidden" name="sinDate" value="<%=inDate%>">
				<input type="hidden" name="soutDate" value="<%=outDate%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">플랫폼명</td>
								<td class="line_box">
									<select name="parent">
										<option value="">선택</option>
										<%for iLoop = 0 to cntCate%>
										<option value="<%=arrCate(CATE_idx,iLoop)%>" <%=IIF( CStr(arrCate(CATE_idx,iLoop)) = FI_parentIdx , "selected" , "" )%>><%=arrCate(CATE_name,iLoop)%></option>
										<%Next%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">AIP명</td>
								<td class="line_box"><input type="text" style="width:100%" id="pname" name="pname" class="input" value="<%= TagDecode( FI_apiName )%>"></td>
							</tr>

							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Method</td>
								<td class="line_box"><input type="text" style="width:100%" id="Method" name="Method" class="input" value="<%= TagDecode( FI_Method )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Url</td>
								<td class="line_box"><input type="text" style="width:100%" id="Url" name="Url" class="input" value="<%= TagDecode( FI_Url )%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Url Parameter</td>
								<td class="line_box"><input type="text" style="width:100%" id="UrlParameter" name="UrlParameter" class="input" value="<%= TagDecode( FI_UrlParameter )%>"></td>
							</tr>
							
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">설명</td>
								<td class="line_box">
									<textarea name="contants" id="contants" style="width:100%;height:200px;display:none;"><%=TagEncode(FI_description)%></textarea>
								</td>
							</tr>

							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Header</td>
								<td class="line_box">
									<textarea name="Header" id="Header" style="width:100%;height:200px;display:none;"><%=TagEncode(FI_Header)%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Body Attribute</td>
								<td class="line_box">
									<textarea name="BodyAttribute" id="BodyAttribute" style="width:100%;height:200px;display:none;"><%=TagEncode(FI_BodyAttribute)%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">Body</td>
								<td class="line_box">
									<textarea name="Body" id="Body" style="width:100%;height:200px;display:none;"><%=TagEncode(FI_Body)%></textarea>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">예제</td>
								<td class="line_box">
									<textarea name="sample" id="sample" style="width:100%;height:200px;display:none;"><%=TagEncode(FI_sample)%></textarea>
								</td>
							</tr>


							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">검색키워드</td>
								<td class="line_box"><input type="text" style="width:100%" id="tag" name="tag" class="input" value="<%= TagDecode( FI_tag )%>"></td>
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
					<td align=center colspan=2 class="btnArea">
						<input type="image" src="../img/center_btn_write_ok.gif">
						<a href="api_01_02_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
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
		//oEditors.getById["contants"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

var oEditors2 = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors2,
	elPlaceHolder: "Header",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors2.getById["Header"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

var oEditors3 = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors3,
	elPlaceHolder: "BodyAttribute",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors3.getById["BodyAttribute"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

var oEditors4 = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors4,
	elPlaceHolder: "Body",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors4.getById["Body"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

var oEditors5 = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors5,
	elPlaceHolder: "sample",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors5.getById["sample"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function submitContents() {
	var form=document.AdminForm;
	if( !trim( form.parent.value ) ){
		alert("플랫폼을 선택하세요.");
		return false;
	}
	if( !trim( form.pname.value ) ){
		alert("API명을 입력하세요.");
		return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	oEditors2.getById["Header"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	oEditors3.getById["BodyAttribute"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	oEditors4.getById["Body"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	oEditors5.getById["sample"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	//document.getElementById("content").value
	try {
		//form.submit();
	} catch(e) {}
}

</script>
<!-- #include file = "../inc/bottom.asp" -->