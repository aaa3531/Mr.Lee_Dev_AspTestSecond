<!-- #include virtual="/_include/connect3.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
  if request("member_no") <> "" then
     Session("member_no") = request("member_no")
   end if

   strSQL = "p_sh_game_basket_updown_kospi_status '" & Session("member_no") & "'"  

  'response.write strSQL
  'response.End

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if NOT rsData.EOF and NOT rsData.BOF then
	game_no =  rsData("game_no")
    open_flag = rsData("open_flag")
    game_second = rsData("game_second")
  end if   

  set rsData = nothing
   
  '주가읽기
  if request("chart") = "" then
  strSQL = "p_sh_stock_index_chart_candle3 '" & yyyymmdd & "', 'KOSPI'"
  else 
  strSQL = "p_sh_stock_index_chart_candle '" & yyyymmdd & "', 'KOSPI'"
  end if 
  'response.write strSQL
  'response.end

  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.Open strSQL, DbCon2, 1, 1
    
  if rsList.EOF or rsList.BOF then
	NoDataList = True
  Else
	NoDataList = False
  end if  
  'response.write strSQL
  'response.End  
    
%> 
<% if open_flag = "1" then %>
<script language="javascript" type="text/javascript">
    
    setTimeout("document.location.reload();", 5000);
    
</script>
<% end if %>


<% if Session("grade_cd") = "U" then %>

  
  <div style="margin:10px 0 5px 0;border:solid 0px #efefef;background-color:#ffffff; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;" oncontextmenu="return false">
    <img src="/images/flag_korea.png" />
  </div>
  <% else %>
  
  <div style="height:150px;padding:150px 0 0 0;text-align:center;">
  B2B회원은 베팅할 수 없습니다.
  </div>  

<% end if %>
   
<!-- #include virtual="/_include/connect_close3.inc" -->
<!-- #include virtual="/_include/connect_close.inc" -->