<HTML>
  <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
 <HEAD>
  <TITLE> ������ ������ �Դϴ�. </TITLE>
  <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
  <META http-equiv="imagetoolbar" content="no">
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <script type="text/javascript" src="../../common/js/common.js"></script>
  <script type="text/javascript" src="../../common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
  <link href="../common/css/admin.css" rel="stylesheet" type="text/css" />
 </HEAD>

<BODY topmargin=0 leftmargin=0>
<script type="text/javascript">
$(function(){
	$('#familySite').change(function(){
		var values = $(this).val();
		if(values){
			if( values == 'HOME' ){
				values = 'http://' + document.domain;
			}
			window.open(values,"","");
		}
		$(this).val('');
	});
});
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center>
	<tr>
		<td width="220" rowspan=2><img src="../img/logo.gif"></td>
		<td height="30" align=right>
			<a href="../logout.asp"><img src="../img/top_btn_logout.gif" align=absmiddle></a>
			<select class="input" id="familySite" align=absmiddle>
				<option value="">::: Community Site :::</option>
				<option value="HOME"> Ȩ������ �ٷΰ��� </option>
			</select>
			<!--a href="javascript:void(alert('�غ����Դϴ�.'))"><img src="../img/top_btn_site.gif" align=absmiddle></a-->
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding=0 cellspacing=0 width="100%">
				<tr align="center">
					<td style="width:20%"><a href="../Admin/Admin_01_L.asp"><img src="../img/top_01<%=IIF(AdminTopmode=1,"_o","")%>.gif"></a></td>
					<td style="width:20%"><a href="../info/info_01_L.asp" ><img src="../img/top_02<%=IIF(AdminTopmode=2,"_o","")%>.gif"></a></td>
					<td style="width:20%"><a href="../staff/staff_01_L.asp"><img src="../img/top_03<%=IIF(AdminTopmode=3,"_o","")%>.gif"></a></td>
					<td style="width:20%"><a href="../Member/Member_01_L.asp"><img src="../img/top_04<%=IIF(AdminTopmode=4,"_o","")%>.gif"></a></td>
					<td style="width:20%"><a href="../Customer/Customer_01_L.asp"><img src="../img/top_05<%=IIF(AdminTopmode=5,"_o","")%>.gif"></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div style="height:7px;background-color:#0172c9;overflow:hidden;"><!----></div>
<div style="height:2px;background-color:#96c6fc;overflow:hidden;"><!----></div>