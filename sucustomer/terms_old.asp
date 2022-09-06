<!-- #include virtual="/_include/header_customer.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

   ' terms Detail 뿌리기
  strSQL = "p_sm_terms_view_detail  "

  'response.write strSQL
  'response.end

  Set rsDetailList = Server.CreateObject("ADODB.RecordSet")
    rsDetailList.Open strSQL, DbCon, 1, 1

  if rsDetailList.EOF or rsDetailList.BOF then
	NoDataDetailList = True
  Else
	NoDataDetailList = False
  end if 
  
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>


<td width=754 valign=top>  

<% membermenu = "TERMS"
   menu_desc = "이용약관"
%>
<!-- #include virtual="/_include/guide_customer.inc" -->

  <div style="height:20px; padding: 5px 0 5px 10px; background-color:#ffffff; color:#47B7AD;">■&nbsp;사이트 이용약관입니다. 자세히 읽어 보시길 바랍니다.</div>
  <div style="height:10px;"></div>

    	<% if NoDataDetailList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsDetailList.EOF   %>
           <div style="padding:10px 0 0 0;  font-size:14px; font-weight:bold;"><%=rsDetailList("order_seq") %>.&nbsp;<%=rsDetailList("section_desc") %></div>
           <div style="padding:15px 0 15px 0; border-bottom:dotted 1px;"><%=rsDetailList("detail_desc") %></div>
        <%                           
        	rsDetailList.MoveNext
	        Loop 
        %>
		<% else %>
        <div style="text-align:center; padding:10px;">
        이용약관이 없습니다
        </div>
        <% end if

       	set DetailList = nothing
        %> 
        
  
</td>


<td width=270 valign=top>

   <div style="margin:32px 0 0 5px ;">
  
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_customer.asp" -->
       </div>
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
