<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        

  if request("result_desc") <> "" then
     result_desc = request("result_desc")
   else
     result_desc = "예약된 게임을 취소할 수 있습니다."
   end if

  strSQL = "p_sh_game_reserve_cancel_list '" & Session("member_no") & "' "
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


<% membermenu = "RESERVECANCEL"
   menu_desc = "예약취소"
%>
<!-- #include virtual="/_include/guide_admin_mypage.inc" -->

  <div style="padding:10px 0 10px 0;text-align:center;color:#ff6600;">
    <%=result_desc %>
  </div>
  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">예약#</td>   
    <td width="12%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">베팅금액</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">게임</td>  
    <td width="10%" align="center"  style="border-right:dotted 1px #ffffff;color:#ffffff;"></td>    
    <td width="26%" align="center"  style="border-right:dotted 1px #ffffff;color:#ffffff;">베팅시간 / 취소시간</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="35">
    <td align="center"><%=rsData("game_type_desc") %> &nbsp; <%=rsData("reserve_no") %></td>   
    <td align="center"><%=rsData("bet_point") %>&nbsp;</td>    
    <td align="center"><%=rsData("game_name") %></td>    
    <td align="center">
      <a href="reserve_cancel_set.asp?reserve_no=<%=rsData("reserve_no") %>"><input type="button" value="취소" /></a>
    </td>    
    <td align="center"><%=rsData("register_date") %><br /><%=rsData("cancel_date") %></td>    
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="5">예약베팅이 없습니다.</td>
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
