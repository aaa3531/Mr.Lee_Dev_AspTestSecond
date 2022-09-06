<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  strSQL = "p_sh_game_point_member_list '" & Session("member_no") & "' "
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

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_mypage.asp" -->
       
</td>

<td width=754 valign=top>  


<% membermenu = "BATHISTORY"
   menu_desc = "나의 베팅 내역"
%>
<!-- #include virtual="/_include/guide_admin_mypage.inc" -->

    <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">게임번호</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">게임타입</td>  
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">게임이름</td>    
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">bat_amt</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" bgcolor="#ffffff" style="border-bottom:dotted 1px #ffffff;">
    <td align="center"><%=rsData("game_no") %></td> 
    <td align="center"><%=rsData("game_type") %></td>   
    <td align="center"><%=rsData("game_name") %></td>    
    <td align="center"><%=rsData("bat_amt") %></td>    
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="4">베팅 이력이 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>        
    </table>


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
