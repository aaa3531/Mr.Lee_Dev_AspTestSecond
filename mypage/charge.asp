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
      member_alias = rsMember("member_alias")
      member_phone = rsMember("member_phone")
      member_name = rsMember("member_name")
      bank_owner = rsMember("bank_owner")
    end if 
    set rsMember = nothing

  if request("result_desc") = "" then
     result_desc = "베팅용 게임포인트가 충전됩니다."
  else
     result_desc = request("result_desc")
  end if
  
  
    strSQL = "p_sm_member_detail '" & Session("member_no") & "'"
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      point_total = rs("point_total")
      money_total = rs("money_total")
    end if 
    
    set rs = nothing
%>
<script type="text/javascript">

    var xhr;
    function PWDCheck(elem) {
        member_pwd = document.getElementById("member_pwd").value;
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = Setbankinfo;
        xhr.open("POST", "pwdcheck.asp?member_pwd=" + member_pwd);
        xhr.send(null);

    }

    function Setbankinfo() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');
            document.getElementById("bank_info").value = slipdata[1];
            alert(slipdata[0]);
        }
    }

    </script>


<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 

<script>
  function CheckEng(data) {
    return (/^[a-z0-9]{5,12}$/).test(data);
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
  
    return true;
  }
</script>


<script language="javascript">
    
    function chargeCheck(form) {
        var pwd = form.member_pwd.value;
        var betamt = form.charge_amt.value;
        betamt2 = betamt % 10000;
        if (form.member_pwd.value == "") {
            alert("비밀번호를 확인 후 충전해주세요");
            form.member_pwd.focus();
            return false;
        }
        if (form.bank_info.value == "") {
            alert("비밀번호를 확인 후 충전해주세요");
            form.bank_info.focus();
            return false;
        }
        if (betamt2 != 0) {
            alert("10000원 단위로만 충전 가능합니다.");
            form.charge_amt.focus();
            return false;
        }
        if (form.charge_amt.value < 10000) {
            alert("10000원 이상부터 충전 가능합니다.");
            form.charge_amt.focus();
            return false;
        }

        var xhr2;
        xhr2 = new XMLHttpRequest();
        xhr2.onreadystatechange = function () {
            if (xhr2.readyState == 4) {
                var data = xhr2.responseText;
                if (data == 2) {
                    alert("비밀번호가 다릅니다.");
                    return false;
                }
                else {
                    charge_popup();
                    return true;
                }
            }
        };
        xhr2.open("POST", "charge_pwd_check.asp?member_pwd=" + pwd);
        xhr2.send(null);

    }

    function charge_popup() {
        var charge_amt = document.getElementById("charge_amt").value;
        var charge_name = document.getElementById("charge_name").value;
        var strurl = "charge_popup.asp?charge_amt=" + charge_amt + "&charge_name=" + charge_name;
        window.open(strurl, 'popup', 'width=500,height=190,left=450,top=250,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=no, scrollbars=no, copyhistory=no');
    }
</script>



	<!-- container -->
    
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">충전하기<span>베팅용 게임포인트가 충전됩니다. </span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>입금하실 계좌에 인터넷 뱅킹, 폰뱅킹, 무통장입금, ATM 등의 방법으로 입금합니다.</p>
			<ul>
				<li>&#45;<span class="emp">입금하신 금액과 동일한</span> 금액의 버튼을 눌러 입력하십시오.</li>
				<li>&#45;입금자명을 확인하시기 바랍니다.&#40;출금신청 <span class="emp">예금주와 동일</span>&#41;</li>
				<li>&#45;확인 버튼을 누르시면 입금절차가 완료됩니다.</li>
				<li>&#45;입금은 <span class="emp">만원단위</span>로 가능합니다.</li>
			</ul>
			</div>
		</div>
		<!-- [s]입금내역 서식-->
        <form id="form" name="formCharge" method="post"  >
		<div class="lst_mypage">
			<dl>
				<dt>비밀번호</dt>
				<dd>
                <input type="password" id="member_pwd" value="" onKeyUp="$('#pwdchkspan').html('<a onClick=PWDCheck()>계좌확인</a>');"> 
                   <input type="button" id="pwdchkspan" class="confirm" onClick='PWDCheck();' value="계좌확인" />
				</dd>
			</dl>
			<span>비밀번호 입력 후 계좌확인 버튼을 클릭하시면 계좌확인이 가능합니다.</span>
			<dl>
				<dt>입금계좌</dt>
				<dd>
                <input type="button" id="bank_info" value=""  disabled>&nbsp;
				</dd>

			</dl>
			<span class="red_type">*환전계좌의 예금주와 동일하지 않으면 충전이 되지 않습니다.</span>
			<dl>
				<dt>입금자명</dt>
				<dd>
                <input type="text" name="charge_name" ID="charge_name" value="<%=bank_owner %>" disabled>
				</dd>
				<dt>입금금액</dt>
				<dd>
                <input type="text" name="charge_amt" ID="charge_amt" value="10000" >
				</dd>
			</dl>
			<span class="red_type">*입금자명이 다르면 입금확인을 할 수가 없으니 주의하세요.</span>	
            <dl class="finish">
				<dd>
					<input type="button" value="새로작성"  class="btn_reset" />
			        <input type="button" value="충전하기"  class="btn_finish"  onclick="javascript:chargeCheck(form);" />
				</dd>
			</dl>
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
	</div>
    </form>
	</div>
		<!-- //content -->
	</div>
	<!-- //container -->

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
