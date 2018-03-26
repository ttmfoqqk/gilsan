<!-- #include file = "../common/Carset_utf8.asp" -->
<!-- #include file = "../common/connectdb.asp" -->
<!-- #include file = "../common/fn.lib.asp" -->
<%
checkLoginPOP()

Dim orderCode : orderCode = Request("orderCode")
Dim seq       : seq       = Request("seq")

Call Expires()
Call dbopen()
	Call view()
Call dbclose()

If FI_ODNO = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 주문번호 입니다.');"
	 .Write "history.back(-1);"
	 .Write "</script>"
	 .End
	End With
End If

'판매처 || 품목 || 품명[강종-표면-품명] || 두께 || 호칭경 || 길이 || 수량
Dim orderKey : orderKey = FI_COCODE & "||" & FI_TYPECODE & "||" & FI_PRODUCT_CODE & "||" & FI_THICK & "||" & FI_EXTDIA & "||" & FI_LENGTH & "||" & FI_QTY

Sub view()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_PRODUCT_ORDER_BASKET_V"
		.Parameters("@ODNO").value = orderCode
		.Parameters("@SEQ").value  = seq
		.Parameters("@ID").value   = session("userId")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 길산파이프(주) </title>
<meta name="Generator" content="EditPlus">
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1000">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script type="text/javascript" src="../common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/JavaScript" src="../common/js/common.js"></script>
<script type="text/JavaScript" src="../inc/js/default.js"></script>
<link rel="stylesheet" type="text/css" href="../inc/css/default.css">
</head>

<body>

<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<STYLE type="text/css">
html {overflow:hidden;} 
body{
	min-width:800px;overflow-X:hidden;
}
.close{
	background:url(../../img/btn_close_big.gif) no-repeat;width:31px;height:31px;display:inline-block;position:absolute;top:0;right:30px;
}
.row{height:40px;}
</STYLE>
<div id="middle_sub" style="margin:0px;padding:0px;">

	
		
		<div id="contant" style="float:none;margin:0px auto;padding:0px;">
			<h3 class="title" style="margin-top:30px;">주문 수정</h3>
			<a href="#" class="close" onclick="window.close();"><span class="blind">닫기</span></a>


			<div style="float:left;width:50%;">
				<div style="margin-right:10px;"><button type="button" class="old_reserve_btn" onclick="loading_old_reserve(50);"><span>최근 거래현황 불러오기</span></button></div>
			</div>
			<div style="float:left;width:50%;">
				<div style="margin-right:10px;"><button type="button" class="old_reserve_btn" onclick="loading_favorites(50);"><span>자주 사용하는 거래현황 불러오기</span></button></div>
			</div>
			
			
			
			<form name="mForm" id="mForm" method="post" action="pop_modify_proc.asp" onsubmit="return check()">
			
			<input type="hidden" id="orderCode" name="orderCode" value="<%=FI_ODNO%>">
			<input type="hidden" id="seq" name="seq" value="<%=seq%>">
			<input type="hidden" id="companyCode" name="companyCode" value="<%=FI_COCODE%>">
			<input type="hidden" id="itemCode" name="itemCode" value="">
			<input type="hidden" id="productCode" name="productCode" value="">
			<input type="hidden" id="thickCode" name="thickCode" value="">
			<input type="hidden" id="widthCode" name="widthCode" value="">

			<div class="form_wrap" style="width:730px;">

				<!--div class="row" style="z-index:100;">
					<label style="width:122px;">판매처 <span class="color_red">*</span></label>
					<div id="company">로딩중입니다..</div>
				</div-->


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
					<input type="number" id="length" name="length" class="input" style="width:150px;text-align:right;" maxlength="12" min="0" onkeydown="onlyNum();"> mm
				</div>

				<div class="row" style="z-index:40;">
					<label style="width:122px;">수량 <span class="color_red">*</span></label>
					<input type="number" id="qty" name="qty" class="input" style="width:150px;text-align:right;" maxlength="12" min="0" onkeydown="onlyNum();"> EA
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
				<button type="submit" class="btn">수정</button>

				<button type="button" onclick="window.close();" class="btn">닫기</button>
			</div>

			</form>
		</div>

</div>

<!-- wall/popup/loading -->
<div class="wall"></div>
<div id="more_pop" class="order_pop">
	<div class="wrap">
		<div class="title">
			<h3>최근 거래현황</h3>

			<div style="position:absolute;top:5px;right:50px;">
				<form name="form_more_pop" id="form_more_pop" method="GET">
				<div class="row">
					<label style="margin-right:10px;font-size:14px;">주문일자 </label>
					<input type="text" id="more_indate" name="more_indate" class="input" style="width:80px;padding:0px;" onclick="callCalendar(form_more_pop.more_indate);" readonly maxlength="10">
					<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.more_indate);" style="vertical-align:top;height:30px;cursor:pointer;">
					~
					<input type="text" id="more_outdate" name="more_outdate" class="input" style="width:80px;padding:0px;" onclick="callCalendar(form_more_pop.more_outdate);" readonly maxlength="10">
					<img src="../_admin/img/center_icon_carender.gif" onclick="callCalendar(form_more_pop.more_outdate);" style="vertical-align:top;height:30px;cursor:pointer;">

					<button type="button" class="btn" onclick="getMyOrder('old')" style="height:30px;width:50px;">검색</button>
					<button type="button" class="btn" onclick="$('#more_indate').val('');$('#more_outdate').val('');" style="height:30px;width:50px;">초기화</button>
				</div>
				</form>
			</div>

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
<SCRIPT type="text/javascript">
	action_myOrder('<%=orderKey%>');
</SCRIPT>

<body>
</html>