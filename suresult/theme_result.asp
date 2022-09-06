<!-- #include virtual="/_include/header_result.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  if request("game_no") <> "" then
  game_no = request("game_no") 
  end if

  strSQL = "p_sh_game_theme_result_turn "
  'response.write strSQL
  'response.End
  Set rsTurn = Server.CreateObject("ADODB.RecordSet")
  rsTurn.Open strSQL, DbCon, 1, 1
    
  if rsTurn.EOF or rsTurn.BOF then
	NoDataTurn = True
  Else
	NoDataTurn = False
    if game_no < "1" then
    game_no = rsTurn("game_no")
    end if
  end if  


  strSQL = "p_sh_game_theme_single_result_list '" & game_no & "' " 
  'response.write strSQL
  'response.End
  Set rsGameSingle = Server.CreateObject("ADODB.RecordSet")
  rsGameSingle.Open strSQL, DbCon, 1, 1
    
  if rsGameSingle.EOF or rsGameSingle.BOF then
	NoDataGameSingle = True
  Else
	NoDataGameSingle = False
    yyyymmdd = rsGameSingle("yyyymmdd")
    status_desc = rsGameSingle("status_desc")
  end if  


  strSQL = "p_sm_game_theme_double_list '" & Session("member_no") & "','" & game_no & "'"
  
  'response.write strSQL
  'response.End

  Set rsGameDouble = Server.CreateObject("ADODB.RecordSet")
  rsGameDouble.Open strSQL, DbCon, 1, 1
    
  if rsGameDouble.EOF or rsGameDouble.BOF then
	NoDataGameDouble = True
  Else
	NoDataGameDouble = False
  end if   
%>

	<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent02">

				<div class="snb_title">
					<ul>
						<li class="snb_01">종목레이스 결과</li>
                        <li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2) %>일 <%=status_desc %></li>
					</ul>
				</div>
                
				<div class="board_tab_v2">
				<ul>
				<% if NoDataTurn = False then ' 데이터가 있으면 데이터 출력 %>
                <% 
                   Do While Not rsTurn.EOF    %> 

					    <% if rsTurn("game_no") * 1 - game_no = 0 then %>
					    <li><a href="theme_result.asp?game_no=<%=rsTurn("game_no") %>" class="submnu_tab_selected"><%=rsTurn("turn_no") %>회</a></li>
                        <% else %>
					    <li><a href="theme_result.asp?game_no=<%=rsTurn("game_no") %>" class="submnu_tab"><%=rsTurn("turn_no") %>회</a></li>
                        <% end if %>

                <% 	
                    rsTurn.MoveNext
	                Loop 
                %>
                <% end if         
                set rsTurn = nothing
                %>    
				</ul>
			</div> 

<% if game_no > "0" then %>
  
<% if NoDataGameSingle = False then ' 데이터가 있으면 데이터 출력 %>

<!--[s] 종목별 레이스 (단식)-->
 <table cellpadding="0" cellspacing="0"  border="0" summary="종목별 레이스 단식/복식" class="tbl_game tbl_race"  style="table-layout:fixed;width:670px;" >
	<caption>종목별 레이스 단식</caption>
	<thead>
		<tr>
			<th colspan="11"><%=rsGameSingle("turn_no") %> 회차&#60;단식&#62;</th>
		</tr>
	</thead>
	<tbody>

		<tr>
			<td align="center" width="100%">
				<div class="race_title">순위</div>
				<div  class="race_title">등락률</div>
				<div  class="race_title">테마명</div>
				<div  class="race_title04">배당률</div>
			</td>
    <% Do While Not rsGameSingle.EOF    %> 
            <td align="center" width="<%=rsGameSingle("width_rate") %>%">
				<div class="race_title"><span class="data"><%=rsGameSingle("order_no") %></span></div>
				<div class="race_title"><%=rsGameSingle("updown_rate") %>%</div>				
				<div class="race_title"><%=mid(rsGameSingle("theme_name"),1,5) %></div>
				
    <% if rsGameSingle("order_no") = 1 then %>
    <div class="race_title04 race_title04_ov"><%=rsGameSingle("dividend_rate") %>
    <% else %>
   <div class="race_title04"><%=rsGameSingle("dividend_rate") %>
    <% end if %>				
				</div>
			</td>


    <% 	
        rsGameSingle.MoveNext
	    Loop 
    %>
    </tr>
    </table>
    <% end if         
    set rsGameSingle = nothing
    %>  

			
		</tr>

	</tbody>
</table>
<!--[e] 종목별 레이스 (단식)-->

<!--[s] 종목별 레이스 (복식)-->

    <% ' 복식뿌리기 %>
    <% if NoDataGameDouble = False then ' 데이터가 있으면 데이터 출력 
    mybet_amt_total = rsGameDouble("mybet_amt_total") %>    
    
 <table cellpadding="0" cellspacing="0"  border="0" summary="종목별 레이스 단식/복식" class="tbl_game tbl_race"  style="table-layout:fixed;width:670px;" >
	<caption>종목별 레이스 복식</caption>
	<thead>
		<tr>
			<th colspan="11"><%=rsGameDouble("turn_no") %> 회차 &#60;복식&#62;</th>
		</tr>
	</thead>
	<tbody>
		
    <%
    init_flag = 0
    y_count = 0
    Do While Not rsGameDouble.EOF    %>
     
    <% 
    ' 첫줄 display
    if init_flag = 0 then %>
		<tr height="55">
		<td align="center" width="10%"><div class="race_title2"><span class="ellipsis3">&nbsp;</span></div></td>
    <%
       strSQL = "p_sm_game_theme_double_result_list_detail '" & Session("member_no") & "','" & game_no & "','" & rsGameDouble("theme_no") & "'"
       'response.write strSQL
       Set rs = Server.CreateObject("ADODB.RecordSet")
       rs.Open strSQL, DbCon, 1, 1
    
       if NOT rs.EOF or NOT rs.BOF then
       
       Do While Not rs.EOF %>
			<td align="center" width="<%=rs("width_rate") %>%"><div class="race_title2"><span class="ellipsis3"><%=mid(rs("theme_name"),1,5) %></span></div></td>
    <% rs.MoveNext
       loop

       end if  
       set rs = nothing
    %>
    </tr>
    <% end if %>    
    

		<tr height="35">
			<td align="center" width="10%"><div class="race_title2"><span class="ellipsis3"><%=rsGameDouble("theme_name") %></span></div></td>

    <%
       strSQL = "p_sm_game_theme_double_result_list_detail '" & Session("member_no") & "','" & game_no & "','" & rsGameDouble("theme_no") & "'"
       'response.write strSQL
       Set rs = Server.CreateObject("ADODB.RecordSet")
       rs.Open strSQL, DbCon, 1, 1
    
       if NOT rs.EOF or NOT rs.BOF then
       
       x_count = 0
       Do While Not rs.EOF %>


      <td align="center" width="<%=rs("width_rate") %>%">
      <% if x_count > y_count then %>
        <% if rs("select_flag") = "1" then %>
          <div class="race_title04 race_title04_ov"  >
          <%=rs("dividend_rate") %>
          </div>     
        <% else %>
          <div  onmouseover="ToggleColor(this,0)" onmouseout="ToggleColor(this,1)" class="race_title04">
          <%=rs("dividend_rate") %>
          </div>   
        <% end if %>
      <% elseif x_count < y_count then %>
        <% if rs("select_flag") = "1" then %>
          <div class="race_title04 race_title04_ov">
          <%=rs("dividend_rate") %>
          </div>     
        <% else %>
          <div  onmouseover="ToggleColor(this,0)" onmouseout="ToggleColor(this,1)" class="race_title04">
          <%=rs("dividend_rate") %>
          </div>     
        <% end if %>  
      <% else %> 
          <div style="height:100%;margin:0 3px 0 3px;background-color:#f0f0f0;">&nbsp;</div>
      <% end if %>
    </td> 

    <% x_count = x_count + 1
       rs.MoveNext
       loop

       end if  
       set rs = nothing
    %>
    </tr>
    <%  
      init_flag = 1
      y_count = y_count + 1
      rsGameDouble.MoveNext
      loop
    %>        
    <% end if         
    set rsGameDouble = nothing
    %>    
    		

	</tbody>
</table>
<!--[e] 종목별 레이스 (복식)-->
  <% else %>
    <div style="padding:10px;font-weight:bold;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
  종목레이스가 없습니다.
    </div>
  <% end if %>
  
    </div>
		
	<!--[s] ASIDE -->		
	<!--[e] ASIDE -->		
		
		
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
