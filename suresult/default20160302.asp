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
			<div class="subcontent">

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
					  <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="베팅 시간, 금액,배당,경기결과,배당금,결과를 알려주는 표" class="tbl_game">
						<caption>베팅 UP&amp;DOWN</caption>
							<col width="46">
							<col width="64">
							<col width="114 ">
							<col width="63">
							<col width="63">
							<col width="57">
							<col width="57">
							<col width="57">
							<col width="98">
							<col width="56">
						   <thead>
								<tr>
									<th rowspan="2">시간</th>
									<th rowspan="2">배팅시간</th>
									<th rowspan="2">배팅금액</th>
									<th rowspan="2">배당</th>
									<th rowspan="2">배팅</th>
									<th colspan="3">경기결과</th>
									<th rowspan="2">배당금</th>
									<th rowspan="2">결과</th>
								</tr>
								<tr>
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
									<td>	</td>
									<td>	</td>
									<td>	</td>
									<td>
    <% if rsData("updown_cd") = "UP" then %>
    <img src="/img/ico_red.gif" width="10" height="10">
    <% else %>
    &nbsp;
    <% end if %>					
                                    </td>
									<td>
    <% if rsData("updown_cd") = "DRAW" then %>
    <img src="/img/ico_black.gif" width="10" height="10">
    <% else %>
    &nbsp;
    <% end if %>					
                                    </td>
									<td>
    <% if rsData("updown_cd") = "DOWN" then %>
    <img src="/img/ico_blue.gif" width="10" height="10">
    <% else %>
    &nbsp;
    <% end if %>					
                                    </td>
									<td></td>
									<td></td>
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

	<!--[s] ASIDE -->		
			<div class="aside">
				<div class="info_type">
					<p><span>공지</span><img src="/img/5px_arrow.gif" width="5" height="5"><a href="/sucustomer/notice.asp">항하사 공지사항을 확인하세요</a></p>
				</div>				

    <!-- #include virtual="/_include/left_profile.asp" -->
				


    </div>
	<!--[e] ASIDE -->		
			

		
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
	
	
	
	
	

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
