			<%If INSTR(LCase(g_url),"page7_1") > 0 Then %>
			<div class="product_visual"><img src="../img/visual/product/07_01.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월각봉단가표.pdf','','')">스테인레스 사각 단가표</button>
			
			<div class="product_tap_area">
				<div class="tap"><a href="page7_1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_1_1")>0,"over","" )%>">강종 및 공급길이</a></div>
				<div class="tap"><a href="page7_1_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_1_2")>0,"over","" )%>">공급규격 및 허용공치</a></div>
				<div class="tap"><a href="page7_1_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_1_3")>0,"over","" )%>">규격 및 단중</a></div>
			</div>
			<%Else%>
			<div class="product_visual"><img src="../img/visual/product/07_02.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월각봉단가표.pdf','','')">스테인레스 육각 단가표</button>
			
			<div class="product_tap_area">
				<div class="tap"><a href="page7_2_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_2_1")>0,"over","" )%>">강종 및 공급길이</a></div>
				<div class="tap"><a href="page7_2_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_2_2")>0,"over","" )%>">공급규격 및 허용공치</a></div>
				<div class="tap"><a href="page7_2_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page7_2_3")>0,"over","" )%>">규격 및 단중</a></div>
			</div>
			<%End If%>