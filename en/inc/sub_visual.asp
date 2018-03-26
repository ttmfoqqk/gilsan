	<% If INSTR(LCase(g_url),"/m1/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/01.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m2/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/02.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m3/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/03.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m4/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/04.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/m5/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/05.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/mypage/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/mypage.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/find/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/find.jpg"></div>
	</div>
	<% elseIf INSTR(LCase(g_url),"/agree/")>0 Then %>
	<div class="centerPageContants_visual_wrap">
		<div class="centerPageContants_visual" id="Contants_visual"><div class="mask"></div><img src="../img/visual/sub/agree.jpg"></div>
	</div>
	<% End If %>
	<SCRIPT type="text/javascript">
	$(document).ready(function(){
		/* 서브비주얼 */
		$Contants_visual = $('#Contants_visual');
		$Contants_visual.fadeIn(2000);

		var minWidth  = 1000;
		var minHeight = 125;

		if( $Contants_visual.height() > minHeight || $Contants_visual.width() > minWidth ){
			if($Contants_visual.width() > $Contants_visual.height()*8){
				$Contants_visual.find('img').width( $Contants_visual.width() );
				$Contants_visual.find('img').height( $Contants_visual.width()/8 );

				$Contants_visual.find('img').css('margin-left' , '-'+ ($Contants_visual.find('img').width()/2) +'px' );
			}else{
				$Contants_visual.find('img').width( $Contants_visual.height()*8 );
				$Contants_visual.find('img').height( $Contants_visual.height() );

				$Contants_visual.find('img').css('margin-left' , '-'+ ($Contants_visual.find('img').width()/2) +'px' );
			}
		}
	});
	$(window).resize(function(){
		$Contants_visual = $('#Contants_visual');
		var minWidth  = 1000;
		var minHeight = 125;
		if( $Contants_visual.height() > minHeight || $Contants_visual.width() > minWidth ){
			if($Contants_visual.width() > $Contants_visual.height()*8){
				$Contants_visual.find('img').width( $Contants_visual.width() );
				$Contants_visual.find('img').height( $Contants_visual.width()/8 );

				$Contants_visual.find('img').css('margin-left' , '-'+ ($Contants_visual.find('img').width()/2) +'px' );
			}else{
				$Contants_visual.find('img').width( $Contants_visual.height()*8 );
				$Contants_visual.find('img').height( $Contants_visual.height() );

				$Contants_visual.find('img').css('margin-left' , '-'+ ($Contants_visual.find('img').width()/2) +'px' );
			}
		}
	})
	</SCRIPT>