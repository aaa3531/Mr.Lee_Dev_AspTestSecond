<!-- #include virtual="/_include/connect.inc" -->
<%  

    strSQL = "p_sh_game_basket_ladder_set '" & Session("member_no") & "','" & _
                                               request("game_no") & "','" & _
                                               request("ladder_value") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 
    data_desc = rsData("data_desc")
    set rsData = nothing
    'Response.write "1.1,5500"
    session("current_game") = "L"
    Response.write data_desc
  
%>
<!-- #include virtual="/_include/connect_close.inc"-->
