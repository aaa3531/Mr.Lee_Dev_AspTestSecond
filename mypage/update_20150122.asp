<!-- #include virtual="/_include/top_menu_user.inc" -->
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
    if (!CheckEng(form.withdraw_pwd.value)) {
      alert("비밀번호를 입력해주세요\n5~12글자 영문(소문자,숫자)로만 입력해주세요\n특수문자,공백은 사용할수 없습니다.");
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



  <div style="height:20px;"></div>
<table  width=1024 align=center>
<tr>

<td width=754 valign=top>

   <% membermenu = "정보수정"
   menu_desc = "정보수정"
    %>
<!-- #include virtual="/_include/guide_admin_mypage.inc" -->

<div style="padding:20px 0 10px 20px; width:97%; text-align:left; font-weight:bold; font-size:15px; border-bottom:dotted 1px;">정보수정</div>

    <form id="formMember" name="formMember" method="post" onsubmit="return JoinFormCheck(this)" action="update_set.asp" >
    <input type="hidden" name="flag" value="1" ID="Hidden4"> 
    <table border=0 cellpadding="0" cellspacing=0 border="0"  width="100%">  
         

      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%">
      </td>
      <td width="80%" align="right">
      <span style="color:#ff0000; font-weight:bold;">*</span>
      <span style="color:#ff6600;">필수항목은 반드시 입력해주시기 바랍니다.</span> 
      </td>
      </tr>

      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;이름
      </td>
      <td width="80%">
      <%=member_name %>
      </td>
      </tr>

      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;아이디
      </td>
      <td width="80%" align="left">
      <%=member_id %>
     </td>
      </tr>
      
      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;닉네임
      </td>
      <td width="80%" align="left">
      <%=member_alias %>
      </td>
      </tr>

      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;비밀번호
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <input type="password" name="member_pwd" size="255" style="width:120" class="input" ID="Password1" value="<%=member_pwd %>" >
      </td>
      </tr>
      
      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;비밀번호확인
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <input type="password" name="member_pwd2" size="255" style="width:120" class="input" ID="Password2" value="<%=member_pwd %>">
      </td>
      </tr>
      
      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;추천인 아이디
      </td>
      <td width="80%" align="left">
      <%=recommend_id %>
      </td>
      </tr>

      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;이메일
      </td>
      <td width="80%">
      <input type="email" name="member_email" size="255" style="width:280" class="input" ID="Text5" value="<%=member_email %>">
      </td>
      </tr>
      
      <tr height="32"  style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;성별
      </td>
      <td width="80%">
      <% if sex_flag = "M" then %>남자
      <% else %>여자
      <% end if %>
      </td>
      </tr>

      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;연락처
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
            <input name="member_phone1" class="input1" type="text" size="4" value="<%=member_phone1 %>">
            - 
            <input name="member_phone2" class="input1" type="text" size="4" value="<%=member_phone2 %>">
            - 
            <input name="member_phone3" class="input1" type="text" size="4" value="<%=member_phone3 %>">
            
      </td>
      </tr>

      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;은행명
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <select name="bank_name">
              <option value="<%=bank_name %>"><%=bank_name %></option>
              <option value="국민">국민</option>
              <option value="기업">기업</option>
              <option value="농협">농협</option>
              <option value="신한">신한(구조흥포함)</option>
              <option value="외환">외환</option>
              <option value="우체국">우체국</option>
              <option value="SC제일">SC제일</option>
              <option value="하나">하나</option>
              <option value="한국씨티">한국씨티(구한미)</option>
              <option value="우리">우리</option>
              <option value="경남">경남</option>
              <option value="광주">광주</option>
              <option value="대구">대구</option>
              <option value="도이치">도이치</option>
              <option value="부산">부산</option>
              <option value="산업">산업</option>
              <option value="수협">수협</option>
              <option value="전북">전북</option>
              <option value="제주">제주</option>
              <option value="새마을금고">새마을금고</option>
              <option value="신용협동조합">신용협동조합</option>
              <option value="홍콩상하이(HSBC)">홍콩상하이(HSBC)</option>
              <option value="상호저축은행중앙회">상호저축은행중앙회</option>
            </select>&nbsp;&nbsp;* 정확하게 기재하지 않을 경우 불이익을 받을 수 있습니다
      </td>
      </tr>
      
      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;계좌번호
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <input type="text" name="account_no" size="255" style="width:120" class="input" ID="Text4" value="<%=account_no %>">&nbsp;&nbsp;* -표시 없이 기재하여 주십시오
      </td>
      </tr>

      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;예금주명
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <input type="text" name="bank_owner" size="255" style="width:120" class="input" ID="Text7" value="<%=bank_owner %>">&nbsp;&nbsp;* 예금주가 틀린 경우 입금처리되지 않을 수 있습니다
      </td>
      </tr>

      <tr height="32" style="border-bottom:dotted 1px;">
      <td width="20%" align="left"><img src="../images/icon_redbar.png" width="4" height="9">&nbsp;환전신청 비밀번호
      <span style="color:#ff0000; font-weight:bold;">*</span>
      </td>
      <td width="80%">
      <input type="password" name="withdraw_pwd" size="255" style="width:120" class="input" ID="Text8" value="<%=withdraw_pwd %>">&nbsp;&nbsp;* 4자 이상의 숫자로 사용하시고 비밀번호 누출을 주의하여 주시길 바랍니다
      </td>
      </tr>

      <tr height="12">
      </tr>
      <tr height="35">
      <td colspan="2" align="center">
      <input type="submit" value="정보수정">
      <div style="margin:25px 0 0 0;padding:5px;text-align:center;line-height:180%;">
      </div>
      </td>
      </tr>
      </table>
    </form>


</td>


<td width=270 valign=top>

  
   <div style="margin:0 0 0 5px ;">
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_mypage.asp" -->
       </div>
</td>


</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->

<!-- #include virtual="/_include/bottom_menu.inc" -->
