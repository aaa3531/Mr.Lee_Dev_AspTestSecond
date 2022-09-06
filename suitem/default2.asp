<!-- #include virtual="/_include/header_item.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_sm_gameday_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    turn_no = rs("turn_no")
    yyyymmdd = rs("game_day")
    open_flag = rs("open_flag")
    item_flag = rs("item_flag")
    item_status = rs("item_status")
  
  end if   

  set rs = nothing  

  'response.write result_no 
  
  'response.write Session("point_total")
        
  strSQL = "p_sh_game_basket_item_list '" & Session("member_no") & "'"  
  'response.write strSQL
  
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
  'response.write strSQL
  'response.End

  strSQL = "p_sm_message_list 'I' " 
  
  'response.write strSQL
  'response.End

  Set rsMessage = Server.CreateObject("ADODB.RecordSet")
  rsMessage.Open strSQL, DbCon, 1, 1
    
  if rsMessage.EOF or rsMessage.BOF then
	NoDataMessage = True
  Else
	NoDataMessage = False
  end if  

  
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
<script type="text/javascript">
    
    function resizeIframe(obj) {
        obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
    } 

    function SelfReload()
    {
        document.location.reload();
    }


    function ToggleColor(obj, type) {
        if (type == 1) {
            if (obj.className == 'betbtn_ov') obj.className = 'betbtn_normal';
        } else {
            if (obj.className == 'betbtn_normal') obj.className = 'betbtn_ov';
        }
    }

    function clearStock()
    {
        var	myNodelist = document.getElementsByName("stock1");
        //document.getElementById('test111').className = "betbtn2_select";
        var i;
        for (i = 0; i <	myNodelist.length; i++) 
        {   
            myNodelist[i].setAttribute("class","betbtn_normal");
        }
    }



    var xhr;
    //var elem1;
    function getSelectItem(elem) {
        //elem1 = elem;
        game_no = elem.getAttribute("att_game");
        select_no = elem.getAttribute("att_select");
        //status_no = elem.getAttribute("att_status");
        xhr = new XMLHttpRequest();
;
        d_no1 = "div1_"+game_no;
       // document.getElementById(d_no1).className = "betbtn_normal";
        d_no2 = "div2_"+game_no;
        
        game1_no = document.getElementById(d_no1).getAttribute("att_game");
        game2_no = document.getElementById(d_no2).getAttribute("att_game");
        status1_no = document.getElementById(d_no1).getAttribute("att_status");
        status2_no = document.getElementById(d_no2).getAttribute("att_status");
        clearStock();
        if ( select_no == 1 )
        {
          document.getElementById(d_no2).setAttribute("att_status","0");
          if ( status1_no == 0 )
          {
            document.getElementById(d_no1).className = "betbtn_select";
            document.getElementById(d_no1).setAttribute("att_status","1");
          }
          else
          {
            document.getElementById(d_no1).setAttribute("att_status","0");
          }
        }
        else
        {        
          document.getElementById(d_no1).setAttribute("att_status","0");
          if ( status2_no == 0 )
          {
            document.getElementById(d_no2).className = "betbtn_select";
            document.getElementById(d_no2).setAttribute("att_status","1");
          }
          else
          {
            document.getElementById(d_no2).setAttribute("att_status","0");
          }
        }
        
        xhr.onreadystatechange = SelectItem;
        xhr.open("Get", "item_basket_set.asp?game_no="+game_no+"&select_no="+select_no);
        xhr.send(null);
        fFrameReload();

    }

    function SelectItem() {
        if (xhr.readyState == 4) {
            //status_no1 = elem.getAttribute("name3");
            //alert(status_no1);
            var data = xhr.responseText;
            var slipdata = data.split(',');
            //alert("aaa");
            document.getElementById("dividend_rate_total").value = slipdata[0];
            document.getElementById("bet_amt_predict").value = slipdata[1];
        }
    }

    function fFrameReload()
    {
        var iframe = document.getElementById('bettingframe');
        iframe.src = iframe.src;
    }



    var nbsp = 100;
    var cnt = nbsp;
    var pos = -1;
    var speed = 40;
    var delay = 3000;

    var ary = new Array();
    <% if NoDataMessage = False then  %>
    <% Do While Not rsMessage.EOF  %> 
    <%=" ary.push('<font color=#000000>" & rsMessage("message_desc") & "</font>'); " %>
    <% 	
        rsMessage.MoveNext
    Loop 
    else
    %>
    ary.push('<font color=#000000>[09-25 09:18] 흘러가는 글자 소스입니다. 도움이 되셨으면 합니다.</font>');
    ary.push('<font color=8fe4e3>[09-24 15:03] 전광판처럼 꾸며서 예쁘게 활용하시기 바랍니다.</font>');
    ary.push('<font color=f8a2a2>[09-24 14:44] 흐르는 항목 추가시는 ary를 추가하시면 됩니다.</font>');
    <% 
    end if
    set rsMessage=nothing
    %>


    window.onload = function () {
        fncInit();
    }

    function fncInit() {
        pos++;
        if (pos > ary.length - 1) pos = 0;
        fncMoveText();
    }

    function fncMoveText() {
        var str = '';
        for (var i = 0; i < cnt; i++) {
            str += '&nbsp;';
        }

        document.getElementById('scrl').innerHTML = '<nobr>' + str + ary[pos] + '<nobr>';

        if (cnt == 0) {
            cnt = nbsp;
            setTimeout(fncInit, delay);
        }
        else {
            cnt--;
            setTimeout(fncMoveText, speed);
        }

    }
    
    function startStocks()
    {
        var	myNodelist = document.getElementsByName("stock_rate");
        var i;
        for (i = 0; i <	myNodelist.length; i++) 
        {
            myNodelist[i].style.color = "#47B7AD";
        }
    }

    function endStocks()
    {
        var	myNodelist = document.getElementsByName("stock_rate");
        var i;
        for (i = 0; i <	myNodelist.length; i++) 
        {
            myNodelist[i].style.color = "#000000";
        }
        setTimeout("readStocks2()",5000);
    }


</SCRIPT>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 

<script> 
    function readStocks2(){
    startStocks();
    var	myNodelist = document.getElementsByName("stock1");
    //status=myNodelist[0].getAttribute("att_status");
    //open_flag = document.getElementById("open_flag").value;
    //alert(open_flag);
    var i;
    for (i = 0; i <	myNodelist.length; i++) 
    {
    var gno = myNodelist[i].getAttribute("att_game");   
    //if(gno == undefined || gno== null)     { mrecommend = ""; }         
    $.ajax({        type: "GET",        url: "item_rate_set.asp",        data: "game_no="+gno,        error:function(){            $("body").append("<div id=\"Work\" style=\"display:none;\">item error</div>")        },        success: function(msg){    $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");  },        complete:function(){           $("#Work").remove();        }     });
    }
    setTimeout("endStocks()",1000);
    }  
</script> 





<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent">

					<div class="snb_title">
					<ul>
						<li class="snb_01">종목매치</li>
						<li class="snb_ing"><img src="/img/ico_ing.gif" width="41" height="18" /></li>
						<li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2)%>일 <%=turn_no%>회차 - (<%=item_status%>)</li>
					</ul>
				</div>
				
		    <!--[s] Flow 텍스트 박스 -->
					
                <form name='frm'>
                      <div class="flow_txt" id='scrl'></div>
                </form>
		    <!--[e] Flow 텍스트 박스 -->		
            
                <input type="hidden" name="game_no" id="gameno" value="<%=game_no %>" />
                <input type="hidden" name="select_no" id="select_no" value="<%=select_no %>" />
                <input type="hidden" name="open_flag" id="open_flag" value="<%=open_flag %>" />
                <input type="hidden" name="game_i" id="game_i" value="0" />		

                
	<!--[s] 종목별매치 테이블-->
  <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="게임,배당,결과를 알려주는표" class="tbl_game"  style="table-layout:fixed;" >
						<caption>종목별 매치</caption>
						
						<colgroup>
							<col width="190">
							<col width="20">
							<col width="190">
							<col width="60 ">
							<col width="60">
							<col width="150">
						</colgroup>

					   <thead>
								<tr>
									<th colspan="3">게임</th>
									<th colspan="2">배당</th>
									<th>결과</th>
								</tr>
					   </thead>
					  <tbody>
						

                        <% if Session("member_no") <> "" then %>
                        <% if Session("grade_cd") = "U" then %>
                          <tr>
                          <td valign="top">
                            <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                            <% 
                               Do While Not rsData.EOF    %> 
                            <tr >
                            <td align="center" >
                              <% if rsData("status_flag") = "1" then %>
                                <% if rsData("select_no") = "1" then %>
                                <div name="stock1" id='div1_<%=rsData("game_no") %>' onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_select" att_game="<%= rsData("game_no") %>" att_select="1" att_status="1" >
                                <% else %>
                                <div name="stock1" id="div1_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_normal" att_game="<%= rsData("game_no") %>" att_select="1" att_status="0" >
                                <% end if %>
                                <% if rsData("company_name1") <> "" then  %>            
                                  <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
                                  <%=rsData("company_name1") %>
                                <% else %>
                                  (종목1 미할당)
                                <% end if %>
                                </div>
                              <% else %>
                                <div name="stock1" id="div1_<%=rsData("game_no") %>"  >
                                <% if rsData("company_name1") <> "" then  %>            
                                  <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
                                  <%=rsData("company_name1") %>
                                <% else %>
                                  (종목1 미할당)
                                <% end if %>
                                </div>
                              <% end if %>
                            </td>
                            <td>vs</td>
                            <td align="center" >
                              <% if rsData("status_flag") = "1" then %>
                                <% if rsData("select_no") = "2" then %>
                                <div name="stock1" id='div2_<%=rsData("game_no") %>' onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_select" att_game="<%= rsData("game_no") %>" att_select="2" att_status="1">
                                <% else %>
                                <div name="stock1" id="div2_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_normal" att_game="<%= rsData("game_no") %>" att_select="2" att_status="0">
                                <% end if %>
                                <% if rsData("company_name2") <> "" then  %>            
                                   <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
                                   <%=rsData("company_name2") %>
                                <% else %>
                                   (종목2 미할당)
                                <% end if %>
                                </div>
                              <% else %>
                                <div name="stock1" id="div2_<%=rsData("game_no") %>" >
                                <% if rsData("company_name2") <> "" then  %>            
                                  <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
                                  <%=rsData("company_name2") %>
                                <% else %>
                                  (종목2 미할당)
                                <% end if %>
                                </div>
                              <% end if %>          
                            </td>
                            <td><span name="stock_rate" id='rate1_<%=rsData("game_no") %>'><%=rsData("dividend_rate1") %></span></td>
                            <td><span name="stock_rate" id='rate2_<%=rsData("game_no") %>'><%=rsData("dividend_rate2") %></span></td>
                            <td>
                            <% if rsData("status_flag") = "3" then %>
                            <span >
                                <% if rsData("win_no") ="1" then %><%=rsData("company_name1") %>
                                <% elseif rsData("win_no") ="2" then %><%=rsData("company_name2") %>
                                <% else %>(결과)
                                <% end if %>
                            </span>
                            <% else %>
                              <% if rsData("status_flag") = "1" then %>
                              <span ><%=rsData("status_desc") %></span>
                              <% else %>
                              <span><%=rsData("status_desc") %></span>
                              <% end if %>
                            <% end if %>
                            </td>
                            </tr>


                            <% 	
                                rsData.MoveNext
	                            Loop 
                            %>
	                        <% else %>
	                        <tr height="25" bgcolor="#ffffff">
                            <td width="60" align="center" colspan="6">게임이 없습니다.</td>
                            </tr>
                            <% end if         
                            set rsData = nothing
                            %>        

  
                          </tr>  
                          </table>
                          <% else %>
  
                          <div style="height:150px;padding:150px 0 0 0;text-align:center;">
                          B2B회원은 베팅할 수 없습니다.
                          </div>  

                        <% end if %>
                        <% else %>
                          <div style="height:150px;padding:150px 0 0 0;text-align:center;">
                          로그인이 필요합니다.
                          </div>  
                        <% end if %>
						
										
					</tbody>
	<!--[e] 종목별매치 테이블-->

		</div>

  
  <!--[s] ASIDE -->		
		
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
								<dt><span id="bet_desc">종목이름<em>vs</em>종목이름</span></dt>
								<dd class="txt4"><span id="dividend_desc">0</span><a href="#"><img src="/img/x.gif" width="11" height="11"/></a></dd>
							
							</dl>
							</div>
							<!-- E : 종목 클릭시 베팅슬립 종목명 나타나는 박스 -->							
							<div class="myinfo_center">
							<dl >
								<dt>예상배당률</dt>
								<dd class="txt3"><span id="dividend_rate" name="dividend_rate" >0</span></dd>
							
							</dl>
							<dl>
								<dt>예상배당금</dt>
								<dd class="txt3"><span id="dividend_amt_predict" name="bet_amt_predict" >0</span></dd>
								
							</dl>
							<dl>
								<dt>베팅금액</dt>
								<dd class="max">MAX</dd>
								<dd><input type="text" id="bet_point" name="bet_point" onkeyup="amt_calculates();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();" value="5,000" /></dd>
								
							</dl>
							</div>
							<script>
                              function amt_calculates() {
                                var sum1 = document.getElementById("dividend_rate");
                                var amt1 = document.getElementById("bet_point");
                                var pre1 = document.getElementById("dividend_amt_predict");
                                var str = FormatNumber(amt1.value);
                                amt1.value = str;
                                str = str.replace(/\,/gi, "")
                                var str2 = sum1.value;
                                str2 = str2.replace(/\,/gi, "")
                                pre1.value = FormatNumber("" + parseInt(str * str2));
                                prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
                              }
                              </script>

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
							<input type="submit" onclick="javascript: ItemBetting()" value="베 팅" class="btn_bt">
							<input type="submit" value="베팅취소" class="btn_btc">
						</div>	
						

 </div>
	<!--[e] ASIDE -->		
  

 
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->

<% if item_flag = "1" then %>
<script>
   readStocks2();
</script>
<% end if %>