<!-- #include file="../inc/top.asp" -->
<%
Dim tap   : tap   = IIF( request("tap")="" , "1" , request("tap") )
Dim title : title = "길산파이프(주)"
Dim img   : img   = "<img src=""../img/img_03_01_01.jpg"">"
Dim addr  : addr  = "충남 논산시 부적면 감곡1길 7-24 길산파이프 길산파이프㈜"
Dim item  : item  = "STS 304 구조관 파이프, 배관 파이프"
Dim tel   : tel   = "041-732-9994"
Dim fax   : fax   = "042-621-1600"
Dim site  : site  = "www.gilsan.co.kr"



'//////////////////////////////////////////////
'	길산파이프(주)
'	네이버약도, 구글약도 URL 입니다.
'	수정시 유의바랍니다.
'//////////////////////////////////////////////
Dim url_naver  : url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2065760&lng=127.1678130&query=7Lap7LKt64Ko64%2BEIOuFvOyCsOyLnCDrtoDsoIHrqbQg6rCQ6rOhMeq4uCA3LTI0&type=ADDRESS&tab=1&enc=b64','','')"
Dim url_google : url_google = "window.open('http://goo.gl/maps/BqRh7','','')"


If tap = "1" Then
	title = "길산파이프(주)"
	img   = "<img src=""../img/img_03_01_01.jpg"">"
	addr  = "충남 논산시 부적면 감곡1길 7-24(감곡리 112-14) 길산파이프㈜ 논산본사"
	item  = "STS 304 구조관 파이프, 배관 파이프"
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
	title = "길산스틸(주) 계룡본사"
	img   = "<img src=""../img/img_03_01_02.jpg"">"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사"
	item  = "STS 코일 슬리팅 및 판제조, 환봉, 평철, 앵글"
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
	title = "길산스틸(주) 대전지점"
	img   = "<img src=""../img/img_03_01_03.jpg"">"
	addr  = "대전광역시 대덕구 대전천 북로 296(오정동 304-1) 길산스틸㈜ 대전지점"
	item  = "STS 스텐판제조 및 코일, 환봉, 평철, 앵글"
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
	title = "길산스틸(주) 광주지점"
	img   = "<img src=""../img/img_03_01_04.jpg"">"
	addr  = "광주 광역시 북구 하남대로 599(동림동 900-13) 길산스틸㈜ 광주지점"
	item  = "STS 스텐판제조 및 코일, 환봉, 평철, 앵글"
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
	title = "길산에스티(주)"
	img   = "<img src=""../img/img_03_01_05.jpg"">"
	addr  = "경기도 양주시 백석읍 월암로 98(홍죽리 436)"
	item  = "구조관 파이프, 판, 환봉, 평철, 앵글"
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
	title = "길산에스티(주) 코일센터"
	img   = "<img src=""../img/img_03_01_06.jpg"">"
	addr  = "경기도 양주시 백석읍 연곡로 68-5(연곡리 10-18)"
	item  = "STS 코일 슬리팅 및 판제조, 환봉, 평철, 앵글"
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
	title = "길산에스에스티(주)"
	img   = "<img src=""../img/img_03_01_07.jpg"">"
	addr  = "경기도 시흥시 공단1대로 275"
	item  = "구조관 파이프, 판, 환봉, 평철, 앵글"
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
	title = "(주)길산골프클럽 원내점"
	img   = "<img src=""../img/img_03_01_08.jpg"">"
	addr  = "대전광역시 유성구 계백로 933-59(원내동 1-10)"
	item  = "대전 최대규모, 고객 만족 정신이 깃들어 있는 최고의 시설"
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
	title = "(주)길산골프클럽 장대점"
	img   = "<img src=""../img/img_03_01_09.jpg"">"
	addr  = "대전광역시 유성구 유성대로736번길 63(장대동 281-4)"
	item  = "프로 골퍼 박세리와 장정도 실력을 쌓았던 전통의 명소"
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

ElseIf tap = "10" Then 
	title = "(주)석진길산에스에스티"
	img   = "<img src=""../img/img_17_07_20.jpg"">"
	addr  = "경상북도 칠곡군 왜관읍 공단로4길 32-11 "
	item  = "STS 스텐판제조 및 구조관파이프, 코일, 환봉, 평철, 앵글"
	tel   = "053-582-4278"
	fax   = "054-977-4639"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	(주)석진길산SST
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?searchCoord=e1a43c98221ed64c4f1ed56e8185a2ce1e15795e5f7d67d2e9197da2013929a0&query=6rK97IOB67aB64%2BEIOy5oOqzoeq1sCDsmZzqtIDsnY0g6rO164uo66GcNOq4uCAzMi0xMQ%3D%3D&inBound=on&menu=location&lng=799987607ecc0db58754791377d9a1f7&type=SITE_1&mapMode=0&boundary=128.4108448%3B35.961683%3B128.4274065%3B35.9689773&mpx=04850250%3A35.9653259%2C128.419126%3AZ12%3A0.0165617%2C0.0072943&lat=68bca4625b084e57e3d72e03b8f0a44a&dlevel=12&enc=b64','','')"
	url_google = "window.open('https://www.google.co.kr/maps/place/%EC%84%9D%EC%A7%84%EC%B2%A0%EA%B0%95(%EC%A3%BC)/@35.9653102,128.4169372,17z/data=!4m5!3m4!1s0x3565e941b56fd91d:0xb01910548b379992!8m2!3d35.9653102!4d128.4191259','','')"

ElseIf tap = "11" Then 
	title = "(주)길산종합건설"
	img   = "<img src=""../img/img_17_07_22.jpg"">"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사 5층"
	item  = "글로벌 종합 건설기업으로 도약하는 길산종합건설이 되겠습니다."
	tel   = "042-841-9971"
	fax   = "042-841-9981"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	(주)길산종합건설
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2512069&lng=127.2742671&query=7Lap7LKt64Ko64%2BEIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng%3D%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qrvSD','','')"

ElseIf tap = "12" Then 
	title = "(주)길산로지스"
	img   = "<img src=""../img/img_17_07_23.jpg"">"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사 1층"
	item  = "글로벌 종합 물류기업으로 도약하는 길산로지스가 되겠습니다."
	tel   = "042-719-9177"
	fax   = "042-551-9995"
	site  = "www.gilsan.co.kr"

	'//////////////////////////////////////////////
	'	(주)길산로지스
	'	네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2512069&lng=127.2742671&query=7Lap7LKt64Ko64%2BEIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng%3D%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qrvSD','','')"

End If


%>
<link rel="stylesheet" type="text/css" href="../inc/css/sub.css">
<div id="middle_sub">
	<!-- #include file="../inc/sub_visual.asp" -->
	
	<div class="navi_wrap">
		<div class="width_wrap">
			<span class="home">H</span><span class="block1">계열사현황</span><span class="block2">계열사현황</span>
		</div>
	</div>

	<div class="width_wrap">
		<!-- #include file="../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">계열사소개</h3>

			<div class="product_tap_area">
				<div class="tap"><a href="page1.asp?tap=1" class="<%=IIF( tap = "1","over","" )%>">길산파이프(주)</a></div>
				<div class="tap"><a href="page1.asp?tap=2" class="<%=IIF( tap = "2","over","" )%>">길산스틸(주) 계룡본사</a></div>
				<div class="tap"><a href="page1.asp?tap=3" class="<%=IIF( tap = "3","over","" )%>">길산스틸(주) 대전지점</a></div>
				<div class="tap"><a href="page1.asp?tap=4" class="<%=IIF( tap = "4","over","" )%>">길산스틸(주) 광주지점</a></div>
				<div class="tap"><a href="page1.asp?tap=5" class="<%=IIF( tap = "5","over","" )%>">길산에스티(주)</a></div>
				<div class="tap"><a href="page1.asp?tap=6" class="<%=IIF( tap = "6","over","" )%>">길산에스티(주) 코일센터</a></div>
				<div class="tap"><a href="page1.asp?tap=7" class="<%=IIF( tap = "7","over","" )%>">길산에스에스티(주)</a></div>
				<div class="tap"><a href="page1.asp?tap=8" class="<%=IIF( tap = "8","over","" )%>">(주)길산골프클럽 원내점</a></div>
				<div class="tap"><a href="page1.asp?tap=9" class="<%=IIF( tap = "9","over","" )%>">(주)길산골프클럽 장대점</a></div>
				<div class="tap"><a href="page1.asp?tap=10" class="<%=IIF( tap = "10","over","" )%>">석진길산에스에스티(주)</a></div>
				<div class="tap"><a href="page1.asp?tap=11" class="<%=IIF( tap = "11","over","" )%>">(주)길산종합건설</a></div>
				<div class="tap"><a href="page1.asp?tap=12" class="<%=IIF( tap = "12","over","" )%>">(주)길산로지스</a></div>
			</div>

			<h6 class="msg underline"><%=title%></h6>


			<div style="margin-bottom:10px;"><%=img%></div>
			<div style="text-align:right;margin-bottom:40px;">
				<button class="btn_bg" style="width:100px;" onclick="<%=url_naver%>">네이버 약도</button>
				<button class="btn_bg" style="width:100px;" onclick="<%=url_google%>">구글 약도</button>
			</div>
			
			<STYLE type="text/css">
				a.homepage:hover{color:blue;text-decoration:underline;}
			</STYLE>
			<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:14px;line-height:150%;">
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">주소</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=addr%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">취급품목</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=item%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">전화</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=tel%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">팩스</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=fax%></td>
				</tr>
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">홈페이지</td>
					<td style="border-bottom:1px solid #4f4f4f;"><a href="http://<%=site%>" target="_blank" class="homepage"><%=site%></a></td>
				</tr>
			</table>



		</div>
	</div>


</div>
<!-- #include file="../inc/footer.asp" -->