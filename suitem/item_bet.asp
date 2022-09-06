
<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%   

  strSQL = "p_sh_game_item_bet_new '" & Session("member_no") & "','" & _
                                        request("game_no") & "','" & _
                                        replace(request("bet_point"),",","") & "'"
  
  'response.write strSQL
  'response.End

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1 
  
  result_desc = rsData("result_desc")    

  set rsData = nothing

  
  Response.write result_desc
  
%>
<!-- #include virtual="/_include/connect_close.inc"-->
