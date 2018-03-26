			<div class="product_visual"><img src="../img/visual/product/03_01.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월환봉단가표.pdf','','')">환봉 단가표</button>

			<STYLE type="text/css">
				#contant .product_tap_area .tap{
					width:368px;
				}
				#contant .product_tap_area .tap a{
					width:366px;
				}
			</STYLE>
			<div class="product_tap_area">
				<div class="tap"><a href="page3_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page3_1")>0,"over","" )%>">강종 및 길이</a></div>
				<div class="tap"><a href="page3_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page3_2")>0,"over","" )%>">단중</a></div>
				<div class="tap"><a href="page3_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page3_3")>0,"over","" )%>">생산 치수 및 허용 공차</a></div>
				<div class="tap"><a href="page3_4.asp" class="<%=IIF( INSTR(LCase(g_url),"/page3_4")>0,"over","" )%>">용도</a></div>
			</div>