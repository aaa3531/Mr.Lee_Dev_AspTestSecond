<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<script>
fuction askSubmit()
{
  formAsk.submit();
}
fuction askCancel()
{
  history.go(-1);
}
</script>


	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">1:1문의<span>1:1문의가 완료되었습니다.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>1:1문의가 접수 처리되었습니다.</p>

			</div>
		</div>
		<!-- [s]입금내역 서식-->
		<div class="lst_mypage">
		
			<p class="join_end_title"><%=Session("member_id") %> 님, <br />작성해주신 문의가 접수되었습니다. </p>
						<dl class="finish">
				<dd>
				    <a href="/">
				    <input type="button" value="메인으로"  class="btn_reset" />
					</a>
					<a href="directask.asp">
				    <input type="button" value="내 글 보러가기"  class="btn_finish" />
				    </a>
					
				</dd>
			</dl>
			
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
		
	</div>	

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
