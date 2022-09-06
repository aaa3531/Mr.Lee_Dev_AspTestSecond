<!-- #include virtual="/_include/log_root.inc" -->
<!-- #include virtual="/_include/header_main.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%
     if request("member_no") <> "" then
     Session("member_no")= request("member_no")
     end if

     if request("result_desc") <> "" then
     result_desc = request("result_desc")
     end if
 %>


<script type="text/javascript">
    function OpenBannerWindow() {
        window.open("/popup1.asp", 'BANNER1', 'menubar=no, toolbar=no,location=no, directories=no, status=no, resizable=no, scrollbars=no, copyhistory=no, width=500, height=700,left=150,top=0');
        }
</script>

<script type="text/javascript">
    function idPopup() {
        var strurl = "/idpopup.asp";
        window.open(strurl, 'BANNER', 'menubar=no, toolbar=no,location=no, directories=no, status=no, resizable=no, scrollbars=no, copyhistory=no, width=520, height=600,left=400,top=50');
    }
</script>

<script type="text/javascript">
    function pwdPopup() {
        var strurl = "/pwdpopup.asp";
        window.open(strurl, 'BANNER', 'menubar=no, toolbar=no,location=no, directories=no, status=no, resizable=no, scrollbars=no, copyhistory=no, width=520, height=600,left=400,top=50');
    }
</script>

<script language="javascript">
    function recommend_popup() {
        var strurl = "recommend_popup.asp";
        window.open(strurl, 'popup', 'menubar=no, toolbar=no,location=no, directories=no, status=no, resizable=no, scrollbars=no, copyhistory=no, width=300, height=110,left=500,top=300');
    }
</script>


	<!-- container -->
	<div id="container">
		<!-- content -->
		<div id="content">	

  <% if Session("ip_count") > "0" then %>
    
	
		
		<!--항하사증권 첫화면 로그인-->
		<div class="section">
			<ul class="login_title">
				<li class="welcome">개발중입니다.</li>
			</ul>
		</div>		


	    
  <% else %>
  

    <% if Session("member_no") > "0" then %>    

    <script>
      OpenBannerWindow();
    </script>
    <!--항하사증권 첫화면 로그인-->
    <div class="section2">
			<ul class="main_title">
				<li><img id="mainimage" src="img/section_title01.png" alt="저희 항하사 증권게임은 국내,세계최초 각 나라의 주요지수와 테마 및 종목을 가지고 경기를 하는 증권게임입니다 "/></li>
				
			</ul>
    </div> 	
	   
    <% else %>

	    <div style="text-align:center; color:#ffff00; padding:10px;">
            <%= result_desc %> 
            </div>

		<div class="section">
        <form action="/sumember/login_set.asp" id="form1" name="formLogin" method="post">
			<ul class="login_title">
				<li><img src="img/main_login_logo.png" width="277" height="57" alt="항하사증권 로그인" /></li>
				<li class="welcome">항하사 증권에 오신것을 환영합니다.</li>
				<li><input type="text" class="input_txt" name="member_id" placeholder="아이디를 입력하세요" /></li>
				<li><input type="password" class="input_txt"  name="member_pwd" placeholder="비밀번호를 입력하세요" /></li>
				<li><input type="submit" class="input_btn_login" value="로그인" /></li>
				<li><input type="button" class="input_btn_join" onclick="javascript: recommend_popup()"  value="회원가입" /></li>
				<li class="idpw_search"><a href="#" onclick="javascript: idPopup()">아이디찾기</a>    <span> |</span>    <a href="#" onclick="javascript: pwdPopup()">비밀번호찾기</a></li>
			</ul>
	    </form>
		</div>
		<!--//항하사증권 첫화면 로그인-->
		
        
    <% end if %>
  <% end if %>
  
	
<!-- #include virtual="/_include/connect_close.inc" -->

<!-- #include virtual="/_include/bottom_menu.inc" -->
