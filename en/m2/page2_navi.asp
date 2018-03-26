			<%If INSTR(LCase(g_url),"page2_1") > 0 Then %>
			<div class="product_visual"><img src="../img/visual/product/02_01.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월구조관단가표.pdf','','')">Structural Pipe Unit Price Index</button>
			<STYLE type="text/css">
				#contant .product_tap_area .tap{
					width:183px;
				}
				#contant .product_tap_area .tap a{
					width:181px;
				}
			</STYLE>
			<div class="product_tap_area">
				<div class="tap"><a href="page2_1_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_1")>0,"over","" )%>">Manufacturing Process Diagram</a></div>
				<div class="tap"><a href="page2_1_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_2")>0,"over","" )%>">Round-Pipe  Table </a></div>
				<div class="tap"><a href="page2_1_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_3")>0,"over","" )%>">Each-pipe   Table</a></div>
				<div class="tap"><a href="page2_1_4.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_4")>0,"over","" )%>">Size Allowance</a></div>
				<div class="tap"><a href="page2_1_5.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_5")>0,"over","" )%>">Mechanical Features</a></div>
				<div class="tap"><a href="page2_1_6.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_6")>0,"over","" )%>">Round-Pipe  Standard Table </a></div>
				<div class="tap"><a href="page2_1_7.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_7")>0,"over","" )%>">Each-pipe  Standard Table</a></div>
				<div class="tap"><a href="page2_1_8.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_1_8")>0,"over","" )%>">Package Tape Color Table</a></div>
			</div>
			<%Else%>
			<div class="product_visual"><img src="../img/visual/product/02_02.jpg"></div>
			
			<button class="product_price_btn" type="button" onclick="window.open('./files/2014년8월배관단가표.pdf','','')">Plumbing Pipe Unit Price Index</button>
			<STYLE type="text/css">
				#contant .product_tap_area .tap{
					width:368px;
				}
				#contant .product_tap_area .tap a{
					width:366px;
				}
			</STYLE>
			<div class="product_tap_area">
				<div class="tap"><a href="page2_2_1.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_1")>0,"over","" )%>">Stainless-Steel Pipe for Plumbing</a></div>
				<div class="tap"><a href="page2_2_2.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_2")>0,"over","" )%>">Size</a></div>
				<div class="tap"><a href="page2_2_3.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_3")>0,"over","" )%>">Weight Table</a></div>
				<div class="tap"><a href="page2_2_4.asp" class="<%=IIF( INSTR(LCase(g_url),"/page2_2_4")>0,"over","" )%>">Table for the Structural Ratio of Stainless-Steel Pipe </a></div>
			</div>
			<%End If%>