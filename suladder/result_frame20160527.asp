
            <link rel="stylesheet" type="text/css" href="/_css/updown.css">
<!-- #include virtual="/_include/connect.inc" -->
<%
 'response.write Session("member_no")

 strSQL = "p_sm_gameday_read "

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
<div class="subcontent subcontent02"  oncontextmenu="return false">

					<div class="bx_txt">
						<p>최근 회차별 통계</p>
					</div>

                    <div class="tbl_scroll">
                    <table cellpadding="0" cellspacing="0"  border="1px solid gray" summary="베팅 시간, 금액,배당,경기결과,배당금,결과를 알려주는 표" class="tbl_game">
                    <tr>
                    <td width="51" valign="top">
                    <% if NoDataResult = False then ' 데이터가 있으면 데이터 출력 %>
                                <% 
                                   icount = 0
                                   sd_result = rsResult("sd_result")
                                   Do While Not rsResult.EOF    %> 
                                   <% if sd_result <> rsResult("sd_result") then 
                                      icount = icount + 1 %>
                                   </td>
                                   <td width="51" valign="top">
                                   <% end if %>
                                <div style="padding:3px; color:#000000;">
                                    <img src="/img/<%=rsResult("result_img") %>" /><%=rsResult("index_ladder") %>
                                </div>
 
                                <% 	
                                    sd_result = rsResult("sd_result")
                                    rsResult.MoveNext
	                                Loop 
                                %>
	                            <% else %>
                                  <td colspan="12">베팅이력이 없습니다.</td>
                                <% end if         
                                set rsResult = nothing
                                %>   
                    </td>
                    <% if icount < 20 then %>
                    <% Do While icount < 20 %>
                    <td width="51" valign="top">
                    </td>
                    <% icount = icount + 1
                       loop %>
                    <% end if %>
                    </tr>
                    </table>
                    </div>
	<!--[e] UP&DOWN -->
    </div>


<!-- #include virtual="/_include/connect_close.inc" -->

   
<% if open_flag = "1" then %>   
   
<script language="javascript" type="text/javascript">

    setTimeout("document.location.reload();", 5000);

</script>

<% end if %>