<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        

   strSQL = "p_sm_game_theme_today "
    

    'response.Write strSQL

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  game_no = rs("game_no")
  
  set rs = nothing


  strSQL = "p_sh_game_point_member_theme_single_list '" & Session("member_no") & "'"
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if 


  strSQL = "p_sh_game_point_member_theme_double_list '" & Session("member_no") & "','" & game_no & "' "
  'response.write strSQL
  'response.End
  Set rsDouble = Server.CreateObject("ADODB.RecordSet")
  rsDouble.Open strSQL, DbCon, 1, 1
    
  if rsDouble.EOF or rsDouble.BOF then
	NoDataDouble = True
  Else
	NoDataDouble = False
  end if  
%> 

<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">베팅내역<span>고객님의 종목매치 베팅 내역입니다.</span></li>
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
						<caption>1:1문의 게시판</caption>
							<col width="80">
							<col width="100">
							<col width="80">
							<col width="160">
							<col width="* ">
							<col width="150">
							<col width="150">
							<col width="80">
                            
						   <thead>
								<tr>
									<th>회차</th>
									<th>시간</th>
									<th>게임</th>
									<th>종목명</th>
									<th>금액</th>
									<th>배당율</th>
									<th>예상배당금</th>
									<th>결과</th>
								</tr>
						   </thead>
                         <!-- 단식 나의 베팅 내역 찍는 부분 -->
                            <tbody>
                            <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                            <% 
                               Do While Not rsData.EOF    %> 
                            <tr height="25" style="border-bottom:dotted 1px #dddddd;">
                            <td align="center"><%=rsData("turn_no") %></td>     
                            <td align="center"><%=mid(rsData("yyyymmdd"),5,2) %>월<%=mid(rsData("yyyymmdd"),7,2) %>일<Br /><%=rsData("tr_time") %> </td>     
                            <td align="center"><%=rsData("theme_type_desc") %> </td>     
                            <td align="center"><%=rsData("theme_name") %></td>   
                            <td align="center"><%=rsData("bet_net_amt") %></td>     
                            <td align="center"><%=rsData("dividend_rate") %></td> 
                            <% if rsData("win_flag") = "1" then %>
                            <td align="center" style="background-color:#47B7AD;"><%=rsData("dividend_amt") %></td> 
                            <% else %>
                            <td align="center"><%=rsData("dividend_amt") %></td>  
                            <% end if %> 
                            <td align="center"><%=rsData("win_desc") %></td>  
                            </tr>
                            <% 	
                                rsData.MoveNext
	                            Loop 
                            %>
	                        <% else %>
	                        <tr height="55" >
                            <td width="60" align="center" colspan="8">오늘의 베팅이 없습니다.</td>
                            </tr>
                            <% end if         
                            set rsData = nothing
                            %>        
                            </tbody>
	                 </table>
	                </div>

                            <!--복식 베팅 내역 뿌리는 부분-->
    

    		<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
						<caption>1:1문의 게시판</caption>
							<col width="80">
							<col width="100">
							<col width="80">
							<col width="160">
							<col width="* ">
							<col width="150">
							<col width="150">
							<col width="160">
							<col width="80">

						   <thead>
								<tr>
									<th>회차</th>
									<th>시간</th>
									<th>게임</th>
									<th>종목명</th>
									<th>종목명</th>
									<th>금액</th>
									<th>배당율</th>
									<th>예상배당금</th>
									<th>결과</th>
								</tr>
						   </thead>

                           <tbody>
                            <% if NoDataDouble = False then ' 데이터가 있으면 데이터 출력 %>
                            <% 
                               Do While Not rsDouble.EOF    %> 
                            <tr height="25" style="border-bottom:dotted 1px #dddddd;">
                            <td align="center"><%=rsDouble("turn_no") %> </td>  
                            <td align="center"><%=mid(rsDouble("yyyymmdd"),5,2) %>월<%=mid(rsDouble("yyyymmdd"),7,2) %>일<br><%=rsDouble("tr_time") %> </td>  
                            <td align="center"><%=rsDouble("theme_type_desc") %> </td>   
                            <td align="center"><%=rsDouble("theme_name1") %></td>     
                            <td align="center"><%=rsDouble("theme_name2") %></td>    
                            <td align="center"><%=rsDouble("bet_net_amt") %></td>      
                            <td align="center"><%=rsDouble("dividend_rate") %></td>  
                            <% if rsDouble("win_flag") = "1" then %>
                            <td align="center" style="background-color:#47B7AD;"><%=rsDouble("dividend_amt") %></td> 
                            <% else %>
                            <td align="center"><%=rsDouble("dividend_amt") %></td>  
                            <% end if %> 
                            <td align="center"><%=rsDouble("win_desc") %></td>  
                            </tr>
                            <% 	
                                rsDouble.MoveNext
	                            Loop 
                            %>
	                        <% else %>
	                        <tr height="55" >
                            <td width="60" align="center" colspan="9">오늘의 베팅이 없습니다.</td>
                            </tr>
                            <% end if         
                            set rsDouble = nothing
                            %>       
                            </tbody>
	                 </table>
	                </div>
  

</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
