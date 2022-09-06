<!-- #include virtual="/_include/header_result.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  strSQL = "p_sh_game_updown_result_list 'KOSPI' "
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
    yyyymmdd = rsData("yyyymmdd")
  end if  
%>


	<!-- container -->
	<div id="container">
	
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent02">

				<div class="snb_title">
					<ul>
						<li class="snb_01">UP&amp;DOWN 결과</li>
                        <li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2) %>일</li>
					</ul>
				</div>
	<!--[s] UP&DOWN 그래프 영역 -->
				<div class="updown_graph">
    <iframe id="chartframe" frameborder="0" marginwidth="0" marginheight="0" border="0" width="100%" height="400" name="content" scrolling="no" src="index_chart.asp" style="background-color:#ffffff;"></iframe>
				</div>
	<!--[e] UP&DOWN 그래프 영역 -->				

	<!--[s] UP&DOWN -->
					  <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="UP&DOWN  결과 표" class="tbl_game">
						<caption>베팅 UP&amp;DOWN</caption>
							<col width="100">
							<col width="100">
							<col width="* ">
							<col width="100">
							<col width="100">
							<col width="100">
						
						   <thead>
								<tr>
									<th>회차</th>
									<th>시간</th>
									<th>결과</th>
									<th>UP</th>
									<th>DRAW</th>
									<th>DOWN</th>
								</tr>
							
						   </thead>
						   <tbody>
                            <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
                            <% 
                               Do While Not rsData.EOF    %> 
								<tr>
									<td><%=rsData("turn_no") %>회차</td>
									<td><%=rsData("tr_time") %></td>
									<td><%=rsData("updown_cd") %></td>
                                    <% if rsData("updown_cd") = "UP" then %>
									<td bgcolor="#cb0808"><span style="font-weight:bold;color:#fff"><%=rsData("value_up") %></span></td>
                                    <% else %>
									<td><%=rsData("value_up") %></td>
                                    <% end if %>
                                    <% if rsData("updown_cd") = "DRAW" then %>
									<td bgcolor="#000000"><span style="font-weight:bold;color:#fff"><%=rsData("value_draw") %></span></td>
                                    <% else %>
									<td><%=rsData("value_draw") %></td>
                                    <% end if %><% if rsData("updown_cd") = "DOWN" then %>
									<td bgcolor="#0b3bb5"><span style="font-weight:bold;color:#fff"><%=rsData("value_down") %></span></td>
                                    <% else %>
									<td><%=rsData("value_down") %></td>
                                    <% end if %>
								</tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr>
	<td colspan="10">결과가 없습니다.</td>
	</tr>
    <% end if         
    set rsData = nothing
    %>        
								
						   </tbody>
					  </table>
	<!--[e] UP&DOWN -->

		</div>

			

		
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
	
	
	
	
	

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
