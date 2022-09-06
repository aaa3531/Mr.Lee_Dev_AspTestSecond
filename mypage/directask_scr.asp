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
				<li class="snb_01">1:1 문의<span>1:1 문의 게시판입니다. </span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>사이트, 게임과 기타관련 고객님의 문의와 답변을 해드리는 게시판입니다.</p>
			<ul>
				<li><span class="emp">* 필수항목은 반드시 입력해 주시기 바랍니다.</span> </li>
			</ul>
			</div>
		</div>
		<!-- [s]입금내역 서식-->
    <input type="hidden" name="memo_no" value="<%=memo_no %>" ID="Hidden1"> 
		<div class="lst_mypage">
			
    <form action="directask_insert.asp" id="form1" name="formAsk" method="post">
			<dl>
				<dt>제목 <em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="onetitle" name="memo_desc" style="width:344px;"></dd>
			</dl>
			<dl>
				<dt>내용 <em style="display:inline;color:red">*</em></dt>
				<dd><textarea name="memo_note" style="margin-top:15px;width:94%; height:250px;"></textarea></dd>
			</dl>
			
			<dl class="finish">
				<dd>
					<input type="button" value="취소하기"  class="btn_reset"  onClick="javascript:askCancel();" />
					<input type="submit" value="문의하기"  class="btn_finish" onClick="javascript:askSubmit();" />
				</dd>
			</dl>
    </form>
			
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
		
	</div>	

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
