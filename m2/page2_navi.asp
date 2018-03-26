			<%If INSTR(LCase(g_url),"page2_1") > 0 Then %>
			<div class="product_visual"><img src="../img/visual/product/02_01.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년12월파이프단가표.pdf','','')">구조관파이프 단가표</button>
			<STYLE type="text/css">
				#contant .product_tap_area .tap{
					width:183px;
				}
				#contant .product_tap_area .tap a{
					width:181px;
				}
			</STYLE>
			<div class="product_tap_area">
				<div class="tap"><a href="page2_1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_1")>0,"over","" )%>">제조공정</a></div>
				<div class="tap"><a href="page2_1_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_2")>0,"over","" )%>">원파이프 중량표</a></div>
				<div class="tap"><a href="page2_1_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_3")>0,"over","" )%>">사각 파이프 중량표</a></div>
				<div class="tap"><a href="page2_1_4.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_4")>0,"over","" )%>">치수 허용치</a></div>
				<div class="tap"><a href="page2_1_5.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_5")>0,"over","" )%>">기계적 성질</a></div>
				<div class="tap"><a href="page2_1_6.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_6")>0,"over","" )%>">원파이프 포장 수량 표준표</a></div>
				<div class="tap"><a href="page2_1_7.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_7")>0,"over","" )%>">각파이프 포장 수량 표준표</a></div>
				<div class="tap"><a href="page2_1_8.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_8")>0,"over","" )%>">두깨별 포장끈 색깔 표준표</a></div>
			</div>
			<%Else%>
			<div class="product_visual"><img src="../img/visual/product/02_02.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월배관단가표.pdf','','')">배관파이프 단가표</button>
			<STYLE type="text/css">
				#contant .product_tap_area .tap{
					width:368px;
				}
				#contant .product_tap_area .tap a{
					width:366px;
				}
			</STYLE>
			<div class="product_tap_area">
				<div class="tap"><a href="page2_2_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_1")>0,"over","" )%>">배관용 스테인레스 강관</a></div>
				<div class="tap"><a href="page2_2_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_2")>0,"over","" )%>">치수</a></div>
				<div class="tap"><a href="page2_2_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_3")>0,"over","" )%>">중량표</a></div>
				<div class="tap"><a href="page2_2_4.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_4")>0,"over","" )%>">스테인레스 강관 구조율표</a></div>
			</div>
			<%End If%>