<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_sm_gameday_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_day = rs("game_day")
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


    var xhr;
    function getSelectItem(elem) {
        game_no = elem.getAttribute("name1");
        select_no = elem.getAttribute("name2");
        status_no = elem.getAttribute("name3");
        //alert(game_no);
        //alert(select_no);
        xhr = new XMLHttpRequest();
        d_no1 = "div1_"+game_no;
       // document.getElementById(d_no1).className = "betbtn_normal";
        d_no2 = "div2_"+game_no;
       // document.getElementById(d_no2).className = "betbtn_normal";
        if ( select_no == 1 )
        {
            document.getElementById(d_no1).className = "betbtn_normal";
            document.getElementById(d_no2).className = "betbtn_normal";
            if ( status_no == 0 ) {
                document.getElementById(d_no1).setAttribute("name3","0");
            }
            else {
                document.getElementById(d_no1).className = "betbtn_select";
                document.getElementById(d_no1).setAttribute("name3","1");
            }
        }
        else
        { 
            document.getElementById(d_no1).className = "betbtn_normal";
            document.getElementById(d_no2).className = "betbtn_normal";
            if ( status_no == 0 ) {
                document.getElementById(d_no2).setAttribute("name3","0");
            }
            else {
                document.getElementById(d_no2).className = "betbtn_select";
                document.getElementById(d_no2).setAttribute("name3","1");
            }
        }
        xhr.onreadystatechange = SelectItem;
        xhr.open("Get", "item_basket_set.asp?game_no="+game_no+"&select_no="+select_no);
        xhr.send(null);
        fFrameReload();

    }

    function SelectItem() {
        if (xhr.readyState == 4) {
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


</SCRIPT>

<div style="height:20px;"></div>
<table width=1024 align=center border="0" cellpadding="0" cellspacing="0">
<tr>


<td width=754 valign=top>  

<% membermenu = "ITEM"
   menu_desc = "Betting"
%>
<!-- #include virtual="/_include/guide_item.inc" -->


<div style="margin:0 5px 0 0; width:750px;">
<form name='frm'>
        <div style='margin:0 0 5px 0; border:solid 1px #47B7AD; height:26px; width:100%; overflow:hidden; background-color:#FFFF00; padding:5px 0 0 5px; font-weight:bold; color:gray;' id='scrl'></div>
</form>
</div>
<input type="hidden" name="game_no" id="gameno" value="<%=game_no %>" />
<input type="hidden" name="select_no" id="select_no" value="<%=select_no %>" />
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
      <div id="div1_<%=rsData("game_no") %>" onclick="getSelectItem(this)" class="betbtn_select" name1="<%=rsData("game_no") %>" name2="1" name3="0" status_<%=rsData("game_no") %>="<%=rsData("status_flag") %>">
      <% else %>
      <div id="div1_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_normal" name1="<%= rsData("game_no") %>" name2="1" name3="0" status_<%=rsData("game_no") %>="<%=rsData("status_flag") %>">
      <% end if %>
          <% if rsData("company_name1") <> "" then  %>            
            <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
            <%=rsData("company_name1") %>
          <% else %>
            (종목1 미할당)
          <% end if %>
      </div>
      <% else %>
      <div id="div1_<%=rsData("game_no") %>" style="margin:3px;padding:3px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;" status_<%=rsData("game_no") %>="<%=rsData("status_flag") %>">
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
        <div id="div2_<%=rsData("game_no") %>" onclick="getSelectItem(this)" class="betbtn_select" name1="<%= rsData("game_no") %>" name2="2" name3="0">
        <% else %>
        <div id="div2_<%=rsData("game_no") %>" onmouseover="ToggleColor(this,0)" onclick="getSelectItem(this)" onmouseout="ToggleColor(this,1)" class="betbtn_normal" name1="<%= rsData("game_no") %>" name2="2" name3="0">
        <% end if %>
        <% if rsData("company_name2") <> "" then  %>            
           <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
           <%=rsData("company_name2") %>
        <% else %>
           (종목2 미할당)
        <% end if %>
        </div>
      <% else %>
      <div id="div2_<%=rsData("game_no") %>" style="margin:3px;padding:3px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
          <% if rsData("company_name2") <> "" then  %>            
            <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0" style="height:22px;"/><% else %>(로고)<% end if %><br />
            <%=rsData("company_name2") %>
          <% else %>
            (종목2 미할당)
          <% end if %>
      </div>
      <% end if %>          
    </td>
    <td width="10%" align="center"><span id="rate_1_<%=rsData("game_no") %>"><%=rsData("dividend_rate1") %></span></td>
    <td width="10%" align="center"><span id="rate_2_<%=rsData("game_no") %>"><%=rsData("dividend_rate2") %></span></td>
    <td width="12%" align="center">
    <% if rsData("status_flag") = "3" then %>
        <% if rsData("win_no") ="1" then %><%=rsData("company_name1") %>
        <% elseif rsData("win_no") ="2" then %><%=rsData("company_name2") %>
        <% else %>(결과)
        <% end if %>
    <% else %>
      <% if rsData("status_flag") = "1" then %>
      <span style="color:#ff6600;font-weight:bold;"><%=rsData("status_desc") %></span>
      <% else %>
      <span style="color:#000000;font-weight:bold;"><%=rsData("status_desc") %></span>
      <% end if %>
    <% end if %>
    </td>
    </tr>

    <script type="text/javascript">

     var xhr2;
     function getDividendRate<%=rsData("game_no")%>() {
         gameno1 = document.getElementById("div1_<%=rsData("game_no")%>").getAttribute("name1");
         //alert(gameno1);
         status = document.getElementById("status_<%=rsData("game_no")%>").getAttribute("name1");
          if (status == 1) {
              xhr2 = new XMLHttpRequest();
              xhr2.onreadystatechange = setDividendRate<%=rsData("game_no")%>;
              xhr2.open("Get", "item_rate_set.asp?game_no=" + gameno1);
              xhr2.send(null);
          }
        }
         function setDividendRate<%=rsData("game_no")%>() {
            if (xhr2.readyState == 4) {
                var data = xhr2.responseText;
                var slipdata = data.split(',');
                //alert(slipdata[0]);
                document.getElementById("rate_1_<%=rsData("game_no") %>").innerHTML = slipdata[0];
                document.getElementById("rate_2_<%=rsData("game_no") %>").innerHTML = slipdata[1];
                document.getElementById("rate_1_<%=rsData("game_no") %>").className = "ubetbtn_ov";
                document.getElementById("rate_2_<%=rsData("game_no") %>").className = "ubetbtn_ov";
                setTimeout("getDividendRate<%=rsData("game_no")%>();", 5000);
            }
        }

             function clearDividendRate<%=rsData("game_no")%>() {
            document.getElementById("rate_1_<%=rsData("game_no") %>").className = "ubetbtn_normal";
            document.getElementById("rate_2_<%=rsData("game_no") %>").className = "ubetbtn_normal";
        }

    </script>

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
  

  <iframe id="bettingframe" frameborder="0" marginwidth="0" marginheight="0" width="100%" height="750px;" name="content" scrolling="no" src="betting_frame.asp"  style="margin:0 0 0 0;">

  </iframe>
  
    </div> 
  <div style="height:50px;"></div>
  </td>

</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
 <script>
    loopDividendRate();
</script>