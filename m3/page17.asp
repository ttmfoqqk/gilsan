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
Dim iframe   : iframe   = "http://map.daum.net/?map_type=TYPE_MAP&target=car&rt=%2C%2C537825%2C752839&rt1=&rt2=%EA%B8%B8%EC%82%B0%ED%8C%8C%EC%9D%B4%ED%94%84&rtIds=%2C"
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
	iframe   = "http://dmaps.kr/5de9q"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=36.251100862755706&longitude=127.2741699638287&contents=%26nbsp%3B%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%8A%A4%ED%8B%B8%28%EC%A3%BC%29+%EA%B3%84%EB%A3%A1%EB%B3%B8%EC%82%AC&zoom=4"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=36.35134353998609&longitude=127.4053105629381&contents=%26nbsp%3B%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%8A%A4%ED%8B%B8%28%EC%A3%BC%29+%EB%8C%80%EC%A0%84%EC%A7%80%EC%A0%90&zoom=4"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=35.17344504840883&longitude=126.85865768359461&contents=%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%8A%A4%ED%8B%B8%28%EC%A3%BC%29+%EA%B4%91%EC%A3%BC%EC%A7%80%EC%A0%90&zoom=4"
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
	iframe   = "http://apis.map.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=37.80331592311561&longitude=126.95693255851442&contents=%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%97%90%EC%8A%A4%ED%8B%B0%28%EC%A3%BC%29&zoom=4"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=37.80736942385214&longitude=126.96538790924411&contents=%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%97%90%EC%8A%A4%ED%8B%B0%28%EC%A3%BC%29+%EC%BD%94%EC%9D%BC%EC%84%BC%ED%84%B0&zoom=4"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=37.8073603&lng=126.9653940&query=6rK96riw64%2BEIOyWkeyjvOyLnCDrsLHshJ3snY0g7Jew6rOh66GcIDY4LTU%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/qvqHM','','')"

ElseIf tap = "7" Then 
	title = "길산에스에스티(주)"
	addr  = "경기도 시흥시 소망공원로 182(정왕동 1265-9)"
	tel   = "031-498-9994"
	fax   = "031-496-9993"
	Transit  = "오이도 입구 교차로에서 죄회전<br>" &_
				"희망공원 방면으로 직진 후 <br>" &_
				"이동 도착<br>"

	'//////////////////////////////////////////////
	'	길산에스에스티(주)
	'	지도, 네이버약도, 구글약도 URL 입니다.
	'	수정시 유의바랍니다.
	'//////////////////////////////////////////////
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=37.335460054699524&longitude=126.71904509097828&contents=%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%26nbsp%3B%EA%B8%B8%EC%82%B0%EC%97%90%EC%8A%A4%EC%97%90%EC%8A%A4%ED%8B%B0%28%EC%A3%BC%29&zoom=4"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=36.30436590409383&longitude=127.32939750566373&contents=%26nbsp%3B%28%EC%A3%BC%29%EA%B8%B8%EC%82%B0%EA%B3%A8%ED%94%84%ED%81%B4%EB%9F%BD+%EC%9B%90%EB%82%B4%EC%A0%90&zoom=4"
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
	iframe   = "http://dna.daum.net/include/tools/routemap/map_view.php?width=740&height=379&latitude=36.35873239360103&longitude=127.33710020695648&contents=%26nbsp%3B%26nbsp%3B%28%EC%A3%BC%29%EA%B8%B8%EC%82%B0%EA%B3%A8%ED%94%84%ED%81%B4%EB%9F%BD+%EC%9E%A5%EB%8C%80%EC%A0%90&zoom=4"
	url_naver  = "window.open('http://map.naver.com/?dlevel=12&lat=36.3587304&lng=127.3371035&query=64yA7KCE6rSR7Jet7IucIOycoOyEseq1rCDsnKDshLHrjIDroZw3MzbrsojquLggNjM%3D&type=ADDRESS&tab=1&enc=b64','','')"
	url_google = "window.open('http://goo.gl/maps/Pdycj','','')"
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