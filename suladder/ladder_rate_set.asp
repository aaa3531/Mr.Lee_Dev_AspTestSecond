<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_ladder_rate_get_new  '" & request("game_no") & "','" & Session("member_no") & "'"
   

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    data_rate = rsData("data_rate")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    response.write data_rate 
 
%>
<!-- #include virtual="/_include/connect_close.inc"-->