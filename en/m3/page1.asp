<!-- #include file="../inc/top.asp" -->
<%
Dim tap   : tap   = IIF( request("tap")="" , "1" , request("tap") )
Dim title : title = "Gilsan Pipe Co., LTD."
Dim img   : img   = "<img src=""../img/img_03_01_01.jpg"">"
Dim addr  : addr  = "7-24, Gamgok 1-gil, Bujeok-myeon, Nonsan-si, Chungcheongnam-do, Korea"
Dim item  : item  = "SHeet&Coil, STS Pipe, STS Round Rod, Plain STS, Angular STS, STS Transmitting Pipe"
Dim tel   : tel   = "041-732-9994"
Dim fax   : fax   = "041-732-9997"
Dim site  : site  = "www.gilsan.co.kr"



'//////////////////////////////////////////////
'	길산파이프(주)
'	네이버약도, 구글약도 URL 입니다.
'	수정시 유의바랍니다.
'//////////////////////////////////////////////
Dim url_naver  : url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2065760&lng=127.1678130&query=7Lap7LKt64Ko64%2BEIOuFvOyCsOyLnCDrtoDsoIHrqbQg6rCQ6rOhMeq4uCA3LTI0&type=ADDRESS&tab=1&enc=b64','','')"
Dim url_google : url_google = "window.open('http://goo.gl/maps/BqRh7','','')"


If tap = "1" Then
	title = "Gilsan Pipe Co., LTD."
	img   = "<img src=""../img/img_03_01_01.jpg"">"
	addr  = "7-24, Gamgok 1-gil, Bujeok-myeon, Nonsan-si, Chungcheongnam-do, Korea"
	item  = "STS Pipe, STS Round Rod, Plain STS, Angular STS, STS Transmitting Pipe"
	tel   = "041-732-9994"
	fax   = "041-732-9997"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산파이프(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2065760&lng=127.1678130&query=7Lap7LKt64Ko64%2BEIOuFvOyCsOyLnCDrtoDsoIHrqbQg6rCQ6rOhMeq4uCA3LTI0&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/BqRh7','','')"

ElseIf tap = "2" Then 
	title = "Gilsan Steel Co., LTD."
	img   = "<img src=""../img/img_03_01_02.jpg"">"
	addr  = "25-46, Je1sandan-ro, Duma-myeon, Gyeryong-si, Chungcheongnam-do, Korea"
	item  = "SHeet&Coil, Plain STS, Angular STS, STS Transmitting Pipe, STS Square Rod, STS Anchor"
	tel   = "042-551-9994"
	fax   = "042-551-9997"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산스틸(주) 계룡본사
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2512069&lng=127.2742671&query=7Lap7LKt64Ko64%2BEIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng%3D%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qrvSD','','')"

ElseIf tap = "3" Then 
	title = "Gilsan Steel Co., LTD. Daejeon Branch"
	img   = "<img src=""../img/img_03_01_03.jpg"">"
	addr  = "296, Daejeoncheonbuk-ro, Daedeok-gu, Daejeon, Korea"
	item  = "SHeet&Coil, Plain STS, Angular STS, STS Transmitting Pipe, STS Square Rod, STS Anchor"
	tel   = "042-621-1600"
	fax   = "042-623-0100"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산스틸(주) 대전지점
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3513321&lng=127.4053478&query=64yA7KCE6rSR7Jet7IucIOuMgOuNleq1rCDrjIDsoITsspzrtoHroZwgMjk2&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/MZZmJ','','')"

ElseIf tap = "4" Then 
	title = "Gilsan Steel Co., LTD. Gwangju Branch"
	img   = "<img src=""../img/img_03_01_04.jpg"">"
	addr  = "599, Hanam-daero, Buk-gu, Gwangju, Korea"
	item  = "SHeet&Coil, Plain STS, Angular STS, STS Transmitting Pipe, STS Square Rod, STS Anchor"
	tel   = "062-511-9994"
	fax   = "062-512-9996"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산스틸(주) 광주지점
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=35.1734465&lng=126.8586590&query=6rSR7KO86rSR7Jet7IucIOu2geq1rCDtlZjrgqjrjIDroZwgNTk5&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/dHnHm','','')"

ElseIf tap = "5" Then 
	title = "Gilsan ST Co., LTD"
	img   = "<img src=""../img/img_03_01_05.jpg"">"
	addr  = "98, Woram-ro, Baekseok-eup, Yangju-si, Gyeonggi-do, Korea"
	item  = "STS Pipe, STS Round Rod, Plain STS, Angular STS, STS Transmitting Pipe"
	tel   = "031-855-9990"
	fax   = "031-829-9936"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산에스티(주)
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.8032557&lng=126.9569557&query=6rK96riw64%2BEIOyWkeyjvOyLnCDrsLHshJ3snY0g7JuU7JWU66GcIDk4&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/UIEru','','')"

ElseIf tap = "6" Then 
	title = "Gilsan ST Co., LTD  Coil Center"
	img   = "<img src=""../img/img_03_01_06.jpg"">"
	addr  = "68-5, Yeongok-ro, Baekseok-eup, Yangju-si, Gyeonggi-do, Korea"
	item  = "SHeet&Coil, Plain STS, Angular STS, STS Transmitting Pipe, STS Square Rod, STS Anchor"
	tel   = "031-872-9994"
	fax   = "031-872-9935"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산에스티(주) 코일센터
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.8073603&lng=126.9653940&query=6rK96riw64%2BEIOyWkeyjvOyLnCDrsLHshJ3snY0g7Jew6rOh66GcIDY4LTU%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qvqHM','','')"

ElseIf tap = "7" Then 
	title = "Gilsan SST Co., LTD"
	img   = "<img src=""../img/img_03_01_07.jpg"">"
	addr  = "182, Somanggongwon-ro, Siheung-si, Gyeonggi-do, Korea"
	item  = "STS Pipe, STS Round Rod, Plain STS, Angular STS, STS Transmitting Pipe"
	tel   = "031-498-9994"
	fax   = "031-496-9993"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	길산에스에스티(주)
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.3354633&lng=126.7190478&query=6rK96riw64%2BEIOyLnO2dpeyLnCDsoJXsmZXrj5kgMTI2NS05&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/lzTJY','','')"

ElseIf tap = "8" Then 
	title = "Gilsan Golf Club Co., LTD Wonnaedong "
	img   = "<img src=""../img/img_03_01_08.jpg"">"
	addr  = "933-59, Gyebaek-ro, Yuseong-gu, Daejeon, Korea"
	item  = "Driving Range"
	tel   = "042-546-5555"
	fax   = "042-546-5558"
	site  = "www.gilsangolf.co.kr"

	'//////////////////////////////////////////////
	'	(주)길산골프클럽 원내점
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3043660&lng=127.3293995&query=64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDqs4TrsLHroZwgOTMzLTU5&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/CgchP','','')"

ElseIf tap = "9" Then 
	title = "Gilsan Golf Club Co., LTD Jangdaedong "
	img   = "<img src=""../img/img_03_01_09.jpg"">"
	addr  = "63, Yuseong-daero 736beon-gil, Yuseong-gu, Daejeon, Korea"
	item  = "Driving Range"
	tel   = "042-824-1212"
	fax   = "042-825-8811"
	site  = "www.gilsangolf.co.kr"

	'//////////////////////////////////////////////
	'	(주)길산골프클럽 장대점
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3587304&lng=127.3371035&query=64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDsnKDshLHrjIDroZw3MzbrsojquLggNjM%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/Pdycj','','')"
End If


%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">Affiliate</span><span class="block2">Affiliate</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">Affiliate</h3>

			<div class="product_tap_area">
				<div class="tap"><a href="page1.asp?tap=1" class="<%=IIF( tap = "1","over","" )%>">Gilsan Pipe Co., LTD.</a></div>
				<div class="tap"><a href="page1.asp?tap=2" class="<%=IIF( tap = "2","over","" )%>">Gilsan Steel Co., LTD. Gyeryong</a></div>
				<div class="tap"><a href="page1.asp?tap=3" class="<%=IIF( tap = "3","over","" )%>">Gilsan Steel Co., LTD. Daejeon</a></div>
				<div class="tap"><a href="page1.asp?tap=4" class="<%=IIF( tap = "4","over","" )%>">Gilsan Steel Co., LTD. Gwangju</a></div>
				<div class="tap"><a href="page1.asp?tap=5" class="<%=IIF( tap = "5","over","" )%>">Gilsan ST Co., LTD.</a></div>
				<div class="tap"><a href="page1.asp?tap=6" class="<%=IIF( tap = "6","over","" )%>">Gilsan ST Co., LTD. Coil Center</a></div>
				<div class="tap"><a href="page1.asp?tap=7" class="<%=IIF( tap = "7","over","" )%>">Gilsan SST Co., LTD.</a></div>
				<div class="tap"><a href="page1.asp?tap=8" class="<%=IIF( tap = "8","over","" )%>">Gilsan Golf Club Wonnaedong</a></div>
				<div class="tap"><a href="page1.asp?tap=9" class="<%=IIF( tap = "9","over","" )%>">Gilsan Golf Club Jangdaedong</a></div>
			</div>

			<h6 class="msg underline"><%=title%></h6>


			<div style="margin-bottom:10px;"><%=img%></div>
			<div style="text-align:right;margin-bottom:40px;">
				<button class="btn_bg" style="width:100px;" onclick="<%=url_naver%>">Naver Map</button>
				<button class="btn_bg" style="width:100px;" onclick="<%=url_google%>">Google Map</button>
			</div>
			
			<STYLE type="text/css">
				a.homepage:hover{color:blue;text-decoration:underline;}
			</STYLE>
			<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:14px;line-height:150%;">
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">Address</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=addr%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">Product</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=item%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">Telephone</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=tel%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">Fax</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=fax%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">Home Page</td>
					<td style="border-bottom:1px solid #4f4f4f;"><a href="http://<%=site%>" target="_blank" class="homepage"><%=site%></a></td>
				</tr>
			</table>



		</div>
	</div>


</div>
<!-- #include file="../inc/footer.asp" -->