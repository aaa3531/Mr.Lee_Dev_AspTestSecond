<link rel="stylesheet" type="text/css" href="/_css/sadari.css">
<!-- #include virtual="/_include/connect.inc" -->
<head>
<script>
	///////////////////////////////////////////////////
	// 스트롤 좌측 고정 tbl_game
	///////////////////////////////////////////////////
	function init_scroll(){
		//var obj_ctl=document.getElementsByClassName("tbl_scroll")[0];
		var obj_scroll=document.getElementsByClassName("tbl_scroll")[0];
		obj_scroll.scrollLeft=obj_scroll.scrollWidth;
	}
</script>
</head>
<body onLoad="init_scroll()" >
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
			<!--[s] 최근 회차 통계 및 베팅내역 테이블 영역 -->
				<div class="subcontent subcontent02" oncontextmenu="return false">
		
					<div class="bx_txt">
						<p>최근 회차별 통계</p>
					</div>
					

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
                                   <% if rsResult("status_flag") = "3" or rsResult("status_flag") = "2" then %>
                                   <div class="<%=rsResult("result_css") %>"><strong><%=rsResult("turn_no") %></strong><span><%=rsResult("index_ladder_result") %></span></div>
                                   <% end if %>
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
        
	<!--[e] ladder -->
    </div>


<!-- #include virtual="/_include/connect_close.inc" -->
   
</body>