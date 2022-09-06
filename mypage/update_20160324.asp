<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<% 

strSQL = "p_sm_member_detail '" & session("member_no") & "' "
    'response.Write strSQL
    'response.end
    
    Set rsMember = Server.CreateObject("ADODB.RecordSet")
    rsMember.Open strSQL, DbCon, 1, 1
  
    if NOT rsMember.EOF and NOT rsMember.BOF then
      member_id = rsMember("member_id")
      member_name = rsMember("member_name")
      member_pwd = rsMember("member_pwd")
      member_alias = rsMember("member_alias")
      member_email = rsMember("member_email")
      member_phone1 = rsMember("member_phone1")
      member_phone2 = rsMember("member_phone2")
      member_phone3 = rsMember("member_phone3")
      recommend_id = rsMember("recommend_id")
      sex_flag = rsMember("sex_flag")
      account_no = rsMember("account_no")
      bank_name = rsMember("bank_name")
      bank_owner = rsMember("bank_owner")
      withdraw_pwd = rsMember("withdraw_pwd")
      userchange_flag = rsMember("userchange_flag")
    end if 
    set rsMember = nothing

%>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 

<script>
  function CheckEmail(data) {
    return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(data);
  }
  function CheckEng(data) {
    return (/^[a-z0-9]{5,12}$/).test(data);
  }
  function CheckWithdraw(data) {
    return (/^[0-9]{4,8}$/).test(data);
  }
  function CheckHan(data) {
    return (/^[가-힝]{2,6}$/).test(data);
  }
  function CheckMemberPhone(data) {
    return (/^[0-9]{3,4}$/).test(data);
  }
  function SetNum(obj) {
    val = obj.value;
    re = /[^0-9]/gi;
    obj.value = val.replace(re, "");
  }
  function JoinFormCheck(form) {
    if (!CheckEng(form.member_pwd.value)) {
      alert("비밀번호를 입력해주세요\n5~12글자 영문(소문자,숫자)로만 입력해주세요\n특수문자,공백은 사용할수 없습니다.");
      form.member_pwd.focus();
      return false;
    }
    if (form.member_pwd.value != form.member_pwd2.value) {
      alert("비밀번호확인이 일치하지 않습니다");
      form.member_pwd2.focus();
      return false;
    }
    if (!CheckWithdraw(form.withdraw_pwd.value)) {
      alert("환전비밀번호를 입력해주세요\n4~8사이의 숫자로만 입력해주세요\n특수문자,공백은 사용할수 없습니다.");
      form.withdraw_pwd.focus();
      return false;
    }
    if (form.member_email.value != "") {
      if (!CheckEmail(form.email.value)) {
        alert("email형식이 일치하지 않습니다.");
        form.member_email.focus();
        return false;
      }
    }  
    if (!CheckMemberPhone(form.member_phone1.value)) {
      alert("휴대폰번호를 입력해주세요");
      form.member_phone1.focus();
      return false;
    }
    if (!CheckMemberPhone(form.member_phone2.value)) {
      alert("휴대폰번호를 입력해주세요");
      form.member_phone2.focus();
      return false;
    }
    if (!CheckMemberPhone(form.member_phone3.value)) {
      alert("휴대폰번호를 입력해주세요");
      form.member_phone3.focus();
      return false;
    }
    if (form.bank_name.value == "") {
      alert("은행명을 선택해주세요");
      form.bank_name.focus();
      return false;
    }
    if (form.account_no.value == "") {
      alert("계좌번호를 입력해주세요");
      form.account_no.focus();
      return false;
    }
    if (form.bank_owner.value == "") {
      alert("예금주를 입력해주세요");
      form.bank_owner.focus();
      return false;
    }
  
    return true;
  }
</script>

<SCRIPT language="javascript">

    function memberChange() {
                xhr = new XMLHttpRequest();
                xhr.open("Get", "memberchange_ask.asp");
                xhr.send(null);
                alert("변경신청이 완료되었습니다. 관리자 승인을 기다려주세요");
            }


</SCRIPT> 



<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">회원정보수정<span>회원정보 수정 페이지입니다.</span></li>
				</ul>

			</div>
		

      <form id="formMember" name="formMember" method="post" onsubmit="return JoinFormCheck(this)" action="update_set.asp" >
      <input type="hidden" name="flag" value="1" ID="Hidden4"> 
		<!-- [s]회원정보수정 서식-->
		<div class="lst_mypage">
		<dl>
            <dl>
				<dt>아이디</dt>
				<dd class="lst_txt"><%=member_id %></dd>
			</dl>
			<dl>
				<dt>닉네임</dt>
				<dd class="lst_txt"><%=member_alias %></dd>
			</dl>
            
			<dl>
				<dt>비밀번호 <em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="Password1" name="member_pwd" value="<%=member_pwd %>"></dd>
			</dl>
			<dl>
				<dt>비밀번호확인 <em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="Password2" name="member_pwd2" value="<%=member_pwd %>"></dd>
			</dl>
			<dl>
				<dt>추천인 아이디</dt>
				<dd class="lst_txt"><%=recommend_id %></dd>
			</dl>
            
			<dl>
				<dt>이메일</dt>
				<dd><input type="text" id="usermail" name="member_email" value="<%=member_email %>"></dd>
			</dl>
			<dl>
				<dt>연락처<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="number" name="member_phone1" class="number" value="<%=member_phone1 %>"> - <input type="text" id="Text2" name="member_phone2" class="number" value="<%=member_phone2 %>"> - <input type="text" id="Text3" name="member_phone3" class="number" value="<%=member_phone3 %>"></dd>
			</dl>
            
             <% if userchange_flag = "2" then %>
             <dl>
				<dt>은행명<em style="display:inline;color:red">*</em></dt>
				<dd>
					<select name="bank_name" class="bankname">
						<option value="<%=bank_name %>"><%=bank_name %></option>
						<option>농협</option>
						<option>신협</option>
						<option>국민은행</option>
						<option>우리은행</option>
						<option>신한은행</option>
						<option>KEB하나은행</option>
						<option>기업은행</option>
						<option>부산은행</option>
						<option>외환은행</option>
						<option>광주은행</option>
						<option>대구은행</option>
						<option>전북은행</option>
						<option>SC제일은행</option>
						<option>경남은행</option>
						<option>새마을금고</option>
						<option>새마을금고</option>
						<option>우체국은행</option>
					</select>
				</dd>
			</dl>
            
            <dl>
				<dt>계좌번호<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="Text1" name="account_no" placeholder="( - )표시 없이 기재하여 주십시오" value="<%=account_no %>"></dd>
			</dl>
            <dl>
				<dt>예금주명<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="depname" name="bank_owner" value="<%=bank_owner %>" ></dd>
			</dl>
			<span class="red_type">* 예금주가 다른 경우 입금처리되지 않을 수 있습니다 </span>	
            <dl>
				<dt>환전신청 비밀번호<em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="changepwd" name="withdraw_pwd" value="<%=withdraw_pwd %>"></dd>
			</dl>
			<span class="red_type">* 4자 이상의 숫자로 사용하시고 비밀번호 누출을 주의하여 주시길 바랍니다  </span>	
            <% else %>
            <dl>
				<dt>환전정보변경<em style="display:inline;color:red">*</em></dt>
				<dd><input type="button" id="Password3" value="변경요청" class="btn_finish" onclick="javascript: memberChange();"></dd>
			</dl>
            <% end if %>
			<dl class="finish">
				<dd>
					<input type="button" value="취소하기"  class="btn_reset" />
					<input type="submit" value="정보수정"  class="btn_finish" />
				</dd>
			</dl>
            
         </form>
		<div>
		<!-- [e]회원정보수정 서식-->
			
		</div>
		
	</div>


<!-- #include virtual="/_include/connect_close.inc" -->

<!-- #include virtual="/_include/bottom_menu.inc" -->
