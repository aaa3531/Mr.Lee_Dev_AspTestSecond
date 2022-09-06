<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->


	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">충전하기<span>베팅용 게임포인트가 충전됩니다.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">

		</div>
		<!-- [s]입금내역 서식-->
		<div class="lst_mypage">
		
			<p class="join_end_title"><%=Session("member_id") %> 님, <br />베팅용 게임포인트<br />충전 신청이 완료되었습니다.</p>
						<dl class="finish">
				<dd>
					<a href="/"><input type="button" value="메인으로"  class="btn_reset" /></a>
					<a href="/mypage/charge.asp"><input type="button" value="충전하기"  class="btn_finish" /></a>
					<!-- charge.html 페이지로 이동 -->
				</dd>
			</dl>
			
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
		
	</div>

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
