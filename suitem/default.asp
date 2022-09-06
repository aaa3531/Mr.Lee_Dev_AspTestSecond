<!-- #include virtual="/_include/header_item.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<link rel="stylesheet" type="text/css" href="/_css/game.css">
<%
   strSQL = "p_sm_gameday_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_no = rs("game_no")
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
   
    strSQL = "p_sm_game_item_member_detail '" & Session("member_no") & "','" & game_no & "','" & session("current_game") & "'"
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      fee_rate = rs("fee_rate")
      point_total = rs("point_total")
      Session("point_total") = rs("point_total")
      select_no = rs("select_no")
      dividend_rate = rs("dividend_rate")
      dividend_rate1 = rs("dividend_rate1")
      dividend_rate2 = rs("dividend_rate2")
      company_name1 = rs("company_name1")
      company_name2 = rs("company_name2")
      dividend_amt_predict = rs("dividend_amt_predict")
      game_sec = rs("game_sec")
      game_min = rs("game_min")
      game_status = rs("game_status")

    'response.write fee_rate & "<br>"
    'response.write mybet_amt & "<br>"  
    
    'if cint(point_total) < cint(mybet_amt) then mybet_amt = point_total end if
    'response.write game_no

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

    function ToggleColor2(obj, type) {
        if (type == 1) {
            if (obj.className == 'btn_money_ov') obj.className = 'btn_money';
        } else {
            if (obj.className == 'btn_money') obj.className = 'btn_money_ov';
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
        xhr.open("POST", "item_basket_set.asp?game_no="+game_no+"&select_no="+select_no);
        xhr.send(null);
        //fFrameReload();

    }

    function SelectItem() {
        if (xhr.readyState == 4) {
            //status_no1 = elem.getAttribute("name3");
            //alert(status_no1);
            var data = xhr.responseText;
            var slipdata = data.split(',');
            if(slipdata[0] > 0)
            {
                document.getElementById("gameno").value = slipdata[0];
                //document.getElementById("betslipon").style.display = "block";
                //document.getElementById("betslipoff").style.display = "none";
                document.getElementById("companyname1").innerHTML = slipdata[2];
                document.getElementById("companyname2").innerHTML = slipdata[3];
                document.getElementById("dividendrate0").innerHTML = slipdata[6];
                document.getElementById("dividendrate").innerHTML = slipdata[6];
                //document.getElementById("dividendamtpredict").innerHTML = slipdata[7];
                amt_calculates();
                if(slipdata[1] == 1){
                    document.getElementById("companyname1").style.color = "F7941C";
                    document.getElementById("companyname2").style.color = "ffffff";
                }
                else{
                    document.getElementById("companyname1").style.color = "ffffff";
                    document.getElementById("companyname2").style.color = "F7941C";
                }
            }
            else
            {
                document.getElementById("gameno").value = slipdata[0];
                //document.getElementById("betslipon").style.display = "block";
                //document.getElementById("betslipoff").style.display = "none";
                document.getElementById("companyname1").innerHTML = "종목1";
                document.getElementById("companyname2").innerHTML = "종목2";
                document.getElementById("dividendrate0").innerHTML = "0";
                document.getElementById("dividendrate").innerHTML = "0.00";
                document.getElementById("dividendamtpredict").innerHTML = "0";
                document.getElementById("companyname1").style.color = "ffffff";
                document.getElementById("companyname2").style.color = "ffffff";

            }

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
    <%=" ary.push('<font color=#e4ff00>" & rsMessage("message_desc") & "</font>'); " %>
    <% 	
        rsMessage.MoveNext
    Loop 
    else
    %>
    ary.push('<font color=#000000>종목매치 입니다.</font>');
    ary.push('<font color=#000000>즐거운 시간 보내세요.</font>');
    ary.push('<font color=#000000>항하사 증권입니다.</font>');
    <% 
    end if
    set rsMessage=nothing
    %>


    window.onload = function () {
        startTime();
        fncInit();
        fTimerStart();
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
          
        var pad = cnt * 5;
        document.getElementById('scrl').innerHTML = '<nobr>' + ary[pos] + '<nobr>';
        document.getElementById('scrl').style.paddingLeft = pad;

        if (cnt == 0) {
            cnt = 150;
            setTimeout(fncInit, delay);
        }
        else {
            cnt--;
            setTimeout(fncMoveText, speed);
        }

    }
    
    function startTime() {
        var today = new Date();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        //document.getElementById('txt').innerHTML =
        //h + ":" + m + ":" + s;
        document.getElementById('clock_hour1').innerHTML = getSrc(h,10);
        document.getElementById('clock_hour2').innerHTML = getSrc(h,1);
        document.getElementById('clock_minute1').innerHTML = getSrc(m,10);
        document.getElementById('clock_minute2').innerHTML = getSrc(m,1);
        var t = setTimeout(startTime, 500);
    }
    function checkTime(i) {
        if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
        return i;
    }

    function getSrc(digit,index){
        return Math.floor(digit/index)%10;
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
    function readStocks2()
    {
    var	myNodelist = document.getElementsByName("stock1");
    var i;
    for (i = 0; i <	myNodelist.length; i++) 
    {
    var gno = myNodelist[i].getAttribute("att_game");   
    getItemDividendRate(gno);
    //if(gno == undefined || gno== null)     { mrecommend = ""; }         
    //$.ajax({        type: "GET",        url: "item_rate_set.asp",        data: "game_no="+gno,        error:function(){            $("body").append("<div id=\"Work\" style=\"display:none;\">item error</div>")        },        success: function(msg){    $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");  },        complete:function(){           $("#Work").remove();        }     });
    }
    startStocks();
    setTimeout("endStocks()",1000);
    }  

     function getItemDividendRate(gno) 
     {
         var xhr2;
             xhr2 = new XMLHttpRequest();
             xhr2.onreadystatechange = function(){
             if (xhr2.readyState == 4) {
             var statold = document.getElementById("game_status").value;
                var data = xhr2.responseText;
                var slipdata = data.split(',');
                //alert(slipdata[0]);
                document.getElementById("rate1_"+gno).innerHTML = slipdata[0];
                document.getElementById("rate2_"+gno).innerHTML = slipdata[1];
                document.getElementById("game_status").innerHTML = slipdata[2];
                document.getElementById("game_sec").innerHTML = slipdata[3];
                document.getElementById("game_min").innerHTML = slipdata[4];
                 if (statold != slipdata[2])
                  {
                       clearInterval(mytime);
                       document.location.href = "default.asp"
                  }
            }
             };
             xhr2.open("POST", "item_rate_set.asp?game_no=" + gno);
             xhr2.send(null);
        }

</script> 



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

    

    function pointSet(elem) {
        var sum1 = document.getElementById("dividendrate");
        var point1 = elem.getAttribute("point");
        var amt1 = document.getElementById("bet_point");
        var point2 = document.getElementById("bet_point").value;
        if (Number(point2.replace(/,/gi,"")) < point1)
        {
            point3 = Number(point1.replace(/,/gi,""));
        }
        else
        {
            var point3 = Number(point1.replace(/,/gi,"")) + Number(point2.replace(/,/gi,""));
        }
        if (point3 > 3000000)
        {
            point3 = 3000000;
        }
        var pre1 = document.getElementById("dividendamtpredict");
        var str = FormatNumber(point3.toString());
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.innerHTML;
        str2 = str2.replace(/\,/gi, "")
        pre1.innerHTML = FormatNumber("" + parseInt(str * str2));
        //prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
    }

    function basketDelete() {
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = basketSet;
        xhr.open("POST", "item_basket_delete.asp");
        xhr.send(null);
    }
    
    function basketSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');
            document.getElementById("dividendrate").innerHTML = "0" ;
            document.getElementById("dividendrate0").innerHTML = "" ;
            document.getElementById("dividendamtpredict").innerHTML = "0" ;
            document.getElementById("bet_point").value = "5,000" ;
            document.getElementById("companyname1").innerHTML = "종목1";
            document.getElementById("companyname2").innerHTML = "종목2";
            document.getElementById("companyname1").style.color = "ffffff";
            document.getElementById("companyname2").style.color = "ffffff";
            clearStock();
        }
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
        text-align: left;
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
    
    function BettingCheck(form) {
        var bet_point = document.getElementById("bet_point").value;
        var bet_limit = document.getElementById("bet_limit").value;
        bet_point2 = bet_point.replace(/,/gi,"");
        bet_point3 = bet_point2 % 1000;
        if (Number(bet_point2) > Number(bet_limit) ) {
            alert("최대 베팅금액을 초과하였습니다.");
            form.bet_point.focus();
            return false;
        }
        if (bet_point2 < 5000) {
            alert("최소 베팅금액은 5000원 입니다.");
            form.bet_point.focus();
            return false;
        }
        if (bet_point3 != 0) {
            alert("베팅은 천원 단위로만 가능합니다.");
            form.bet_point.focus();
            return false;
        }
        bet_popup_origin();
        return true;
    }

    function bet_popup_origin() {
        var bet_point = document.getElementById("bet_point").value;
        var game_no = document.getElementById("gameno").value;
        var dividendrate = document.getElementById("dividendrate").innerHTML;
        if(dividendrate == 0)
        {
            alert("종목선택 후 베팅하여 주십시오");
        }
        else
        {
            var strurl = "bet_popup.asp?bet_point=" + bet_point + "&game_no=" + game_no;
            //alert(strurl);
            window.open(strurl, 'popup', 'width=500,height=190,left=450,top=250,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=yes, scrollbars=no, copyhistory=no');
        }
    }
    
    function bet_popup() {
        alert("베팅 확인");
        formItem.submit();
    }

    
    function betReload() {
        clearStock();
        basketDelete();
        
    }

    var counter;
    var mytime;
     
    function fTimerStart() {
        counter = document.getElementById('game_sec').value;
        //document.getElementById("dtimer").innerHTML = counter;
        //alert(counter);
        if (document.getElementById('open_flag').value == "1")
        {
            mytime = fTimer(counter);
        }
    }

     
    function fTimer(duration) {
        var timer = duration, minutes, seconds;
        setInterval(function () {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);


            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;


            //display.textContent = minutes + ":" + seconds;
            if (timer >= 0) {
                document.getElementById("dtimer_min").innerHTML = minutes;
                document.getElementById("dtimer_sec").innerHTML = seconds;
            }
            --timer;
        }, 1000);
    }

</script>



<% if result_no * 1 - 1 = 0 then %>
<SCRIPT language="javascript">
    parent.readStocks2();
    parent.clearStock();
</script>
<% end if %>







<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent">

					<div class="snb_title">
					<ul>
						<li class="snb_01">종목매치</li>
						<li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2)%>일 <%=turn_no%>회차 <%=item_status%></li>
					</ul>
				</div>
				
		    <!--[s] Flow 텍스트 박스 -->
					
         <form name='frm'>
				<div id='scrl' class="flow_txt" style="padding-left:100px; overflow:hidden;">
					<p></p>
				</div>
         </form>
		    <!--[e] Flow 텍스트 박스 -->		
            
                <input type="hidden" name="bet_limit" id="bet_limit" value="<%=Session("bet_limit") %>" />
                <input type="hidden" name="game_no" id="gameno" value="<%=game_no %>" />
                <input type="hidden" name="select_no" id="select_no" value="<%=select_no %>" />
                <input type="hidden" name="open_flag" id="open_flag" value="<%=open_flag %>" />
                <input type="hidden" name="game_status" id="game_status" value="<%=game_status %>" />
                <% if game_sec * 1 < 10 then %>
                <input type="hidden" id="game_sec" value="<%=game_sec %>" />
                <% else %>
                <input type="hidden" id="game_sec" value="<%=game_sec %>" />
                <% end if %>
                <% if game_min * 1 < 10 then %>
                <input type="hidden" id="game_min" value="<%=game_min %>" />
                <% else %>
                <input type="hidden" id="game_min" value="<%=game_min %>" />
                <% end if %>
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
                            <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                            <% 
                               Do While Not rsData.EOF    %> 
                            <tr>
                            <td align="center" >
                              <% if rsData("status_flag") = "1" then %>
                                <% if rsData("select_no") = "1" then %>
                                <div name="stock1" id='div1_<%=rsData("game_no") %>' onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_select" att_game="<%= rsData("game_no") %>" att_select="1" att_status="1" >
                                <% else %>
                                <div name="stock1" id="div1_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_normal" att_game="<%= rsData("game_no") %>" att_select="1" att_status="0" >
                                <% end if %>
                                <% if rsData("company_name1") <> "" then  %>            
                                  <% if rsData("logo_img1") <> "" then  %><img src="http://game.hhs1052.com/images/stock/<%=rsData("logo_img1") %>" border="0"  style="width:77px; height:22px;"/><% else %>(로고)<% end if %><br />
                                  <%=rsData("company_name1") %>
                                <% else %>
                                  (종목1 미할당)
                                <% end if %>
                                </div>
                              <% else %>
                                <div name="stock1" id="div1_<%=rsData("game_no") %>"  class="betbtn_normal">
                                <% if rsData("company_name1") <> "" then  %>            
                                  <% if rsData("logo_img1") <> "" then  %><img src="http://game.hhs1052.com/images/stock/<%=rsData("logo_img1") %>" border="0" style="width:77px; height:22px;"/><% else %>(로고)<% end if %><br />
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
                                   <% if rsData("logo_img2") <> "" then  %><img src="http://game.hhs1052.com/images/stock/<%=rsData("logo_img2") %>" border="0" style="width:77px; height:22px;"/><% else %>(로고)<% end if %><br />
                                   <%=rsData("company_name2") %>
                                <% else %>
                                   (종목2 미할당)
                                <% end if %>
                                </div>
                              <% else %>
                                <div name="stock1" id="div2_<%=rsData("game_no") %>" class="betbtn_normal">
                                <% if rsData("company_name2") <> "" then  %>            
                                  <% if rsData("logo_img2") <> "" then  %><img src="http://game.hhs1052.com/images/stock/<%=rsData("logo_img2") %>" border="0" style="width:77px; height:22px;"/><% else %>(로고)<% end if %><br />
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

                          <% else %>
                          <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="게임,배당,결과를 알려주는표" class="tbl_game"  style="table-layout:fixed;" >
						
					     <tbody>
                         <tr>
                         <td align="center">
                          B2B회원은 베팅할 수 없습니다.
                          </td>
                         </tr>
                          </tbody>
                          </table>

                        <% end if %>
                        <% else %>
                          <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="게임,배당,결과를 알려주는표" class="tbl_game"  style="table-layout:fixed;" >
						
					     <tbody>
                         <tr>
                         <td align="center">
                          로그인이 필요합니다.
                          </td>
                         </tr>
                          </tbody>
                          </table>
                        <% end if %>
						
										
					</tbody>
                          </table>
	<!--[e] 종목별매치 테이블-->

		</div>

  <!--[s] ASIDE -->		
		
<div class="aside">
				<div class="info_type">
					<p><span>공지</span><img src="/img/5px_arrow.gif" width="5" height="5"><a href="/sucustomer/notice.asp">항하사 공지사항을 확인하세요</a></p>
				</div>
				<!--left_profile -->	
                <!-- #include virtual="/_include/left_profile.asp" -->
               
				<div class="time">
					<p>
					<span class="p_time">현재시각</span>
					<span id="clock_hour1" class="hour">0</span>
					<span id="clock_hour2" class="hour">0</span>
					<span><img src="/img/time_center.gif" width="5" height="44"></span>
					<span id="clock_minute1" class="hour">0</span>
					<span id="clock_minute2" class="hour">0</span>
					<span class="minute">분</span>
					</p>
				</div>

				<div class="up_sec bg_black_gra">
				
					<!-- 50~00초는 연두색 으로 나와야 함 -->
					<p class="sec1">
                    <span class="sec1_ing"><%=item_status%></span>
    					<span id="dtimer_min">00</span>
    					<span >:</span>
    					<span id="dtimer_sec">00</span>
    			    <p>					
					<!-- 10~00초는 빨강색 으로 나와야 함 -->
					<!-- <span class="sec2">10</span> -->
				</div>

				<div class="info_type">
					<p><span>안내</span><img src="/img/5px_arrow.gif" width="5" height="5">종목을 선택하여 베팅하세요</p>
				</div>


                <div class="top betting">
					<form id="formBet" name="formBet" method="post" onsubmit="return BettingCheck(this)" >
                     <input type="hidden" id="game_no" name="game_no" value="<%=game_no %>" /> 
					 
						<div class="myinfo">
							<div class="myinfo_top">
							<span>베팅슬립 Betting Slip</span>
							</div>
							
							<!-- S : 종목 클릭시 베팅슬립 종목명 나타나는 박스 -->
							<div class="betting_name">
							<dl >
								<dt>
                                 <% if select_no = "1" then %>
                                 <span id="companyname1"><%=company_name1 %></span>
                                 <span style="color:#FF0000;"><em>vs</em></span>
                                 <span id="companyname2" style="color:#ffffff;"><%=company_name2 %></span>
                                 <% else %>
                                 <span id="companyname1" style="color:#ffffff;"><%=company_name1 %></span>
                                 <span style="color:#FF0000;"><em>vs</em></span>
                                 <span id="companyname2" ><%=company_name2 %></span>
                                 <% end if %>  
								</dt>

								<dd class="txt4">
                                <span id="dividendrate0" style="color:#ffffff;" >
                                <% if select_no = "1" then %>
                                <%=dividend_rate1 %>
                                <% else %>
                                <%=dividend_rate2 %>
                                <% end if %>
                                </span>
                                <img src="/img/x.gif" onclick="javascript:basketDelete(this);" width="11" height="11" style="cursor:pointer;" />
								</dd>
							
							</dl>
							</div>
							<!-- E : 종목 클릭시 베팅슬립 종목명 나타나는 박스 -->							
							<div class="myinfo_center">
							<dl >
								<dt>예상배당률</dt>
								<dd class="txt3"><span id="dividendrate" name="dividend_rate" value="" ><%=dividend_rate %> </span></dd>
							
							</dl>
							<dl>
								<dt>예상배당금</dt>
								<dd class="txt3"><span id="dividendamtpredict" name="bet_amt_predict" value="" ><%=dividend_amt_predict %></span></dd>
								
							</dl>
							<dl>
								<dt>베팅금액</dt>
								<dd class="max" point="<%=Session("bet_limit") %>" onclick="javascript:pointSet(this);" style="cursor:pointer;">MAX</dd>
								<dd><input type="text" id="bet_point" name="bet_point" onkeyup="amt_calculates();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();" value="5,000" /></dd>
								
							</dl>
							</div>
						  <script>
                          function amt_calculates() {
                            var sum1 = document.getElementById("dividendrate");
                            var amt1 = document.getElementById("bet_point");
                            var pre1 = document.getElementById("dividendamtpredict");
                            var str = FormatNumber(amt1.value);
                            amt1.value = str;
                            str = str.replace(/\,/gi, "")
                            var str2 = sum1.innerHTML;
                            str2 = str2.replace(/\,/gi, "")
                            pre1.innerHTML = FormatNumber("" + parseInt(str * str2));
                            //prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
                          }
                          </script>

							<div class="btn_mny">
								<input type="button" point="10000" onclick="javascript:pointSet(this);" value="10,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
								<input type="button" point="30000" onclick="javascript:pointSet(this);" value="30,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
								<input type="button" point="50000" onclick="javascript:pointSet(this);" value="50,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
								<input type="button" point="100000" onclick="javascript:pointSet(this);" value="100,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
								<input type="button" point="500000" onclick="javascript:pointSet(this);" value="500,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
								<input type="button" point="1000000" onclick="javascript:pointSet(this);" value="1,000,000" onmouseover="ToggleColor2(this,0)" onmouseout="ToggleColor2(this,1)"  class="btn_money" />
							</div>
							
									
						</div>
                        </form>
					</div>
							<div class="btn_betting">
							<input type="submit" onclick="javascript:BettingCheck(formBet);" value="베 팅" style="cursor:pointer;" class="btn_bt_ov"/>
							<input type="button" value="베팅취소"  onclick="javascript:basketDelete(this);" style="cursor:pointer;" class="btn_bt"/>
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