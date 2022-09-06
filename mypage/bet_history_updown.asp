<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  strSQL = "p_sh_game_point_member_updown_list '" & Session("member_no") & "' "
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
		<div class="snb_title">
				<ul>
				<li class="snb_01">베팅내역<span>고객님의 UP&DOWN 베팅 내역입니다.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">

		</div>


    <div class="board_tab">
				<ul>
					<li><a href="bet_history_updown.asp?member_no=<%=session("member_no") %>"" class="submnu_tab">UP&amp;DOWN</a></li>
					<li><a href="bet_history_item.asp?member_no=<%=session("member_no") %>" class="submnu_tab">종목매치</a></li>
					<li><a href="bet_history_theme.asp?member_no=<%=session("member_no") %>" class="submnu_tab">종목레이스</a></li>
				</ul>
			</div> 
				<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
						<caption>베팅내역(UP&DOWN)</caption>
							<col width="160">
							<col width="160">
							<col width="* ">
							<col width="160">
							<col width="160">
							<col width="160">

						   <thead>
								<tr>
									<th>시간</th>
									<th>금액</th>
									<th>베팅</th>
									<th>결과</th>
									<th>배당률</th>
									<th>배당금</th>
								</tr>
						   </thead>
						 
						 <tbody>

								<% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                                  <% 
                                     Do While Not rsData.EOF    %> 
                                    <tr>
                                    <td><%=mid(rsData("yyyymmdd"),5,2) %>월<%=mid(rsData("yyyymmdd"),7,2) %>일<Br /><%=rsData("tr_time") %></td>   
                                    <td><%=rsData("bet_net_amt") %></td>    
                                    <td><%=rsData("auto_desc") %> - <%=rsData("updown_cd") %></td>    
                                    <td><%=rsData("updown_cd_result") %></td>    
                                    <td><%=rsData("dividend_rate") %></td>  
                                    <% if rsData("dividend_amt") > 0 then %>
                                    <td >
                                    <%=rsData("dividend_amt") %>
                                    </td>  
                                    <% else %>
                                    <td>
                                    <%=rsData("dividend_amt") %>
                                    </td>  
                                    <% end if %>
                                    </tr>
                                    <% 	
                                        rsData.MoveNext
	                                    Loop 
                                    %>
	                                <% else %>
	                                <tr>
                                    <td colspan="6">오늘의 베팅이 없습니다.</td>
                                    </tr>
                                    <% end if         
                                    set rsData = nothing
                                    %>  
								
						   </tbody>
					</table>
				</div>
	

			
		</div>
		
	</div>
		<!-- //content -->
	<!-- //container -->
	<!-- footer -->


<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
