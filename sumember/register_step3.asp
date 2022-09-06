<!-- #include virtual="/_include/header_register.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 
<script> 
    function IDCheck(){    
    id =   document.getElementById("memberid").value;
    if (!CheckEng(id)) {
      alert("아이디를 입력해주세요\n5~12글자 영문(소문자,숫자)로만 입력해주세요\n특수문자,공백은 사용할수 없습니다.");
      return false;
    }

    var mid = $("input[name=member_id]").val();     
    if(mid == undefined || mid== null){ mid = "";}     
    $.ajax({        type: "POST",        url: "idcheck.asp",        data: "mid="+mid.replace(/\+/gi, '%2B'),        error:function(){           alert("오류입니다.\n");        },        success: function(msg){           $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");        },        complete:function(){           $("#Work").remove();        }     });  }  
  

    function NICKCheck(){    
    alias =   document.getElementById("memberalias").value;
    if (!CheckHan(alias)) {
      alert("닉네임을 입력해주세요\n2~6글자 한글로만 가능합니다\n숫자,특수문자,공백을 사용할수없습니다.\nㄱ,ㄴ,ㄷ 등 독립자음,모음 사용불가능합니다.");
      return false;
    }

    var mnick = $("input[name=member_alias]").val();     
    if(mnick == undefined || mnick== null){ mnick = "";}     
    $.ajax({        type: "POST",        url: "nickcheck.asp",        data: "mnick="+mnick.replace(/\+/gi, '%2B'),        error:function(){           alert("오류입니다.\n");        },        success: function(msg){           $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");        },        complete:function(){           $("#Work").remove();        }     });  }  

    function RECOMMENDCheck(){     var mrecommend = $("input[name=recommend_id]").val();     
    if(mrecommend == undefined || mrecommend== null){ mrecommend = ""; }     
    $.ajax({        type: "POST",        url: "recommendcheck.asp",        data: "mrecommend="+mrecommend.replace(/\+/gi, '%2B'),        error:function(){           alert("오류입니다.\n");        },        success: function(msg){           $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");        },        complete:function(){           $("#Work").remove();        }     });  }  

</script> 

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
    if (!CheckEng(form.member_id.value)) {
      alert("아이디를 입력해주세요\n5~12글자 영문(소문자,숫자)로만 입력해주세요\n특수문자,공백은 사용할수 없습니다.");
      form.member_id.focus();
      return false;
    }
    if (!CheckHan(form.member_alias.value)) {
      alert("닉네임을 입력해주세요\n2~6글자 한글로만 가능합니다\n숫자,특수문자,공백을 사용할수없습니다.\nㄱ,ㄴ,ㄷ 등 독립자음,모음 사용불가능합니다.");
      form.member_alias.focus();
      return false;
    }
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
    if (!CheckEmail(form.member_email.value)) {
      alert("email형식이 일치하지 않습니다.");
      form.member_email.focus();
      return false;
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
    if (form.bank_name.value == "은행을 선택하세요") {
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
    if (!CheckWithdraw(form.withdraw_pwd.value)) {
      alert("환전신청 비밀번호를 입력해주세요\n4~8자 사이의 숫자로만 입력해주세요");
      form.withdraw_pwd.focus();
      return false;
    }
  
    return true;
  }
</script>





	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">회원가입<span>회원정보를 입력해주세요.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>항하사 증권 가입을 환영합니다.</p>
			<ul>
				<li><span class="emp">* 필수항목은 반드시 입력해 주시기 바랍니다.</span> </li>
			</ul>
			</div>
		</div>
		<!-- [s]입금내역 서식-->
        <form id="formMember" name="formMember" method="post" onsubmit="return JoinFormCheck(this)" action="register_set.asp" >
        <input type="hidden" name="flag" value="1" ID="Hidden4" />
		<div class="lst_mypage"> 

			<dl>
				<dt>아이디 <em style="display:inline;color:red">*</em></dt>
				<dd>
                <input type="text" id="memberid" name="member_id" onKeyUp="$('#idchkspan').html('<a onClick=IDCheck()></a>');" required />
                <a onClick='IDCheck();'><input type="button" class="confirm" value="중복확인"></input></a>
				</dd>
			</dl>
            <span>5~12자의 영문 또는 숫자조합이 가능합니다.</span>
			<span id="idchkspan"></span>


			<dl>
				<dt>닉네임 <em style="display:inline;color:red">*</em></dt>
				<dd>
                <input type="text" id="memberalias" name="member_alias" onKeyUp="$('#nickchkspan').html('<a onClick=NICKCheck()></a>');" required />
                <a onClick='NICKCheck();'><input type="button" class="confirm" value="중복확인"></input></a>
				</dd>
			</dl>
            <span>2~6자의 한글로만 사용가능합니다.</span>
			<span id="nickchkspan"></span>

			<dl>
				<dt>비밀번호 <em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="Password1" name="member_pwd" required></dd>
			</dl>
			<span>5~12자의 영문 또는 숫자조합이 가능합니다.</span>
			<dl>
				<dt>비밀번호확인 <em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="Password2" name="member_pwd2" required></dd>
			</dl>
			<dl>
				<dt>추천인아이디 <em style="display:inline;color:red">*</em></dt>
				<dd class="lst_txt"><%=request("recommend_id") %>
                <input type="hidden" name=recommend_id value="<%=request("recommend_id") %>" > 
				</dd>
			</dl>
			<dl>
				<dt>이메일</dt>
				<dd><input type="email" id="usermail" name="member_email" required></dd>
			</dl>
			<dl>
				<dt>성별</dt>
				<dd><input type="radio" id="frm_type17" class="radio_type" value="M" name="sex_flag" checked>남자
				<input type="radio" id="frm_type22" class="radio_type" value="F" name="sex_flag">여자
				</dd>
			</dl>
			<dl>
				<dt>연락처<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="number" name="member_phone1" class="number" size="4" maxlength="4" required> - <input type="text" id="Text1" name="member_phone2" class="number" size="4" maxlength="4" required> - <input type="text" id="Text2" name="member_phone3" class="number" size="4" maxlength="4" required></dd>
			</dl>
        
			<span>* 정확하게 기재하지 않을 경우 불이익을 받을 수 있습니다 </span>
			
			<dl>
				<dt>은행명<em style="display:inline;color:red">*</em></dt>
				<dd>
					<select  name="bank_name" class="bankname" required>
						<option>은행을 선택하세요</option>
						<option>농협</option>
						<option>신협</option>
						<option>수협</option>
						<option>국민은행</option>
						<option>우리은행</option>
						<option>신한은행</option>
						<option>하나은행</option>
						<option>시티은행</option>
						<option>기업은행</option>
						<option>부산은행</option>
						<option>외환은행</option>
						<option>광주은행</option>
						<option>대구은행</option>
						<option>전북은행</option>
						<option>SC제일은행</option>
						<option>경남은행</option>
						<option>새마을금고</option>
						<option>우체국은행</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>계좌번호<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="Text3" name="account_no" placeholder="( - )표시 없이 기재하여 주십시오" required></dd>
			</dl>
			<dl>
				<dt>예금주명<em style="display:inline;color:red">*</em></dt>
				<dd><input type="text" id="depname" name="bank_owner" required></dd>
			</dl>
			<span class="red_type">* 예금주가 다른 경우 입금처리되지 않을 수 있습니다 </span>	
			<dl>
				<dt>환전신청 비밀번호<em style="display:inline;color:red">*</em></dt>
				<dd><input type="password" id="changepwd" name="withdraw_pwd" required></dd>
			</dl>
			<span class="red_type">* 4자 이상의 숫자로 사용하시고 비밀번호 누출을 주의하여 주시길 바랍니다  </span>	
			<dl class="finish">
				<dd>
					<input type="button" value="취소하기"  class="btn_reset" />
					<input type="submit" value="회원가입"  class="btn_finish" />
				</dd>
			</dl>
			
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
		
	</div>
    </form>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
