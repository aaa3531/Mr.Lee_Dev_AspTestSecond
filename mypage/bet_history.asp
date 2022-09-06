<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  if request("game_type") = "" then
  game_type = "U"
  else
  game_type = request("game_type")
  end if 

  strSQL = "p_sh_game_point_member_list '" & Session("member_no") & "','" & game_type & "' "
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=754 valign=top>  


<% membermenu = "BETHISTORY"
   menu_desc = "나의 베팅 내역"
%>
<!-- #include virtual="/_include/guide_admin_mypage.inc" -->

    <div style="padding : 10px;">
    <a href="bet_history.asp?member_no=<%=session("member_no") %>&game_type=U"><span class="linkbtn">UP&DOWN</span></a>
    <a href="bet_history.asp?member_no=<%=session("member_no") %>&game_type=I"><span class="linkbtn">종목</span></a>
    <a href="bet_history.asp?member_no=<%=session("member_no") %>&game_type=T"><span class="linkbtn">테마</span></a>
    </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">게임</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">금액</td>    
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">베팅</td>     
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">결과</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당률</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당금</td>  
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td align="center"><%=rsData("game_type_desc") %> - <%=rsData("tr_time") %></td>   
    <td align="center"><%=rsData("bet_net_amt") %></td>    
    <td align="center"><%=rsData("auto_desc") %> - <%=rsData("updown_cd") %></td>    
    <td align="center"><%=rsData("updown_cd_result") %></td>    
    <td align="center"><%=rsData("dividend_rate") %></td>  
    <% if rsData("dividend_amt") > 0 then %>
    <td align="center" style="background-color:#47B7AD;">
    <%=rsData("dividend_amt") %>
    </td>  
    <% else %>
    <td align="center">
    <%=rsData("dividend_amt") %>
    </td>  
    <% end if %>
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="7">오늘의 베팅이 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>        
    </table>


  
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
