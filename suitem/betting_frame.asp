<!-- #include virtual="/_include/header_basic.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<% 
  
  if request("result_desc") = "" then
     result_desc = "중복 베팅이 가능합니다."
  else
     result_desc = request("result_desc")
  end if
	
  if request("result_no") <> "" then
     result_no = request("result_no")
  end if
  'response.Write result_no
  'response.End
  
  strSQL = "p_sh_game_basket_item_member '" & Session("member_no") & "' "
  'response.Write strSQL
  'response.end
    
  Set rsBasket = Server.CreateObject("ADODB.RecordSet")
  rsBasket.Open strSQL, DbCon, 1, 1
  
  if rsBasket.EOF or rsBasket.BOF then
	  NoBasket = True
  Else
	  NoBasket = False
  end if  
   
   
    strSQL = "p_sm_game_item_member_detail '" & Session("member_no") & "','" & result_no & "','" & session("current_game") & "'"
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      fee_rate = rs("fee_rate")
      point_total = rs("point_total")
      Session("point_total") = rs("point_total")

    'response.write fee_rate & "<br>"
    'response.write mybet_amt & "<br>"  

    
    'if cint(point_total) < cint(mybet_amt) then mybet_amt = point_total end if

    end if 

%>


<% if result_no = "1" then %>
<SCRIPT language="javascript">
    parent.clearStock();
</script>
<% end if %>

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

    function amt_calculate() {
        var sum1 = document.getElementById("dividend_rate_total");
        var amt1 = document.getElementById("bet_point");
        var pre1 = document.getElementById("bet_amt_predict");
        var str = FormatNumber(amt1.value);
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.value;
        str2 = str2.replace(/\,/gi, "")
        pre1.value = FormatNumber("" + parseInt(str * str2));
        prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
    }


    function ToggleColor(obj, type) {
        if (type == 1) {
            if (obj.className == 'betbtn_ov') obj.className = 'betbtn_normal';
        } else {
            if (obj.className == 'betbtn_normal') obj.className = 'betbtn_ov';
        }
    }

    function AddBetSlip(game_sn, bet_select) {
        LoadingLayerOn();
        document.getElementById('FrameBetSlip').src = "/inc/betslip.asp?mode=add&game_sn=" + game_sn + "&bet_sel=" + bet_select;
        var name = 'GameTable_' + game_sn + '_' + bet_select;
    }

    function LoadingLayerOn() {
        var tempX = 0;
        var tempY = 0;
        tempX = event.clientX + document.body.scrollLeft;
        tempY = event.clientY + document.body.scrollTop;
        if (tempX < 0) { tempX = 0; }
        if (tempY < 0) { tempY = 0; }
        div_loading.style.left = tempX - 105 / 2;
        div_loading.style.top = tempY - 54 / 2;
        div_blackscreen.style.top = document.body.scrollTop;
        div_blackscreen.style.display = 'block';
        div_loading.style.display = 'block';
    }
    function LoadingLayerOff() {
        div_blackscreen.style.display = 'none';
        div_loading.style.display = 'none';
    }



</SCRIPT>

    <style>
      body {
        margin: 0px;
        padding: 0px;
      }
      .jbTitle {
        text-align: center;
      }
      .jbMenu {
        text-align: center;
        width: 270px;
      }
      .jbContent {
        height: 2000px;
      }
      .jbFixed {
        position: fixed;
        top: 0px;
      }
    </style>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

    <script>
      $( document ).ready( function() {
        var jbOffset = $( '.jbMenu' ).offset();
        $( window ).scroll( function() {
          if ( $( document ).scrollTop() > jbOffset.top ) {
            $( '.jbMenu' ).addClass( 'jbFixed' );
          }
          else {
            $( '.jbMenu' ).removeClass( 'jbFixed' );
          }
        });
      } );
    </script>
    
<script language="javascript">
    
    function ItemBetting() {
        alert("베팅확인");
        formItem.submit();
    }
    //function bet_popup() {
    //    var bet_point = document.getElementById("bet_point").value;
    //    var strurl = "bet_popup.asp?bet_point=" + bet_point;
    //    window.open(strurl, 'popup', 'width=300,height=104,left=500,top=300,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=yes, scrollbars=no, copyhistory=no');
    // }
</script>

<div class="jbMenu" >


<div class="aside">
				<div class="info_type">
					<p><span>공지</span><img src="img/5px_arrow.gif" width="5" height="5">항하사 공지사항을 확인하세요</p>
				</div>
				<!--left_profile -->	
                <!-- #include virtual="/_include/left_profile.asp" -->
				
				<div class="info_type">
					<p><span>안내</span><img src="img/5px_arrow.gif" width="5" height="5">중복베팅이 가능합니다</p>
				</div>

               <div class="top betting">
					 
					 
						<div class="myinfo">
							<div class="myinfo_top">
							<span>베팅슬립 Betting Slip</span>
							</div>
							
							<!-- S : 종목 클릭시 베팅슬립 종목명 나타나는 박스 -->
							<div class="betting_name">
							<dl >
								<dt>종목이름<em>vs</em>종목이름</dt>
								<dd class="txt4"><a href="#"><img src="img/x.gif" width="11" height="11"/></a></dd>
							
							</dl>
							</div>
							<!-- E : 종목 클릭시 베팅슬립 종목명 나타나는 박스 -->							
							<div class="myinfo_center">
							<dl >
								<dt>예상배당률</dt>
								<dd class="txt3"><strong>157.7</strong></dd>
							
							</dl>
							<dl>
								<dt>예상배당금</dt>
								<dd class="txt3"><strong>788,540</strong></dd>
								
							</dl>
							<dl>
								<dt>베팅금액</dt>
								<dd class="max">MAX</dd>
								<dd><input type="text"></dd>
								
							</dl>
							</div>
							
							<div class="btn_money">
								<input type="button"  value="10,000"></input>
								<input type="button"  value="30,000"></input>
								<input type="button"  value="50,000"></input>
								<input type="button"  value="100,000"></input>
								<input type="button"  value="500,000"></input>
								<input type="button"  value="1,000,000"></input>

							</div>
							
									
						</div>
					</div>
							<div class="btn_betting">
							<input type="submit" value="베 팅" class="btn_bt">
							<input type="submit" value="베팅취소" class="btn_btc">
						</div>	

 </div>




    <% if NoBasket = False then ' 데이터가 있으면 데이터 출력 %>
    <form action="item_bet.asp" id="form2" name="formItem" method="post">
    <% 
       item_cnt = 0
       Do While Not rsBasket.EOF    %> 
      <input type="hidden" name="game_no_<%=item_cnt %>" value="<%=rsBasket("game_no") %>" />
      <div style="padding:3px 0 3px 0  ;">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr height="25">
      <td width="82%" onmouseover="ToggleColor(this,0)" onmouseout="ToggleColor(this,1);" onclick="AddBetSlip(4504866,0);">
       <% if rsBasket("select_no") = "1" then %>
       <span style="color:#F7941C;font-weight:bold;"><%=rsBasket("company_name1") %></span>
       <span style="color:#FF0000;">vs.</span>
       <span style="color:#ffffff;"><%=rsBasket("company_name2") %></span>
       <% else %>
       <span style="color:#ffffff;"><%=rsBasket("company_name1") %></span>
       <span style="color:#FF0000;">vs.</span>
      <span style="color:#F7941C;font-weight:bold;"><%=rsBasket("company_name2") %></span>
       <% end if %>           
      </td>
      <td width="18%" align="right">
       <span style="color:#ffffff;" >
       <% if rsBasket("select_no") = "1" then %>
       <%=rsBasket("dividend_rate1") %>
       <% else %>
       <%=rsBasket("dividend_rate2") %>
       <% end if %><br />
      <a href="item_basket_delete.asp?game_no=<%=rsBasket("game_no") %>"><span style="color:#ff6600; font-weight:bold;">X</span></a>  
       </span>
      </td>
      </tr>
      </table>
      </div>
      <div style="margin:5px 0 0 0;padding:3px;background-color:#00856A;border-radius: 2px;">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr height="22">
      <td width="50%" align="right"><span style="font-weight:bold;color:#000000;">
      예상배당률&nbsp;</span>
      </td>
      <td width="50%" align="right">
      <input type="button" id="dividend_rate_<%=item_cnt %>" name="dividend_rate"  style="width:100%;height:100%;border:dotted 0px #ffffff;color:#ffffff;background-color:#00856A;text-align:right;" value="<%=rsBasket("dividend_rate") %>" />
      </td>
      </tr>
      <tr height="22">
      <td width="50%" align="right"><span style="font-weight:bold;color:#000000;">
      예상배당금&nbsp;</span>
      </td>
      <td width="50%" align="right">
      <input type="button" id="dividend_amt_predict_<%=item_cnt %>" name="bet_amt_predict"  style="width:100%;height:100%;border:dotted 0px #ffffff;color:#ffffff;background-color:#00856A;text-align:right;" value="<%=rsBasket("dividend_amt_predict") %>" />
      </td>
      </tr>
      <tr height="22">
      <td width="50%" align="right"><span id="bet_amt" style="font-weight:bold;color:#000000;">
      베팅금액&nbsp;</span>
      </td>
      <td width="50%" align="right">
      <input type="text" id="bet_point_<%=item_cnt %>" name="bet_point_<%=item_cnt %>" onkeyup="amt_calculates_<%=item_cnt %>();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();" style="width:100%;height:100%;border:dotted 1px #ffffff;font-weight:bold;color:#ffffff;background-color:#47B7AD;text-align:center;" value="5,000" />
      </td>
      </tr>
      </table>
      </div>
      
      <script>
      function amt_calculates_<%=item_cnt %>() {
        var sum1 = document.getElementById("dividend_rate_<%=item_cnt %>");
        var amt1 = document.getElementById("bet_point_<%=item_cnt %>");
        var pre1 = document.getElementById("dividend_amt_predict_<%=item_cnt %>");
        var str = FormatNumber(amt1.value);
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.value;
        str2 = str2.replace(/\,/gi, "")
        pre1.value = FormatNumber("" + parseInt(str * str2));
        prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
      }
      </script>

      <%
        item_cnt = item_cnt + 1
        rsBasket.MoveNext
	    Loop 
      %>
      <input type="hidden" name="item_cnt" value="<%=item_cnt %>" />
      </form>



      <div style="padding:10px 0 3px 0;background-color:#000000;color:#ffffff;">
      <input type="submit" onclick="javascript: ItemBetting()" value="배팅하기" />
      </div>
	<% else %>
    <div style="margin:3px;padding:10px;background-color:#000000;color:#ffffff;text-align:center;">
    게임별 종목을 선택 베팅하세요.<br />
    ( <a target="_parent" href="/mypage/"><Span style="color:#FFD595;">MY PAGE</Span></a> 에서 취소 및 결과확인)
    </div>
    <% end if         
    set rsBasket = nothing
    %> 
    
    </div>   
<!-- #include virtual="/_include/connect_close.inc" -->