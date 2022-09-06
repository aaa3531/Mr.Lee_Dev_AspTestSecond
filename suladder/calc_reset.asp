<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_ladder_calc_reset "
   

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    data_desc = rsData("data_desc")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    response.write data_desc
 
%>
<!-- #include virtual="/_include/connect_close.inc"-->