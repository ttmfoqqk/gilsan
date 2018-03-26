<!-- #include file="../inc/top.asp" -->
<%
Dim tap      : tap      = IIF( request("tap")="" , "1" , request("tap") )

Dim title    : title    = "길산파이프(주)"
Dim addr     : addr     = "충남 논산시 부적면 감곡1길 7-24(감곡리 112-14) 길산파이프 길산파이프㈜"
Dim tel      : tel      = "041-732-9994"
Dim fax      : fax      = "041-732-9997"
Dim Transit  : Transit  = "논산 시내에서 계룡방면으로 이동 후 외성삼거리<br>" &_
							"계백장군 묘소 방면으로 우회전 870m 직진 <br>" &_
							"길산파이프 간판 방향으로 좌회전 500m<br>" &_
							"전방으로 길산 파이프 도착<br>"

'//////////////////////////////////////////////
'	길산파이프(주)
'	지도, 네이버약도, 구글약도 URL 입니다.
'	수정시 유의바랍니다.
'//////////////////////////////////////////////
Dim iframe   : iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d804.8259079743101!2d127.16758012923441!3d36.20781419875471!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357aa84b488b7cfb%3A0xbc536a384883c306!2z6ri47IKw7YyM7J207ZSEKOyjvCk!5e0!3m2!1sko!2skr!4v1499413673247"
Dim url_naver  : url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2065760&lng=127.1678130&query=7Lap7LKt64Ko64%2BEIOuFvOyCsOyLnCDrtoDsoIHrqbQg6rCQ6rOhMeq4uCA3LTI0&type=ADDRESS&tab=1&enc=b64','','')"
Dim url_google : url_google = "window.open('http://goo.gl/maps/BqRh7','','')"


If tap = "1" Then
	title = "길산파이프(주)"
	addr  = "충남 논산시 부적면 감곡1길 7-24(감곡리 112-14) 길산파이프㈜"
	tel   = "041-732-9994"
	fax   = "041-732-9997"
	Transit  = "논산 시내에서 계룡방면으로 이동 후 외성삼거리<br>" &_
				"계백장군 묘소 방면으로 우회전 870m 직진 <br>" &_
				"길산파이프 간판 방향으로 좌회전 500m<br>" &_
				"전방으로 길산 파이프 도착<br>"

	'//////////////////////////////////////////////
	'	길산파이프(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d804.8259079743101!2d127.16758012923441!3d36.20781419875471!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357aa84b488b7cfb%3A0xbc536a384883c306!2z6ri47IKw7YyM7J207ZSEKOyjvCk!5e0!3m2!1sko!2skr!4v1499413673247"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2065760&lng=127.1678130&query=7Lap7LKt64Ko64%2BEIOuFvOyCsOyLnCDrtoDsoIHrqbQg6rCQ6rOhMeq4uCA3LTI0&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/BqRh7','','')"

ElseIf tap = "2" Then 
	title = "길산스틸(주) 계룡본사"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사"
	tel   = "042-551-9994"
	fax   = "042-551-9997"
	Transit  = "계룡 IC 방면으로 이동 후 사거리에서<br>" &_
				"우회전 100m 전방 직진 좌회전 200m 전방<br>" &_
				"사거리 좌회전 100m 전방 이동 도착<br>"

	'//////////////////////////////////////////////
	'	길산스틸(주) 계룡본사
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3217.527247797184!2d127.2743114503482!3d36.25097649270563!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357aace7ea6d833d%3A0xef2b999adba5035d!2z7Lap7LKt64Ko64-EIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng!5e0!3m2!1sko!2skr!4v1499413816541"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2512069&lng=127.2742671&query=7Lap7LKt64Ko64%2BEIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng%3D%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qrvSD','','')"

ElseIf tap = "3" Then 
	title = "길산스틸(주) 대전지점"
	addr  = "대전광역시 대덕구 대전천 북로 296(오정동 304-1) 길산스틸㈜ 대전지점"
	tel   = "042-621-1600"
	fax   = "042-623-0100"
	Transit  = "한밭대로 방향으로 직진 후 한밭대교를<br>" &_
				"지나 우회전 200m 직진 이동 도착<br>" 

	'//////////////////////////////////////////////
	'	길산스틸(주) 대전지점
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3213.3996681751846!2d127.4029957156796!3d36.35109698004351!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654912beb0a3cd%3A0x728723c0085fba76!2z6ri47IKw7Iqk7Yu4KOyjvCk!5e0!3m2!1sko!2skr!4v1499413872791"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3513321&lng=127.4053478&query=64yA7KCE6rSR7Jet7IucIOuMgOuNleq1rCDrjIDsoITsspzrtoHroZwgMjk2&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/MZZmJ','','')"

ElseIf tap = "4" Then 
	title = "길산스틸(주) 광주지점"
	addr  = "광주 광역시 북구 하남대로 599(동림동 900-13) 길산스틸㈜ 광주지점"
	tel   = "062-511-9994"
	fax   = "062-512-9996"
	Transit  = "한양대 병원에서 마장역 방향으로 우회전<br>" &_
				"살곶이길따라 279미터 이동 후 좌회전<br>"

	'//////////////////////////////////////////////
	'	길산스틸(주) 광주지점
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1630.6691118370138!2d126.85858630906918!3d35.17312174581104!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35718ea53dddf851%3A0x2e3caaed0ce3b2ea!2z6ri47IKw7Iqk7Yu4KOyjvCk!5e0!3m2!1sko!2skr!4v1499413931359"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=35.1734465&lng=126.8586590&query=6rSR7KO86rSR7Jet7IucIOu2geq1rCDtlZjrgqjrjIDroZwgNTk5&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/dHnHm','','')"

ElseIf tap = "5" Then 
	title = "길산에스티(주)"
	addr  = "경기도 양주시 백석읍 월암로 98(홍죽리 436)"
	tel   = "031-855-9990"
	fax   = "031-829-9936"
	Transit  = "양주 시청에서 적성방향으로 직진 가남삼거리 좌회전<br>" &_
				"장흥 송추 방면으로 3km 직진 홍죽산업단지 지나 우회전 <br>" &_
				"1km 직진 후 오른쪽 이동 도착<br>"

	'//////////////////////////////////////////////
	'	길산에스티(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3152.4359993683015!2d126.95474841571307!3d37.80325537975415!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cc1de35e4abf7%3A0x662a46e45fa2c550!2z6ri47IKw7JeQ7Iqk7YuwKOyjvCk!5e0!3m2!1sko!2skr!4v1499413974816"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.8032557&lng=126.9569557&query=6rK96riw64%2BEIOyWkeyjvOyLnCDrsLHshJ3snY0g7JuU7JWU66GcIDk4&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/UIEru','','')"

ElseIf tap = "6" Then 
	title = "길산에스티(주) 코일센터"
	addr  = "경기도 양주시 백석읍 연곡로 68-5(연곡리 10-18)"
	tel   = "031-872-9994"
	fax   = "031-872-9935"
	Transit  = "양주 시청에서 적성방향으로 직진 가남삼거리 좌회전<br>" &_
				"단촌 삼거리 파주방면 연곡초등학교 건너편 <br>" &_
				"100m 이동 도착<br>"

	'//////////////////////////////////////////////
	'	길산에스티(주) 코일센터
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1576.1345699473897!2d126.96544608776311!3d37.807164462429924!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cc1ef68bd8881%3A0x9947f7fd549dfd32!2z6rK96riw64-EIOyWkeyjvOyLnCDrsLHshJ3snY0g7Jew6rOh66GcIDY4LTU!5e0!3m2!1sko!2skr!4v1499414021839"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.8073603&lng=126.9653940&query=6rK96riw64%2BEIOyWkeyjvOyLnCDrsLHshJ3snY0g7Jew6rOh66GcIDY4LTU%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qvqHM','','')"

ElseIf tap = "7" Then 
	title = "길산에스에스티(주)"
	addr  = "경기 시흥시 경기과기대로 219"
	tel   = "031-498-9994"
	fax   = "031-496-9993"
	Transit  = "시흥 공단1대로 시흥 우체국방향<br>" &_
				"방면으로 직진 후 <br>" &_
				"이동 도착<br>"

	'//////////////////////////////////////////////
	'	길산에스에스티(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3172.2952934977134!2d126.71697231570223!3d37.33551717984183!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b716ac413e6cf%3A0xece4fe4d0865adc7!2z6ri47IKw7JeQ7Iqk7JeQ7Iqk7YuwKOyjvCk!5e0!3m2!1sko!2skr!4v1499414051080"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.3354633&lng=126.7190478&query=6rK96riw64%2BEIOyLnO2dpeyLnCDsoJXsmZXrj5kgMTI2NS05&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/lzTJY','','')"

ElseIf tap = "8" Then 
	title = "(주)길산골프클럽 원내점"
	addr  = "대전광역시 유성구 계백로 933-59(원내동 1-10)"
	tel   = "042-546-5555"
	fax   = "042-546-5558"
	Transit  = "건양병원 네거리에서 관저지하차도 오른쪽 방향 700m 후<br>" &_
			   "오일뱅크 방향 골목으로 우회전 후 200m 전진 이동 도착<br>"

	'//////////////////////////////////////////////
	'	(주)길산골프클럽 원내점
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3215.395072122135!2d127.32875629875961!3d36.30272527176111!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654d0ffd533b07%3A0xe60b3886e540a3fd!2z64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDqs4TrsLHroZwgOTMzLTU5!5e0!3m2!1sko!2skr!4v1499414218407"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3043660&lng=127.3293995&query=64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDqs4TrsLHroZwgOTMzLTU5&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/CgchP','','')"

ElseIf tap = "9" Then 
	title = "(주)길산골프클럽 장대점"
	addr  = "대전광역시 유성구 유성대로 736번길 63(장대동 281-4)"
	tel   = "042-824-1212"
	fax   = "042-825-8811"
	Transit  = "유성 고속버스 터미널 봉국사 방향으로<br>" &_
			   "100m 전진 이동 도착<br>"

	'//////////////////////////////////////////////
	'	(주)길산골프클럽 장대점
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d803.2712013652605!2d127.33730958345846!3d36.358724675247!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654b7775de2d8d%3A0x65d147c6115de6f3!2z6ri47IKw6rOo7ZSE7YG065-9!5e0!3m2!1sko!2skr!4v1499414267428"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3587304&lng=127.3371035&query=64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDsnKDshLHrjIDroZw3MzbrsojquLggNjM%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/Pdycj','','')"

ElseIf tap = "10" Then 
	title = "석진길산에스에스티(주)"
	addr  = "경상북도 칠곡군 왜관읍 공단로4길 32-11 "
	tel   = "053-582-4278"
	fax   = "054-977-4639"
	Transit  = ""

	'//////////////////////////////////////////////
	'	석진길산에스에스티(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////

	iframe = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3229.2501125373387!2d128.41693721564277!3d35.96531018012918!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3565e941b56fd91d%3A0xb01910548b379992!2z7ISd7KeE7LKg6rCVKOyjvCk!5e0!3m2!1sko!2skr!4v1500538823289"
	url_naver  = "window.open('http://map.naver.com/?searchCoord=e1a43c98221ed64c4f1ed56e8185a2ce1e15795e5f7d67d2e9197da2013929a0&query=6rK97IOB67aB64%2BEIOy5oOqzoeq1sCDsmZzqtIDsnY0g6rO164uo66GcNOq4uCAzMi0xMQ%3D%3D&inBound=on&menu=location&lng=799987607ecc0db58754791377d9a1f7&type=SITE_1&mapMode=0&boundary=128.4108448%3B35.961683%3B128.4274065%3B35.9689773&mpx=04850250%3A35.9653259%2C128.419126%3AZ12%3A0.0165617%2C0.0072943&lat=68bca4625b084e57e3d72e03b8f0a44a&dlevel=12&enc=b64','','')"
	url_google = "window.open('https://www.google.co.kr/maps/place/%EC%84%9D%EC%A7%84%EC%B2%A0%EA%B0%95(%EC%A3%BC)/@35.9653102,128.4169372,17z/data=!4m5!3m4!1s0x3565e941b56fd91d:0xb01910548b379992!8m2!3d35.9653102!4d128.4191259','','')"

ElseIf tap = "11" Then 
	title = "(주)길산종합건설"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사 5층"
	tel   = "042-841-9971"
	fax   = "042-841-9981"
	Transit  = "계룡 IC 방면으로 이동 후 사거리에서<br>" &_
				"우회전 100m 전방 직진 좌회전 200m 전방<br>" &_
				"사거리 좌회전 100m 전방 이동 도착<br>"

	'//////////////////////////////////////////////
	'	(주)길산종합건설
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3217.527247797184!2d127.2743114503482!3d36.25097649270563!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357aace7ea6d833d%3A0xef2b999adba5035d!2z7Lap7LKt64Ko64-EIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng!5e0!3m2!1sko!2skr!4v1499413816541"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.2512069&lng=127.2742671&query=7Lap7LKt64Ko64%2BEIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng%3D%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qrvSD','','')"

ElseIf tap = "12" Then 
	title = "(주)길산로지스"
	addr  = "충남 계룡시 두마면 제1산단로 25-46(왕대리 159) 길산스틸㈜ 계룡본사 1층"
	tel   = "042-719-9177"
	fax   = "042-732-9995"
	Transit  = "계룡 IC 방면으로 이동 후 사거리에서<br>" &_
				"우회전 100m 전방 직진 좌회전 200m 전방<br>" &_
				"사거리 좌회전 100m 전방 이동 도착<br>"

	'//////////////////////////////////////////////
	'	(주)길산로지스
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3217.527247797184!2d127.2743114503482!3d36.25097649270563!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357aace7ea6d833d%3A0xef2b999adba5035d!2z7Lap7LKt64Ko64-EIOqzhOujoeyLnCDrkZDrp4jrqbQg7KCcMeyCsOuLqOuhnCAyNS00Ng!5e0!3m2!1sko!2skr!4v1499413816541"
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
			<h3 class="title">오시는길</h3>

			<div class="product_tap_area">
				<div class="tap"><a href="page4.asp?tap=1" class="<%=IIF( tap = "1","over","" )%>">길산파이프(주)</a></div>
				<div class="tap"><a href="page4.asp?tap=2" class="<%=IIF( tap = "2","over","" )%>">길산스틸(주) 계룡본사</a></div>
				<div class="tap"><a href="page4.asp?tap=3" class="<%=IIF( tap = "3","over","" )%>">길산스틸(주) 대전지점</a></div>
				<div class="tap"><a href="page4.asp?tap=4" class="<%=IIF( tap = "4","over","" )%>">길산스틸(주) 광주지점</a></div>
				<div class="tap"><a href="page4.asp?tap=5" class="<%=IIF( tap = "5","over","" )%>">길산에스티(주)</a></div>
				<div class="tap"><a href="page4.asp?tap=6" class="<%=IIF( tap = "6","over","" )%>">길산에스티(주) 코일센터</a></div>
				<div class="tap"><a href="page4.asp?tap=7" class="<%=IIF( tap = "7","over","" )%>">길산에스에스티(주)</a></div>
				<div class="tap"><a href="page4.asp?tap=8" class="<%=IIF( tap = "8","over","" )%>">(주)길산골프클럽 원내점</a></div>
				<div class="tap"><a href="page4.asp?tap=9" class="<%=IIF( tap = "9","over","" )%>">(주)길산골프클럽 장대점</a></div>
				<div class="tap"><a href="page4.asp?tap=10" class="<%=IIF( tap = "10","over","" )%>">석진길산에스에스티(주)</a></div>
				<div class="tap"><a href="page4.asp?tap=11" class="<%=IIF( tap = "11","over","" )%>">(주)길산종합건설</a></div>
				<div class="tap"><a href="page4.asp?tap=12" class="<%=IIF( tap = "12","over","" )%>">(주)길산로지스</a></div>
			</div>


			<div class="daum_map" style="clear:both;">
				<iframe src="<%=iframe%>" width="740" height="414" scrolling="no" frameborder="0"></iframe>
			</div>

			<div style="text-align:right;margin-bottom:40px;">
				<button class="btn_bg" style="width:100px;" onclick="<%=url_naver%>">네이버 약도</button>
				<button class="btn_bg" style="width:100px;" onclick="<%=url_google%>">구글 약도</button>
			</div>

			<table cellpadding="0" cellspacing="0" style="border-top:2px solid #4f4f4f;width:100%;font-size:14px;line-height:150%;">
				<tr style="height:40px;">
					<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">주소</td>
					<td style="border-bottom:1px solid #4f4f4f;"><%=addr%></td>
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
						<td style="border-bottom:1px solid #4f4f4f;width:100px;padding-left:20px;">대중교통</td>
						<td style="border-bottom:1px solid #4f4f4f;padding:20px 0px 20px 0px;"><%=Transit%></td>
					</tr>
			</table>



		</div>
	</div>


</div>
<!-- #include file="../inc/footer.asp" -->