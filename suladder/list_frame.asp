
            <link rel="stylesheet" type="text/css" href="/_css/updown2.css">
<!-- #include virtual="/_include/connect.inc" -->
<%
 'response.write Session("member_no")

 strSQL = "p_sm_gameday_ladder_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_day = rs("game_day")
    open_flag = rs("open_flag")
  end if   

  set rs = nothing

  
   strSQL = "p_sm_calculate_game_ladder_user_list '" & Session("member_no") & "'"
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
<div class="subcontent subcontent02"  oncontextmenu="return false">

			<div class="bx_txt">
						<p>베팅내역 - 회차와 시간대, 분별대의 차이는 컴퓨터의 사양 및 서버상황에 따라 조금씩 베팅시간이 다를 수 있습니다.</p>
					</div>
					  <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="베팅 시간, 금액,배당,경기결과,배당금,결과를 알려주는 표" class="lst_game">
						<caption>베팅 UP&amp;DOWN</caption>
							<col width="55">
							<col width="85">
							<col width="85">
							<col width="190">
							<col width="85">
							<col width="120">
							<col width="120">
							<col width="190">
							<col width="*">

						   <thead>
								<tr>
									<th rowspan="2">회차</th>
									<th rowspan="2">시간</th>
									<th rowspan="2">배팅시간</th>
									<th rowspan="2">배팅금액</th>
									<th rowspan="2">배당률</th>
									<th rowspan="2">배팅내역</th>
									<th rowspan="2">경기결과</th>
									<th rowspan="2">배당금</th>
									<th rowspan="2">상태</th>
								</tr>
								
						   </thead>
						   <tbody>
								<% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                                <% 
                                   Do While Not rsData.EOF    %> 
                                <tr>
                                <td align="center"><%=rsData("turn_no") %></td>  
                                <td align="center"><%=rsData("tr_time") %></td>   
                                <td align="center"><%=rsData("bet_time") %></td>   
                                <td align="center"><%=rsData("bet_net_amt") %>원</td>  
                                <td align="center"><%=formatnumber(rsData("bet_dividend_rate"),2) %></td>
                                <td align="center">
                                <img src="/img/<%=rsData("bet_img") %>" /></td>
                                <td align="center">
                                <% if rsData("game_status") = "3" then %>
                                <img src="/img/<%=rsData("result_img") %>" />
                                <% end if %>
                                </td>
                                <td align="center"><%=rsData("dividend_amt") %>원</td>
                                <td align="center">
                                <%=rsData("game_status_desc") %>
                                </td>
 
                                </tr> 
                                <% 	
                                    rsData.MoveNext
	                                Loop 
                                %>
	                            <% else %>
                                  <td colspan="12">베팅이력이 없습니다.</td>
                                <% end if         
                                set rsData = nothing
                                %>   

						   </tbody>
					  </table>
	<!--[e] UP&DOWN -->
    </div>


<!-- #include virtual="/_include/connect_close.inc" -->
