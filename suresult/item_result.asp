<!-- #include virtual="/_include/header_result.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%     

  strSQL = "p_sh_game_item_result_yyyymmdd "
  'response.write strSQL
  'response.End
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

    yyyymmdd = rs("yyyymmdd")
  Set rs = nothing


  if request("turn_no") <> "" then
  turn_no = request("turn_no")
  else
  turn_no = "1" 
  end if
    
  strSQL = "p_sh_game_item_result_turn '" & yyyymmdd & "'"
  'response.write strSQL
  'response.End
  Set rsTurn = Server.CreateObject("ADODB.RecordSet")
  rsTurn.Open strSQL, DbCon, 1, 1
    
  if rsTurn.EOF or rsTurn.BOF then
	NoDataTurn = True
  Else
	NoDataTurn = False
  end if  

    
  strSQL = "p_sh_game_item_result_list '" & yyyymmdd & "','" & turn_no & "'"
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


	<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent02">

				<div class="snb_title">
					<ul>
						<li class="snb_01">종목매치 결과</li>
                        <li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2) %>일</li>
					</ul>
				</div>
                
				<div class="board_tab_v2">
				<ul>
				<% if NoDataTurn = False then ' 데이터가 있으면 데이터 출력 %>
                <% 
                   Do While Not rsTurn.EOF    %> 

					    <% if rsTurn("turn_no") * 1 - turn_no = 0 then %>
					    <li><a href="item_result.asp?turn_no=<%=rsTurn("turn_no") %>" class="submnu_tab_selected"><%=rsTurn("turn_no") %>회</a></li>
                        <% else %>
					    <li><a href="item_result.asp?turn_no=<%=rsTurn("turn_no") %>" class="submnu_tab"><%=rsTurn("turn_no") %>회</a></li>
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
					  
					  
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
						<tr>
							<td>
							
    <% if rsData("win_no") = "1" then %>
     <div class="betbtn_select">
     <% else %>
     <div class="betbtn_normal">
     <% end if %> 
            <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
           <span class="ellipsis"><%=rsData("stock_name1") %></span> <span class="ellipsis">(<%=rsData("price_variance1") %> / <%=rsData("updown_rate1") %>%)</span>
      </div>
							
							</td>
							<td>vs</td>
							<td>
     <% if rsData("win_no") = "2" then %>
     <div class="betbtn_select">     
     <% else %>
     <div class="betbtn_normal">
     <% end if %> 
           <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
           <span class="ellipsis"><%=rsData("stock_name2") %></span><span class="ellipsis">(<%=rsData("price_variance2") %> / <%=rsData("updown_rate2") %>%)</span> 
      </div>							
							</td>
							<td><%=rsData("dividend_rate1") %></td>
							<td><%=rsData("dividend_rate2") %></td>
							<td class="name">
							<% if rsData("win_no") = "1" then %><%=rsData("stock_name1") %><%end if %>
							<% if rsData("win_no") = "2" then %><%=rsData("stock_name2") %><%end if %>
							<strong><%=rsData("win_desc") %></strong></td>
						</tr>	
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr>
    <td  colspan="6">게임 결과가 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>    
    											
						 </tbody>
					  </table>
	<!--[e] 종목별매치 테이블-->

		</div>
		
	<!--[s] ASIDE -->		
			
	<!--[e] ASIDE -->		
			

		
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
	
	
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
