<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->


<%
    strSQL = "p_sm_parameter_account_read '" & request("parameter_cd") & "'" 

    'response.write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rsGrade)
     ' 페이지 작동되는 방식
     Set rsParameter = Server.CreateObject("ADODB.RecordSet")
     rsParameter.cursorlocation = 3
     rsParameter.Open strSQL, DbCon, 1, 3
    
     if rsParameter.EOF or rsParameter.BOF then
    	NoDataParameter = True
      Else
    	NoDataParameter = False
        withdraw_fee = rsParameter("withdraw_fee")
     end if 

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
      bank_name = rsMember("bank_name")
      bank_owner = rsMember("bank_owner")
      account_no = rsMember("account_no")
      point_total = rsMember("point_total")
    end if 
    set rsMember = nothing

  if request("result_desc") = "" then
     result_desc = "환전입니다."
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

<SCRIPT language="javascript">

    function FormatNumber(num) {
     var str = num;
     var Re = /[^0-9]/g;
     var ReN = /(-?[0-9]+)([0-9]{3})/;
     str = str.replace(Re, '');
     while (ReN.test(str)) {
         str = str.replace(ReN, "$1,$2");
     }
     return str;
    }

    function withdraw_calculate() {
        var sum1 = document.getElementById("withdraw_net_amt");
        var amt1 = document.getElementById("withdraw_fee");
        var pre1 = document.getElementById("withdraw_amt");
        var str = FormatNumber(amt1.value);
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.value;
        str2 = str2.replace(/\,/gi, "")
        pre1.value = FormatNumber("" + parseInt(str2 - str / 100 * str2));
        //alert(pre1.value);
        document.getElementById("withdraw_amt2").value = FormatNumber("" + parseInt(str2 - str / 100 * str2));
        prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
    }

</script>

<script language="javascript">

    
    function withdrawCheck(form) {
        var pwd = form.withdraw_pwd.value;
        var withdrawamt = form.withdraw_net_amt.value;
        var point_total = document.getElementById("point_total").innerHTML;
        withdrawamt2 = withdrawamt % 10000;
        if (form.withdraw_pwd.value == "") {
            alert("비밀번호를 확인 후 충전해주세요");
            form.withdraw_pwd.focus();
            return false;
        }
        if (withdrawamt2 != 0) {
            alert("10000원 단위만 환전 가능합니다.");
            form.withdraw_net_amt.focus();
            return false;
        }
        if (Number(withdrawamt) > Number(point_total)) {
            alert("환전금액이 보유금액보다 큽니다.");
            form.withdraw_net_amt.focus();
            return false;
        }
        if (form.withdraw_net_amt.value < "10000") {
            alert("출금금액이 10000원 이상이어야 환전 가능합니다.");
            form.withdraw_net_amt.focus();
            return false;
        }

        var xhr2;
        xhr2 = new XMLHttpRequest();
        xhr2.onreadystatechange = function () {
            if (xhr2.readyState == 4) {
                var data = xhr2.responseText;
                if (data == 2) {
                    alert("환전비밀번호가 다릅니다.");
                    return false;
                }
                else
                {
                    withdrawPopup();
                    return true;
                }
            }
        };
        xhr2.open("POST", "withdraw_pwd_check.asp?withdraw_pwd=" + pwd);
        xhr2.send(null);

    }
    
    function withdrawPopup(form) {
        var withdraw_net_amt = document.getElementById("withdraw_net_amt").value;
        var withdraw_pwd = document.getElementById("withdraw_pwd").value;
        var strurl = "withdraw_popup.asp?withdraw_net_amt=" + withdraw_net_amt + "&withdraw_pwd=" + withdraw_pwd;
        window.open(strurl, 'popup', 'width=500,height=190,left=450,top=250,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=no, scrollbars=no, copyhistory=no');
    }

    function reLoad() {
        location.href = "withdraw.asp";
    }
</script>

	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">환전하기<span>베팅용 게임포인트가 환전됩니다. </span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>베팅용 게임포인트가 환전됩니다.</p>
			
			</div>

		</div>

				<div class="lst_mypage lst_mypage_v2">
			<dl>
				<dt>입금은행</dt>
				<dd  class="lst_txt">: <%=bank_name %></dd>
			</dl>
			<dl>
				<dt>계좌번호</dt>
				<dd class="lst_txt">: <%=account_no %></dd>
			</dl>
		
			<dl>
				<dt>예금주</dt>
				<dd class="lst_txt">: <%=bank_owner %></dd>
				<dt>보유금액</dt>
				<dd class="lst_txt">: <strong id="point_total"><%=point_total %></strong></dd>
			</dl>
			<span class="red_type">* 환전시간 : 실시간 환전이 가능합니다.</span>	
			
		
		<div>
		

			
		</div>
		
	</div>


<% '아래부분 %>


        <form id="form" name="formWithdraw" method="post"  >
        <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden3"> 
        <input type="hidden" name="withdraw_fee" id="withdraw_fee" value="<%=withdraw_fee %>" > 
        <input type="hidden" name="withdraw_amt" id="withdraw_amt" value="<%=withdraw_amt %>" > 
        <div class="lst_mypage">
                <dl>
                    <dt>
                     출금금액 :</dt>
                        <dd><input type="text" name="withdraw_net_amt" onkeyup="withdraw_calculate();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();"  style="width:100px;" class="input" ID="withdraw_net_amt" value="0" >&nbsp;</dd>
                </dl>
                <dl>
				<dt>환전비밀번호</dt>
                        <dd><input type="password" name="withdraw_pwd" id="withdraw_pwd" style="width:100px;" class="input" value="" >&nbsp;</dd>
			    </dl>
               <dl>
				<dt>환전 수수료</dt>
				<dd class="lst_txt">:
                        <%=rsParameter("withdraw_fee") %>%</dd>
                   <dt>실수령액</dt>
				<dd class="input"><input ID="withdraw_amt2" disabled></input>&nbsp;</dd>
               </dl>
                <span class="red_type">* 10,000원 이상부터 환전이 가능합니다.</span>
                
			<dl class="finish">
				<dd>
					<input type="button" value="새로작성"  class="btn_reset" onclick="javascript: reLoad();" />
                    <input type="button"  class="btn_finish" value="환전하기" onclick="javascript: withdrawCheck(form);">
				</dd>
			</dl>	
        </div>    
		<div>
		
		<!-- [e]입금내역 서식-->
			
		</div>
        </form>

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
