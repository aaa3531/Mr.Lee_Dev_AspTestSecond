<!-- #include virtual="/_include/header_result.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  strSQL = "p_sh_game_ladder_result_list "
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
  
  
  
   strSQL = "p_sh_calculate_ladder_result "
  'response.write strSQL
  'response.End
  Set rsResult = Server.CreateObject("ADODB.RecordSet")
  rsResult.Open strSQL, DbCon, 1, 1
    
  if rsResult.EOF or rsResult.BOF then
	NoDataResult = True
  Else
	NoDataResult = False
  end if   
%>


	<!-- container -->
	<div id="container">
	
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="subcontent subcontent02">

				<div class="snb_title">
					<ul>
						<li class="snb_01">주식홀짝 결과</li>
                        <li class="snb_date"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2) %>일</li>
					</ul>
				</div>			

	<!--[s] UP&DOWN -->
					<div class="tbl_scroll">
					  <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="베팅 시간, 금액,배당,경기결과,배당금,결과를 알려주는 표" class="tbl_game">
						<caption>베팅 UP&amp;DOWN</caption>
						
						   <thead>
								<tr>
                                    <% if NoDataResult = False then ' 데이터가 있으면 데이터 출력 %>
                                    <th style="color:<%=rsResult("ladder_head_style") %>"><%=rsResult("ladder_head") %>
                                                <% 
                                                   jcount = 0
                                                   sd_result = rsResult("sd_result")
                                                   Do While Not rsResult.EOF    %> 
                                                   <% if sd_result <> rsResult("sd_result") then 
                                                      jcount = jcount + 1 %>
                                                   </th>
                                                   <th style="color:<%=rsResult("ladder_head_style") %>"><%=rsResult("ladder_head") %>
                                                   <% end if %>
                                                <% 	
                                                    sd_result = rsResult("sd_result")
                                                    rsResult.MoveNext
	                                                Loop 
                                                %>
                                                 <% if jcount < 20 then %>
                                                 <% Do While jcount < 20 %>
                                                 <th style="color:blue">-</th>
                                                 <% jcount = jcount + 1
                                                    loop %>
                                                 <% end if %>
                                    </th>
	                                <% else %>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
									<th style="color:blue">홀</th>
									<th style="color:red">짝</th>
                                    <% end if %>
								</tr>
								
						   </thead> 
						   <tbody>
                    <tr>

                    <% if NoDataResult = False then ' 데이터가 있으면 데이터 출력
                    rsResult.MoveFirst
                      %>
                    <td valign="top">
                                <% 
                                   icount = 0
                                   sd_result = rsResult("sd_result")
                                   Do While Not rsResult.EOF    %> 
                                   <% if sd_result <> rsResult("sd_result") then 
                                      icount = icount + 1 %>
                                   </td>
                                   <td valign="top">
                                   <% end if %>
                                   <div class="<%=rsResult("result_css") %>"><strong> <%=rsResult("turn_no") %></strong><span><%=rsResult("index_ladder_result") %></span></div> 
                                <% 	
                                    sd_result = rsResult("sd_result")
                                    rsResult.MoveNext
	                                Loop 
                                %>
                    </td>
	                <% else %>
                                  <td colspan="12">베팅이력이 없습니다.</td>
                    <% end if         
                        set rsResult = nothing
                    %>   
                    <% if icount < 20 then %>
                    <% Do While icount < 20 %>
                    <td width="51" valign="top">?</td>
                    <% icount = icount + 1
                       loop %>
                    <% end if %>
                    </tr>
						   </tbody>
					  </table>
                      </div>
	<!--[e] UP&DOWN -->

		</div>

			

		
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
	
	
	
	
	

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
