<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        

  strSQL = "p_sh_game_point_member_item_list '" & Session("member_no") & "'"
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
							<col width="80">
							<col width="160">
							<col width="* ">
							<col width="160">
							<col width="160">
							<col width="160">

						   <thead>
								<tr>
									<th>회차</th>
									<th>시간</th>
									<th>종목1</th>
									<th>종목2</th>
									<th>배당금</th>
									<th>배당율</th>
									<th>결과</th>
								</tr>
						   </thead>
						 
						 <tbody>

    
                                <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                                <% betting_no = rsData("betting_no")
                                   bet_dividend_rate = 1.0
                                   Do While Not rsData.EOF    %> 
    
                                <% if   betting_no <> rsData("betting_no") then %>
                                <tr>
                                <% else %>
                                <tr>
                                <% end if %>
                                <td >
                                <% if betting_old <> rsData("betting_no") then %>
                                <%=rsData("turn_no") %>
                                <% end if %>
                                </td>  
                                <td >
                                <%=mid(rsData("yyyymmdd"),5,2) %>월<%=mid(rsData("yyyymmdd"),7,2) %>일<Br /><%=rsData("tr_time") %>
                                </td>   
    
                                <td >    
                                <% if rsData("select_no") = "1" then %>
                                 <div class="betbtn_select">
                                 <% else %>
                                 <div class="betbtn_normal">
                                 <% end if %> 
                                        <% if rsData("logo_img1") <> "" then  %><img src="/images/stock/<%=rsData("logo_img1") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
                                        <%=rsData("stock_name1") %>
                                  </div>
                                </td>

                                <td align="center" > 
                                 <% if rsData("select_no") = "2" then %>
                                 <div class="betbtn_select">     
                                 <% else %>
                                 <div class="betbtn_normal">
                                 <% end if %> 
                                       <% if rsData("logo_img2") <> "" then  %><img src="/images/stock/<%=rsData("logo_img2") %>" border="0"  style="height:22px;"/><% else %>(로고)<% end if %><br />
                                       <%=rsData("stock_name2") %>
                                  </div>
                                </td>  
                                <td align="center">
                                <% if   betting_old <> rsData("betting_no") then %>
                                <%=rsData("bet_net_amt") %>
                                <% end if %>
                                </td>     
                                <td align="center"><%=rsData("dividend_rate1") %>&nbsp;&nbsp;<%=rsData("dividend_rate2") %> </td>  
                                <td align="center"><%=rsData("win_desc") %></td>  
                                </tr>
                                <tr >
                                <td colspan="7">
                                <table align="center">
                                <tr>
                                <td>총 배당율 : <%=rsData("bet_dividend_rate") %>&nbsp;&nbsp;</td>
                                <td>베팅금액 : <%=rsData("bet_net_amt") %>&nbsp;&nbsp;</td>
                                <td>적중당첨금 : <%=rsData("dividend_amt") %>&nbsp;&nbsp;</td>
                                <td>결과 : <%=rsData("win_total_desc") %>&nbsp;&nbsp;</td>
                                </tr>
                                </table>
                                </td>
                                </tr>
                                <% 	
                                    betting_old = rsData("betting_no")
                                    betting_no = rsData("betting_no")
                                    win_total_desc = rsData("win_total_desc")
                                    'bet_dividend_rate = Cdbl(rsData("bet_dividend_rate"),2)
                                    dividend_amt = bet_dividend_rate * Cdbl(rsData("bet_net_amt"))
                                    dividend_amt_win = bet_dividend_rate * Cdbl(rsData("bet_net_amt_win"))
                                    rsData.MoveNext
                                    Loop 
                                %>
	                            <% else %>
	                            <tr>
                                <td colspan="7">오늘의 베팅이 없습니다.</td>
                                </tr>
                                <% end if         
                                set rsData = nothing
                                %>        
	                        </tbody>
	                 </table>
	                </div>
			
		</div>
		
	</div>
	<!-- footer -->

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
