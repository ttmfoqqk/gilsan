<!-- #include file="../inc/top.asp" -->
<%
Response.redirect "page1_1.asp"

checkLogin( g_host & g_url )

Dim orderCode   : orderCode   = Request.Form("orderCode")
Dim companyCode : companyCode = Request.Form("companyCode")

Call Expires()
Call dbopen()
	Call check()
Call dbclose()

Sub check()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_ODNO_CHECK"
		.Parameters("@ODNO").value = orderCode
		.Parameters("@ID").value   = session("userId")
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
			<span class="home">H</span><span class="block1">온라인주문</span><span class="block2">온라인주문</span>
		</div>
	</div>

	<STYLE type="text/css">
		.row{height:40px;}
	</STYLE>
	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">온라인주문</h3>

			<div style="float:left;width:50%;">
				<div style="margin-right:10px;"><button type="button" class="old_reserve_btn" onclick="loading_old_reserve();"><span>최근 거래현황 불러오기</span></button></div>
			</div>
			<div style="float:left;width:50%;">
				<div style="margin-right:10px;"><button type="button" class="old_reserve_btn" onclick="loading_favorites();"><span>자주 사용하는 거래현황 불러오기</span></button></div>
			</div>
			
			
			
			<!--form name="mForm" id="mForm" method="post" action="page1_proc.asp" onsubmit="return check()"-->
			<form name="mForm" id="mForm" method="post" action="page1_proc.asp" onsubmit="alert('준비중입니다.');return false;">
			
			<input type="hidden" id="orderCode" name="orderCode" value="<%=IIF( FI_CHECK > 0 , orderCode , "" )%>">
			<input type="hidden" id="companyCode" name="companyCode" value="<%=IIF( FI_CHECK > 0 , companyCode , "" )%>">
			<input type="hidden" id="itemCode" name="itemCode" value="">
			<input type="hidden" id="productCode" name="productCode" value="">
			<input type="hidden" id="thickCode" name="thickCode" value="">
			<input type="hidden" id="widthCode" name="widthCode" value="">

			<div class="form_wrap" style="width:730px;">
				<%If FI_CHECK = "0" Then %>
				<div class="row" style="z-index:100;">
					<label style="width:122px;">판매처 <span class="color_red">*</span></label>
					<div id="company">로딩중입니다..</div>
				</div>
				<%End If%>

				<div class="row" style="z-index:90;">
					<label style="width:122px;">품목구분 <span class="color_red">*</span></label>
					<div id="item">로딩중입니다..</div>
				</div>

				<div class="row" style="z-index:80;">
					<label style="width:122px;">품명 <span class="color_red">*</span></label>
					<div id="product" style="font-size:14px;">품목을 선택해주세요.</div>
				</div>

				<div class="row" style="z-index:70;">
					<label style="width:122px;">두께 <span class="color_red">*</span></label>
					<div id="thick" style="font-size:14px;">품명을 선택해주세요.</div>
				</div>

				<div class="row" style="z-index:60;">
					<label style="width:122px;">호칭경 <span class="color_red">*</span></label>
					<div id="width" style="font-size:14px;">두께를 선택해주세요.</div>
				</div>

				<div class="row" style="z-index:50;">
					<label style="width:122px;">길이 <span class="color_red">*</span></label>
					<input type="number" id="length" name="length" class="input" style="width:150px;text-align:right;" maxlength="12" min="0"> M
				</div>

				<div class="row" style="z-index:40;">
					<label style="width:122px;">수량 <span class="color_red">*</span></label>
					<input type="number" id="qty" name="qty" class="input" style="width:150px;text-align:right;" maxlength="12" min="0"> EA
				</div>

				<%If FI_CHECK = "0" Then %>
				<div class="row" style="z-index:30;">
					<label style="width:122px;">희망납기일 <span class="color_red">*</span></label>
					<input type="text" id="duedate" name="duedate" class="input" style="width:150px;" onclick="callCalendar(mForm.duedate);" readonly maxlength="10">
					<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(mForm.duedate);" style="vertical-align:top;height:32px;cursor:pointer;">
				</div>

				<div class="row" style="z-index:20;">
					<label style="width:122px;">하차장소 </label>
					<input type="text" id="unloadplace" name="unloadplace" class="input" style="width:450px;ime-mode:active;vertical-align:middle;" maxlength="200">
					&nbsp;<button type="button" class="btn" onclick="pop_unloadplace()" style="height:32px;width:70px;vertical-align:middle;">불러오기</button>
				</div>

				<div class="row" style="z-index:10;">
					<label style="width:122px;">기타사항</label>
					<input type="text" id="remark" name="remark" class="input" style="width:527px;ime-mode:active;" maxlength="200">
				</div>
				<%End If%>

			</div>
			
			<div style="margin:30px;text-align:center;" id="submit_area">
				<button type="submit" class="btn"><%=IIF(FI_CHECK="0","주문하기","추가 주문하기")%></button>
			</div>

			</form>
		</div>
	</div>
</div>

<!-- wall/popup/loading -->
<div class="wall" style="display:none;"></div>
<div id="more_pop" class="order_pop">
	<div class="wrap">
		<div class="title">
			<h3>최근 거래현황</h3>
			<a href="#" onclick="close_old_reserve();return false;"><span class="blind">닫기</span></a>
		</div>

		<table class="reserve_table" cellpadding="0" cellspacing="0">
			<tr>
				<th style="width:50px;">번호</th>
				<th style="width:100px;">품목구분</th>
				<th>품명</th>
				<th style="width:40px;">두께</th>
				<th style="width:40px;">호칭경</th>
				<th style="width:50px;">길이</th>
				<th style="width:50px;">수량</th>
				<th style="width:70px;">주문상태</th>
				<th style="width:70px;">주문일자</th>
				<th style="width:70px;">즐겨찾기</th>
			</tr>
			<tr class="list">
				<td colspan="10">로딩중입니다.</td>
			</tr>
		</table>
		
		<center>
			<div class="page_wrap"></div>
		</center>
	</div>
</div>

<div id="favorites_pop" class="order_pop">
	<div class="wrap">
		<div class="title">
			<h3>자주 사용하는 거래현황</h3>
			<a href="#" onclick="close_old_reserve();return false;"><span class="blind">닫기</span></a>
		</div>

		<table class="reserve_table" cellpadding="0" cellspacing="0">
			<tr>
				<th style="width:50px;">번호</th>
				<th style="width:100px;">품목구분</th>
				<th>품명</th>
				<th style="width:40px;">두께</th>
				<th style="width:40px;">호칭경</th>
				<th style="width:50px;">길이</th>
				<th style="width:50px;">수량</th>
				<th style="width:70px;">등록일자</th>
				<th style="width:70px;">삭제</th>
			</tr>
			<tr class="list">
				<td colspan="9">로딩중입니다.</td>
			</tr>
		</table>
		
		<center>
			<div class="page_wrap"></div>
		</center>
	</div>
</div>

<div id="loading">적용중입니다.</div>
<!-- wall/popup/loading -->

<script type="text/JavaScript" src="order.js"></script>
<!-- #include file="../inc/footer.asp" -->