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

<div style="height:20px;"></div>
<table width=1024 align=center border="0" cellpadding="0" cellspacing="0">
<tr>


<td width=754 valign=top>  

<% membermenu = "ITEM"
   menu_desc = "종목별매치"
   game_desc = mid(yyyymmdd,5,2)&"월 "&mid(yyyymmdd,7,2)&"일 <span style=color:#FF6600;>( "&item_status&" )</span>"
%>
<!-- #include virtual="/_include/guide_item.inc" -->

<div style="margin:0 5px 0 0; width:750px;">
<form name='frm'>
        <div style='margin:0 0 5px 0; border:solid 1px #47B7AD; height:26px; width:100%; overflow:hidden; background-color:#FFFF00; padding:5px 0 0 5px; font-weight:bold; color:gray;' id='scrl'></div>
</form>
</div>
<input type="hidden" name="game_no" id="gameno" value="<%=game_no %>" />
<input type="hidden" name="select_no" id="select_no" value="<%=select_no %>" />
<input type="hidden" name="open_flag" id="open_flag" value="<%=open_flag %>" />
<input type="hidden" name="game_i" id="game_i" value="0" />
<% if Session("member_no") <> "" then %>
<% if Session("grade_cd") = "U" then %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td width="70%" valign="top">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:solid 2px #eeeeee;background-color:#47B7AD;">
    <td width="60%"  align="center" colspan="2" style="border-right:dotted 1px #ffffff;">게임</td>
    <td width="20%" align="center" colspan="2" style="border-right:dotted 1px #ffffff;">배당</td>
    <td width="12%" align="center" colspan="2">결과</td>
    </tr>    
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="45" style="border-bottom:solid 2px #eeeeee;">
    <td width="30%"  align="center" >
      <% if rsData("status_flag") = "1" then %>
        <% if rsData("select_no") = "1" then %>
        <div name="stock1" id="div1_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_select" att_game="<%= rsData("game_no") %>" att_select="1" att_status="1" >
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
        <div name="stock1" id="div1_<%=rsData("game_no") %>" style="margin:3px;padding:3px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;" >
        <% if rsData("company_name1") <> "" then  %>            
          <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
          <%=rsData("company_name1") %>
        <% else %>
          (종목1 미할당)
        <% end if %>
        </div>
      <% end if %>
    </td>
    <td width="30%"  align="center" >
      <% if rsData("status_flag") = "1" then %>
        <% if rsData("select_no") = "2" then %>
        <div name="stock1" id="div2_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_select" att_game="<%= rsData("game_no") %>" att_select="2" att_status="1">
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
        <div name="stock1" id="div2_<%=rsData("game_no") %>" style="margin:3px;padding:3px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
        <% if rsData("company_name2") <> "" then  %>            
          <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
          <%=rsData("company_name2") %>
        <% else %>
          (종목2 미할당)
        <% end if %>
        </div>
      <% end if %>          
    </td>
    <td width="10%" align="center"><span name="stock_rate" id="rate1_<%=rsData("game_no") %>" style="font-size:11pt;"><%=rsData("dividend_rate1") %></span></td>
    <td width="10%" align="center"><span name="stock_rate" id="rate2_<%=rsData("game_no") %>" style="font-size:11pt;"><%=rsData("dividend_rate2") %></span></td>
    <td width="12%" align="center">
    <% if rsData("status_flag") = "3" then %>
    <span style="font-size:11pt;">
        <% if rsData("win_no") ="1" then %><%=rsData("company_name1") %>
        <% elseif rsData("win_no") ="2" then %><%=rsData("company_name2") %>
        <% else %>(결과)
        <% end if %>
    </span>
    <% else %>
      <% if rsData("status_flag") = "1" then %>
      <span style="color:#ff6600;font-size:11pt;font-weight:bold;"><%=rsData("status_desc") %></span>
      <% else %>
      <span style="color:#000000;font-size:11pt;font-weight:bold;"><%=rsData("status_desc") %></span>
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
    </table>

  </td>
  
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
  
</td>

<td width=270 valign=top> 
  <div style="margin:32px 0 0 5px ;">
  

  <iframe onload="resizeIframe(this)" id="bettingframe" frameborder="0" marginwidth="0" marginheight="0" width="100%" height="100%;" name="content" scrolling="no" src="betting_frame.asp"  style="margin:0 0 0 0;">

  </iframe>
  
    </div> 
  <div style="height:50px;"></div>
  </td>

</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
<% if item_flag = "1" then %>
<script>
   readStocks2();
</script>
<% end if %>