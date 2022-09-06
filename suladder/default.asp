<!-- #include virtual="/_include/header_ladder.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
 'response.write Session("member_no")

 
 strSQL = "p_sm_gameday_ladder_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_day = rs("game_day")
    open_flag = rs("open_flag")
  end if   

  set rs = nothing
 
 strSQL = "p_sm_parameter_read_ladderlink "
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    ladder_link = rs("ladder_link")
  end if   

  set rs = nothing

  
  
 strSQL = "p_sh_game_ladder_rate_list "

 ' response.write strSQL
 ' response.End
  
  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.Open strSQL, DbCon, 1, 1

  if NOT rsList.EOF and NOT rsList.BOF then
    ss_rate = rsList("ss_rate")
    dd_rate = rsList("dd_rate")
    hh_rate = rsList("hh_rate")
    ll_rate = rsList("ll_rate")
    sh_rate = rsList("sh_rate")
    sl_rate = rsList("sl_rate")
    dh_rate = rsList("dh_rate")
    dl_rate = rsList("dl_rate")
  end if   

  set rs = nothing

   strSQL = "p_sm_message_list 'L' " 
  
  'response.write strSQL
  'response.End

  Set rsMessage = Server.CreateObject("ADODB.RecordSet")
  rsMessage.Open strSQL, DbCon, 1, 1
    
  if rsMessage.EOF or rsMessage.BOF then
	NoDataMessage = True
  Else
	NoDataMessage = False
  end if

  'response.write session("current_game")
  dim mybet_amt 
  
  if request("result_desc") = "" then
     result_desc = "UP&DOWN을 선택해서 베팅해주세요"
  else
     result_desc = request("result_desc")
  end if
  
  if request("result_no") <> "" then
     result_no = request("result_no")
  end if
  
  'response.write Session("point_total")

	select_no = request("select_no")
	
    strSQL = "p_sh_game_ladder_reset_new '" & Session("member_no") & "'"
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
    
      game_second = rs("gamesec") 
      openflag1 = rs("open_flag")
      ladder_value = rs("ladder_value") 
      game1_no = rs("game1_no")   
      game_desc1 = rs("game_desc")  
      game_status1 = rs("game_status") 
      allbet_ss = rs("allbet_ss")  
      allbet_dd = rs("allbet_dd")  
      allbet_hh = rs("allbet_hh")  
      allbet_ll = rs("allbet_ll")  
      allbet_sh = rs("allbet_sh")  
      allbet_sl = rs("allbet_sl")  
      allbet_dh = rs("allbet_dh")  
      allbet_dl = rs("allbet_dl")  
      turn_no1 = rs("turn_no")     
      result_msg = rs("result_msg") 
      prev_result = rs("prev_result")    
      prev_result_msg = rs("prev_result_msg") 
      current_result_msg = rs("current_result_msg")  
      calc_flag = rs("calc_flag") 
      ladder_flag = rs("ladder_flag") 
            
    end if 
    set rs = nothing


   %>

  <SCRIPT language="javascript"> 

      
      function resizeIframe(obj) {
          obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
      } 

      function resizeIframe2() {
          obj = document.getElementById("bettingframe");
          obj2 = document.getElementById("bettingframeauto");
          obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
          obj2.style.height = obj2.contentWindow.document.body.scrollHeight + 'px';
      } 

      var nbsp = 100;
      var cnt = 150;
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
      ary.push('<font color=#000000>UP&DOWN 게임입니다.</font>');
      ary.push('<font color=#000000>즐거운 시간 되세요.</font>');
      ary.push('<font color=#000000>항하사 증권 입니다.</font>');
      <% 
      end if
      set rsMessage=nothing
      %>


      window.onload = function () {
          fncInit();
          fTimerStart();
          imgChange();
          getDividendRate();
          //startTime();
          setTimeout("resultMsgHide()" , 10000);
          //reloadFrame();
      }


      //function reloadFrame() {
      //    chart.location.reload();
      //    setTimeout(reloadFrame, 60000);
      //}  

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

      
      function imgChange() {
          var test = 10;
          var status = document.getElementById("game_status1").value;
          var ladderflag = document.getElementById("ladder_flag").value;
          var result = document.getElementById("prev_result").value;
          if(ladderflag == 1)
          {
              if(status == 0)
              {
                  setInterval(function () {
                      var img = document.getElementById('timeimg');
              
                      if(test == 10){
                          img.src = "/img/time_9.gif"
                      }
                      else if(test == 9){
                          img.src = "/img/time_8.gif"
                      }
                      else if(test == 8){
                          img.src = "/img/time_7.gif"
                      }
                      else if(test == 7){
                          img.src = "/img/time_6.gif"
                      }
                      else if(test == 6){
                          img.src = "/img/time_5.gif"
                      }
                      else if(test == 5){
                          img.src = "/img/time_4.gif"
                      }
                      else if(test == 4){
                          img.src = "/img/time_3.gif"
                      }
                      else if(test == 3){
                          img.src = "/img/time_2.gif"
                      }
                      else if(test == 2){
                          img.src = "/img/time_1.gif"
                      }
                      else if(test == 1){
                          img.src = "/img/time_0.gif"
                      }
                      test--;
                  }, 500);
                  setTimeout("imgChange()",5000);
              }
              else
              {
                  var img = document.getElementById('timeimg');
              
                  if(result == 9){
                      img.src = "/img/time_9.gif"
                  }
                  else if(result == 8){
                      img.src = "/img/time_8.gif"
                  }
                  else if(result == 7){
                      img.src = "/img/time_7.gif"
                  }
                  else if(result == 6){
                      img.src = "/img/time_6.gif"
                  }
                  else if(result == 5){
                      img.src = "/img/time_5.gif"
                  }
                  else if(result == 4){
                      img.src = "/img/time_4.gif"
                  }
                  else if(result == 3){
                      img.src = "/img/time_3.gif"
                  }
                  else if(result == 2){
                      img.src = "/img/time_2.gif"
                  }
                  else if(result == 1){
                      img.src = "/img/time_1.gif"
                  }
                  else if(result == 0){
                      img.src = "/img/time_0.gif"
                  }
                  setTimeout("imgChange()",10000);
              }
          }
      }

      function checkTime(i) {
          if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
          return i;
      }

      function getSrc(digit,index){
          return Math.floor(digit/index)%10;
      }
      
        
        
      var xhr;
      function selectSingle(elem) {
          ladder_value = elem.getAttribute("ladder_value");
          gameno = document.getElementById("game1_no").value;
          xhr = new XMLHttpRequest();
          document.getElementById("ladderclick").value = ladder_value;
          document.getElementById("ladderdesc").value = elem.value;
          if(ladder_value == 'SS')
          {
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_odd_sel";
          }
          else if(ladder_value == 'DD')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_even_sel";
          }
          else if(ladder_value == 'HH')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_odd_sel";
          }
          else if(ladder_value == 'LL')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_even_sel";
          }
          else if(ladder_value == 'SH')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_even02_sel";
          }
          else if(ladder_value == 'SL')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_even02_sel";
          }
          else if(ladder_value == 'DH')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dl").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_odd02_sel";
          }
          else if(ladder_value == 'DL')
          {
              document.getElementById("ss").className = "btn_ladder_odd"
              document.getElementById("dd").className = "btn_ladder_even"
              document.getElementById("hh").className = "btn_ladder_odd"
              document.getElementById("ll").className = "btn_ladder_even"
              document.getElementById("sh").className = "btn_ladder_even02"
              document.getElementById("sl").className = "btn_ladder_even02"
              document.getElementById("dh").className = "btn_ladder_odd02"
              elem.className = "btn_ladder_odd02_sel";
          }
          xhr.onreadystatechange = selectLadder;
          xhr.open("POST", "ladder_basket_set.asp?ladder_value="+ladder_value+"&game_no=" + gameno);
          xhr.send(null);
      }
      function selectLadder() {
          //alert("111");
          if (xhr.readyState == 4) {
              var data = xhr.responseText;
              var slipdata = data.split(',');
              document.getElementById("ladderrate").value = slipdata[2];
              document.getElementById("dividend_amt_predict").value = slipdata[3];
              //document.getElementById("bet_amt_predict").value = slipdata[1];
              amt_calculate();
          }
      }

        
      var xhr2;
      var counter;

      function getDividendRate() {
          gameno1 = document.getElementById("game1_no").value;
          xhr2 = new XMLHttpRequest();
          xhr2.onreadystatechange = setDividendRate;
          xhr2.open("POST", "ladder_rate_set.asp?game_no=" + gameno1);
          xhr2.send(null);
      }
      function setDividendRate() {
          if (xhr2.readyState == 4) {
              var data = xhr2.responseText;
              var slipdata = data.split(',');
             if ( xhr.status == 200 )
             {
                 //var slipdata = data.split(',');
              var calcold = document.getElementById("calc_flag").value;
              var calcold2 = document.getElementById("calc2_flag").value;
              var ladderindexold = document.getElementById("ladderindex_flag").value;
              var statold = document.getElementById("game_status1").value;
              document.getElementById("clock_hour1").innerHTML = slipdata[16];
              document.getElementById("clock_hour2").innerHTML = slipdata[17];
              document.getElementById("clock_minute1").innerHTML = slipdata[18];
              document.getElementById("clock_minute2").innerHTML = slipdata[19];
              if (document.getElementById("game_status1").value == 1) {
                    document.getElementById("allbet_ss").innerHTML = slipdata[0];
                    document.getElementById("allbet_dd").innerHTML = slipdata[1];
                    document.getElementById("allbet_hh").innerHTML = slipdata[2];
                    document.getElementById("allbet_ll").innerHTML = slipdata[3];
                    document.getElementById("allbet_sh").innerHTML = slipdata[4];
                    document.getElementById("allbet_sl").innerHTML = slipdata[5];
                    document.getElementById("allbet_dh").innerHTML = slipdata[6];
                    document.getElementById("allbet_dl").innerHTML = slipdata[7];
                    //document.getElementById("audio_code").innerHTML = slipdata[8];
                    //document.getElementById("status_flag").innerHTML = slipdata[9];
                    document.getElementById("game_second").innerHTML = slipdata[10];
                    document.getElementById("prev_result").innerHTML = slipdata[11];
                    document.getElementById("calc_flag").value = slipdata[12];
                    document.getElementById("calc2_flag").value = slipdata[13];
                    document.getElementById("ladderindex_flag").value = slipdata[14];
                    document.getElementById("ladder_flag").value = slipdata[15];
                }
                
                if (slipdata[15] == 1)
                {
                    if (statold != slipdata[9])
                    {
                        //document.getElementById("game_status1").value = slipdata[9];
                        ladderReset();
                    }
                    //alert("1");
                    setTimeout("getDividendRate();", 1000);
                }
                else
                {
                    document.getElementById("game_status1").value = "0";
                    document.getElementById("openflag1").value = "0";
                    document.getElementById("bet_end_board").style.display = "block";
                    setTimeout("getDividendRate();", 60000);
                }
                if (calcold != slipdata[12])
                {
                    calcReset();
                    document.getElementById("calc_flag").value = slipdata[12];
                }
                if (ladderindexold != slipdata[14])
                {
                    //calcReset2();
                    document.getElementById("ladderindex_flag").value = slipdata[14];
                    var iframe2 = document.getElementById("chart");
                    iframe2.src = iframe2.src;
                }
                if (calcold2 != slipdata[13])
                {
                    //calcReset2();
                    document.getElementById("calc2_flag").value = slipdata[13];
                    var iframe1 = document.getElementById("resultframe");
                    var iframe2 = document.getElementById("listframe");
                    iframe1.src = iframe1.src;
                    iframe2.src = iframe2.src;
                }
             }
             else
	     {
               setTimeout("getDividendRate();", 5000);
               //setTimeout("document.location.reload();", 5000);
              }

          }
      }




    function basketDelete() {
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = basketSet;
        xhr.open("POST", "ladder_basket_delete.asp");
        xhr.send(null);
    }

    function basketSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');
            document.getElementById("ss").className = "btn_ladder_odd"
            document.getElementById("dd").className = "btn_ladder_even"
            document.getElementById("hh").className = "btn_ladder_odd"
            document.getElementById("ll").className = "btn_ladder_even"
            document.getElementById("sh").className = "btn_ladder_even02"
            document.getElementById("sl").className = "btn_ladder_even02"
            document.getElementById("dh").className = "btn_ladder_odd02"
            document.getElementById("dl").className = "btn_ladder_odd02"
            document.getElementById("ladderclick").value = "0";
            document.getElementById("ladderrate").value = "0.0";
            document.getElementById("bet_point").value = "5,000";
            document.getElementById("dividend_amt_predict").value = "0";
            //document.getElementById("bet_amt_predict").value = slipdata[1];

        }
    }


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
        var sum1 = document.getElementById("ladderrate");
        var amt1 = document.getElementById("bet_point");
        var pre1 = document.getElementById("dividend_amt_predict");
        var str = FormatNumber(amt1.value);
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.value;
        str2 = str2.replace(/\,/gi, "")
        pre1.value = FormatNumber("" + parseInt(str * str2));
        //prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
    }

    function pointSet(elem) {
        var sum1 = document.getElementById("ladderrate");
        var point1 = elem.getAttribute("point");
        var amt1 = document.getElementById("bet_point");
        var point2 = document.getElementById("bet_point").value;
        if (Number(point2.replace(/,/gi, "")) < point1) {
            point3 = Number(point1.replace(/,/gi, ""));
        }
        else {
            var point3 = Number(point1.replace(/,/gi, "")) + Number(point2.replace(/,/gi, ""));
        }
        if (point3 > 1000000) {
            point3 = 1000000;
        }
        var pre1 = document.getElementById("dividend_amt_predict");
        var str = FormatNumber(point3.toString());
        amt1.value = str;
        str = str.replace(/\,/gi, "")
        var str2 = sum1.value;
        str2 = str2.replace(/\,/gi, "")
        pre1.value = FormatNumber("" + parseInt(str * str2));
        //prize.innerHTML = '' + FormatNumber("" + parseInt(str * str2)) + '';
    }
    
    function ToggleColor(obj, type) {
        var stat = document.getElementById("game_status1").value;
        if (stat == 1)
        {
            if (type == 1) {
                if (obj.className == 'tbl_ov') obj.className = 'tbl_normal';
            } else {
                if (obj.className == 'tbl_normal') obj.className = 'tbl_ov';
            }
        }
    }

    function ToggleColor2(obj, type) {
        if (type == 1) {
            if (obj.className == 'btn_money_ov') obj.className = 'btn_money';
        } else {
            if (obj.className == 'btn_money') obj.className = 'btn_money_ov';
        }
    }




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


    function BettingCheck(form) {

        var bet_point = document.getElementById("bet_point").value;
        var bet_limit = document.getElementById("bet_limit").value;
        var point_total = document.getElementById("pointtotal").innerHTML;
        bet_point2 = bet_point.replace(/,/gi, "");
        point_total2 = point_total.replace(/,/gi, "");
        bet_point3 = bet_point2 % 1000;
        var sel1 = document.getElementById("ladderclick").value;
        if (sel1 != "SS" & sel1 != "DD" & sel1 != "HH" & sel1 != "LL" & sel1 != "SH" & sel1 != "SL" & sel1 != "DH" & sel1 != "DL") {
            alert("VALUE를 선택해서 베팅해주세요");
            //form.updownclick.focus();
            return false;
        }
        if (Number(point_total2) < Number(bet_point2)) {
            alert("보유금액이 베팅금액보다 작습니다.");
            //form.updownclick.focus();
            return false;
        }
        if (Number(bet_point2) > Number(bet_limit)) {
            alert("최대 베팅금액을 초과하였습니다.");
            form.bet_point.focus();
            return false;
        }
        if (bet_point3 != 0) {
            alert("베팅은 천원 단위로 가능합니다.");
            form.bet_point.focus();
            return false;
        }
        if (bet_point2 < 5000) {
            alert("최소 베팅금액은 5000원 입니다.");
            form.bet_point.focus();
            return false;
        }
        bet_popup_select();
        return true;
    }

    function bet_popup_select() {
        var bet_point = document.getElementById("bet_point").value;
        var game_no = document.getElementById("game1_no").value;
        var sel1 = document.getElementById("ladderclick").value;
        var ladderdesc = document.getElementById("ladderdesc").value;
        if (ladderdesc == "H"){
            ladderdesc = ladderdesc + 'IGH';
        }
        if (ladderdesc == "L"){
            ladderdesc = ladderdesc + 'OW';
        }
        if (ladderdesc == "홀/H"){
            ladderdesc = ladderdesc + 'IGH';
        }
        if (ladderdesc == "홀/L"){
            ladderdesc = ladderdesc + 'OW';
        }
        if (ladderdesc == "짝/H"){
            ladderdesc = ladderdesc + 'IGH';
        }
        if (ladderdesc == "짝/L"){
            ladderdesc = ladderdesc + 'OW';
        }
        var strurl = "bet_popup_select.asp?bet_point=" + bet_point + "&game_no=" + game_no + "&ladderdesc=" + ladderdesc;
        //alert(strurl);
        window.open(strurl, 'popup', 'width=500,height=190,left=450,top=250,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=yes, scrollbars=no, copyhistory=no');
    }

    function bet_popup() {
        alert("베팅 확인");
        formItem.submit();
    }

    function betReload() {
        basketDelete();
        var iframe = document.getElementById('listframe');
        iframe.src = iframe.src;
    }
</script>



	<!-- container -->
	<div id="container">
		<!-- content -->
	
		
		<div id="content" class="subcon">
						<div class="snb_title sadari_title">
					<ul>
						<li class="snb_01">주식홀짝 </li>
						<li class="snb_date"><%=mid(game_day,5,2) %>월 <%=mid(game_day,7,2)%>일</li>
						<a href="<%=ladder_link %>" target="_blank"><li class="btn_reset">실시간 통화 환율 지수 보기 Click</li></a>
					</ul>
				</div>
				
		<!--[s] Flow 텍스트 박스 -->
                    <form name='frm'>

                    <div class="flow_txt" id='scrl' style="padding-left:100px; overflow:hidden;"></div>
                    </form>
			
		<!--[e] Flow 텍스트 박스 -->	
        		
	<div id="subcontent">
    <div class="subcontent">
			<!--[s] 주식사다리 그래프 영역 -->
					<div class="ladder_time">
						<div class="white">
							<p><img id="timeimg" src="/img/time_9.gif" width="270" height="270"></p>
						</div>
				

					</div>
					
					<div class="ladder_graph">
					    <iframe id="chart" frameborder="0" marginwidth="0" marginheight="0" border="0" width="350" height="350" name="chart" scrolling="no" src="kospi_chart.asp"></iframe>
					</div>
			<!-- 		
					<div class="updown_popup">
						<span>201</span>회차 결과는 <span>UP</span> 입니다.
					</div> -->
			<!--[e] 주식사다리 그래프 영역 -->	

			<!--[s] 족자 게임승 이미지 영역 -->
					<div id="prev_result_box" class="win" style="display:none;">
						<span id="prev_result_msg"><%=prev_result_msg %></span>
						<img src="/img/bg_win.png" width="717" height="363" />
					</div>
	<!-- 		[e] 족자 게임승 이미지 영역 -->
				</div>

	<!--[s] ASIDE -->	
    <div class="aside">
			
				<div class="top">
						
				<!--left_profile -->	
                <!-- #include virtual="/_include/left_profile_updown.asp" -->
					
					<div class="tbl_aside">
					  	<table width="100%" cellpadding="0" cellspacing="0" summary="총 베팅현황" class="all_betting">
							<col width="20%">
							<col width="80%">
							
							
						   <tbody>
								<tr>
									<th colspan="2">나의 배팅현황</th>

								</tr>
								<tr class="tr_03">
									<td class="tbl01"><img src="/img/th_odd.jpg"  alt="홀"/></td>
									<td class="tbl03" id="allbet_ss"><%=allbet_ss %>원</td>
								</tr>
								<tr>
									<td class="tbl02"><img src="/img/th_even.jpg" alt="짝"/></td>
									<td class="tbl03" id="allbet_dd"><%=allbet_dd %>원</td>
								</tr>
								<tr class="tr_03">
									<td class="tbl01"><img src="/img/th_H.jpg" alt="H" /></td>
									<td class="tbl03" id="allbet_hh"><%=allbet_hh %>원</td>
								</tr>
								<tr>
									<td class="tbl02"><img src="/img/th_L.jpg"  alt="L" /></td>
									<td class="tbl03" id="allbet_ll"><%=allbet_ll %>원</td>
								</tr>
								<tr class="tr_03">
									<td class="tbl01"><img src="/img/th_BH.jpg" alt="홀/H"  /></td>
									<td class="tbl03" id="allbet_sh"><%=allbet_sh %>원</td>
								</tr>
								<tr>
									<td class="tbl01"><img src="/img/th_BL.jpg" alt="홀/L"/></td>
									<td class="tbl03" id="allbet_sl" ><%=allbet_sl %>원</td>
								</tr>
								<tr class="tr_03">
									<td class="tbl02"><img src="/img/th_RH.jpg"  alt="짝/H"/></td>
									<td class="tbl03" id="allbet_dh"><%=allbet_dh %>원</td>
								</tr>
								<tr>
									<td class="tbl02"><img src="/img/th_RL.jpg"  alt="짝/L"/></td>
									<td class="tbl03" id="allbet_dl"><%=allbet_dl %>원</td>
								</tr>

								
						   </tbody>
					  </table>
					  </div>
					</div>
				
			</div>
            	
				</div>
				
				
			</div>
			</div>

			
<input type="hidden" id="game_second" value="<%=game_second %>" />
<input type="hidden" id="calc_flag" value="<%=calc_flag %>" />
<input type="hidden" id="calc2_flag" value="<%=calc_flag %>" />
<input type="hidden" id="ladderindex_flag" value="<%=ladderindex_flag %>" />
<input type="hidden" id="ladder_flag" value="<%=ladder_flag %>" />
<input type="hidden" id="openflag1" value="<%=openflag1 %>" />
<input type="hidden" id="ladder_value" value="<%=ladder_value %>" />
<input type="hidden" id="game_status1" value="<%=game_status1 %>" />
<input type="hidden" id="status_flag" value="<%=ladder_status %>" />
<input type="hidden" id="prev_result" value="<%=prev_result %>" />
<input type="hidden" id="prev_result_msg" value="<%=prev_result_msg %>" />
<input type="hidden" id="game1_no"  value="<%=game1_no %>" />
<input type="hidden" id="bet_limit"  value="<%=Session("bet_limit") %>" />
<input type="hidden" id="ladderclick"  value="" />
<input type="hidden" id="ladderdesc"  value="" />
<input type="hidden" id="ladderrate"  value="0.0" />

 <script language="javascript" type="text/javascript">
 <!--
    var counter;
    var mytime;
     
    function fTimerStart() {
        counter = document.getElementById('game_second').value;
        if (document.getElementById('openflag1').value == "1")
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
            if (document.getElementById("game_status1").value == 1) {
                document.getElementById("dtimer").style.color = "#e4ff00";
            }
            else {
                document.getElementById("dtimer").style.color = "#ccc";
            }

            if (timer >= 0) {
                document.getElementById("dtimer").innerHTML = "[ " + minutes + "분" + ":" + seconds + "초 ]" ;
            }
            --timer;
        }, 1000);
    }


    function CTimer(){
        var timer = 10;
        setInterval(function () {
            seconds = parseInt(timer % 60, 10);


            seconds = seconds < 10 ? seconds : seconds;

            if (timer >= 0) {
                document.getElementById("ctimer").innerHTML = seconds;
            }
            --timer;
        }, 100) ;
    }




    var xhr3;
    function ladderReset() {
        xhr3 = new XMLHttpRequest();
        xhr3.onreadystatechange = setLadderReset;
        xhr3.open("POST", "ladder_reset.asp");
        xhr3.send(null);
    }
    function setLadderReset() {
        if (xhr3.readyState == 4) {
            var data = xhr3.responseText;
            var slipdata = data.split(',');
            //alert(data);
           if ( xhr.status == 200 )
           {
              //var slipdata = data.split(',');
              //alert(slipdata[15]);
              //alert(data);
              //alert(slipdata[5]);
              document.getElementById("game_second").value = slipdata[0];
              document.getElementById("openflag1").value = slipdata[1];
              document.getElementById("ladder_value").value = slipdata[2];
              document.getElementById("game1_no").value = slipdata[3];
              //document.getElementById("game1_desc").innerHTML = slipdata[4];
              document.getElementById("game_status1").value = slipdata[5];
              document.getElementById("allbet_ss").innerHTML = slipdata[6];
              document.getElementById("allbet_dd").innerHTML = slipdata[7];
              document.getElementById("allbet_hh").innerHTML = slipdata[8];
              document.getElementById("allbet_ll").innerHTML = slipdata[9];
              document.getElementById("allbet_sh").innerHTML = slipdata[10];
              document.getElementById("allbet_sl").innerHTML = slipdata[11];
              document.getElementById("allbet_dh").innerHTML = slipdata[12];
              document.getElementById("allbet_dl").innerHTML = slipdata[13];
              document.getElementById("turn_no1").innerHTML = slipdata[14];
              //document.getElementById("result_msg").value = slipdata[15];
              //document.getElementById("prev_result_msg").innerHTML = slipdata[15];
              //document.getElementById("prev_result_desc").innerHTML = slipdata[16];
              //alert(document.getElementById("game_second").value);
              clearInterval(mytime);
              fTimerStart();
              if(slipdata[5] == 1)
              {
                document.getElementById("bet_end_board").style.display = "none";
              }
              else
              {
                document.getElementById("bet_end_board").style.display = "block";
                if(document.getElementById("ladder_flag").value == "1")
                {
                    document.location.reload();
                }
                  //setTimeout("document.location.reload();", 5000);
              }
            //fAni();
            //fTimer(slipdata[0]);
           }
           else
           {
               setTimeout("ladderReset();", 1000);
               //setTimeout("document.location.reload();", 5000);
           }

        }        
    }
     
    //var xhr3;
    function calcReset() {
        xhr3 = new XMLHttpRequest();
        xhr3.onreadystatechange = setCalcReset;
        xhr3.open("POST", "calc_reset.asp");
        xhr3.send(null);
    }
    function setCalcReset() {
        if (xhr3.readyState == 4) {
            var data = xhr3.responseText;
            var slipdata = data.split(',');
            document.getElementById("calc_flag").value = slipdata[0];
            document.getElementById("prev_result_msg").innerHTML = slipdata[1];
            document.getElementById("prev_result").value = slipdata[2];
            if (slipdata[0] == 1) {
                document.getElementById("prev_result_box").style.display = "block";
                setTimeout("resultMsgHide()" ,5000);
                //var iframe1 = document.getElementById("resultframe");
                var iframe2 = document.getElementById("listframe");
                //iframe1.src = iframe1.src;
                iframe2.src = iframe2.src;
                imgChange();

            }
        }
    }

    function resultMsgHide() {
        document.getElementById("prev_result_box").style.display = "none";
    }

 </script>

			<div class="subcontent01">

			<!--[s] 게임 종료 이미지 영역 -->
            <% if game_status1 <> "0" then %>
					<div id="bet_end_board" class="betting_end" style="display:none;"><p>베팅이 종료되었습니다.</p></div>
            <% else %>
					<div id="bet_end_board" class="betting_end" style="display:block;"><p>베팅이 종료되었습니다.</p></div>
            <% end if %>


			<!--[e] 게임 종료 이미지 영역 -->

				<div class="up_sec">
				
					<!-- 50~00초는 연두색 으로 나와야 함 -->
					<p class="sec1"><span id="turn_no1"><%=turn_no1 %> </span><strong id="dtimer"></strong><p>
					
					<div class="time">
					<p>
					<span id="clock_hour1" class="hour"></span>
					<span id="clock_hour2" class="hour"></span>
					<span><img src="/img/time_center.png" width="5" height="44"></span>
					<span id="clock_minute1" class="hour"></span>
					<span id="clock_minute2" class="hour"></span>
					
					</p>

				</div>
					
					<!-- 10~00초는 빨강색 으로 나와야 함 -->
					<!-- <span class="sec2">10</span> -->
				
				</div>
                
		<form id="form1" name="formBet" method="post" >
                <div class="ladder_betting">
		  
					  <div class="odd_betting">

							<div class="btn_mny">
								<p class="lad_title">홀</p>
								<p><input type="button"  value="홀" id="ss" ladder_value="SS" onclick="selectSingle(this)" class="btn_ladder_odd"></input></p>
								<p class="odd_num"><%=formatnumber((ss_rate),2) %></p>
							</div>
								<div class="btn_mny">
										<p class="lad_title">짝</p>
								<p><input type="button"  value="짝" id="dd" ladder_value="DD" onclick="selectSingle(this)" class="btn_ladder_even"></input></p>
								<p class="odd_num"><%=formatnumber((dd_rate),2) %></p>
							</div>
					</div>
					  <div class="odd_betting">
							<div class="btn_mny" >
								<p class="lad_title">HIGH</p>
								<p><input type="button"  value="H" id="hh" ladder_value="HH" onclick="selectSingle(this)" class="btn_ladder_odd"></input></p>
								<p class="odd_num"><%=formatnumber((hh_rate),2) %></p>
							</div>
								<div class="btn_mny">
										<p class="lad_title">LOW</p>
								<p><input type="button"  value="L" id="ll" ladder_value="LL" onclick="selectSingle(this)" class="btn_ladder_even"></input></p>
								<p class="odd_num"><%=formatnumber((ll_rate),2) %></p>
							</div>

					</div>
					  <div class="even_betting">

						


							<div class="btn_mny">
								<p class="lad_title">복승식</p>
								<p><input type="button"  value="홀/H" id="sh" ladder_value="SH" onclick="selectSingle(this)"  class="btn_ladder_even02"></input></p>
								<p class="odd_num"><%=formatnumber((sh_rate),2) %></p>
							
								<p><input type="button"  value="홀/L" id="sl" ladder_value="SL" onclick="selectSingle(this)" class="btn_ladder_even02"></input></p>
								<p class="odd_num"><%=formatnumber((sl_rate),2) %></p>
							</div>
							<div class="btn_mny">
								<p class="lad_title">복승식</p>
								<p><input type="button"  value="짝/H" id="dh" ladder_value="DH" onclick="selectSingle(this)" class="btn_ladder_odd02"></input></p>
								<p class="odd_num"><%=formatnumber((dh_rate),2) %></p>
								<p><input type="button"  value="짝/L" id="dl" ladder_value="DL" onclick="selectSingle(this)" class="btn_ladder_odd02"></input></p>
								<p class="odd_num"><%=formatnumber((dl_rate),2) %></p>
							</div>
							
					</div>
				<div class="play_betting">
                <div style="height:15px;"></div>
					<input type="button" class="btn_betting02" onclick="javascript:BettingCheck(formBet);" style="cursor:pointer; " value="베팅하기"/>
					<input type="button" class="btn_betting03" onclick="javascript:basketDelete(this);" style="cursor:pointer; " value="베팅취소" />
				</div>
				</div>
                </form>

                
				  <div class="ladder_money">
							<div class="ladder_btn">
								<input type="button" point="10000" onclick="javascript:pointSet(this);" value="10,000" class="btn_money"></input>
								<input type="button" point="30000" onclick="javascript:pointSet(this);" value="30,000" class="btn_money"></input>
								<input type="button" point="50000" onclick="javascript:pointSet(this);" value="50,000" class="btn_money"></input>
								<input type="button" point="100000" onclick="javascript:pointSet(this);" value="100,000" class="btn_money"></input>
								<input type="button" point="500000" onclick="javascript:pointSet(this);" value="500,000" class="btn_money"></input>
								<input type="button" point="1000000" onclick="javascript:pointSet(this);" value="1,000,000" class="btn_money"></input>
							</div>
								<!-- 기본 흑백 CSS -> btn_money / 클릭시 CSS -> btn_money_ov -->		
						<div class="lft_pay02">
						<ul>
								<li>베팅금액<input type="text" class="lft_input01" id="bet_point" name="bet_point" onkeyup="amt_calculate();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();"   value="5,000" ></li>
								<li class="max" point="<%=Session("bet_limit") %>" onclick="javascript:pointSet(this);" style="cursor:pointer;">MAX</li>
								<li>예상배당금<input type="text" class="lft_input02" id="dividend_amt_predict" name="dividend_amt_predict" onkeyup="amt_calculate();" onkeypress="if((event.keyCode<48) || (event.keyCode>57)){event.returnValue=false;}" onfocus="javascript:this.select();" value="0" ></li>
								
						</ul>
					  </div>
				 </div>


			
	<!--[e] ASIDE -->		
				

				
	<!--[e] ASIDE -->		
				

				<div class="subcontent subcontent02">
		
        
				<iframe id="resultframe" frameborder="0" marginwidth="0" marginheight="0" width="100%" height="360px" name="resultframe" scrolling="no" src="result_frame.asp"style="padding:0 0 3px 0; "></iframe>
				<iframe id="listframe" frameborder="0" marginwidth="0" marginheight="0" width="100%" height="530px" name="listframe" scrolling="no" src="list_frame.asp"  style="padding:0 0 3px 0; "></iframe>


		</div>
			
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
