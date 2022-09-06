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
        //alert(game_no);
        //alert(select_no);
        xhr = new XMLHttpRequest();
        d_no1 = "div1_"+game_no;
       // document.getElementById(d_no1).className = "betbtn_normal";
        d_no2 = "div2_"+game_no;
       // document.getElementById(d_no2).className = "betbtn_normal";
        if ( select_no == 1 )
        {
            document.getElementById(d_no1).className = "betbtn_select";
            document.getElementById(d_no2).className = "betbtn_normal";
        }
        else
        { 
            document.getElementById(d_no1).className = "betbtn_normal";
            document.getElementById(d_no2).className = "betbtn_select";
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
<table width=1024 align=center>
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

  <iframe id="gameframe" frameborder="0" marginwidth="0" marginheight="0" width="100%" height="750px;" name="content" scrolling="no" src="game_frame.asp"  style="margin:0 0 0 0;">

  </iframe>
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