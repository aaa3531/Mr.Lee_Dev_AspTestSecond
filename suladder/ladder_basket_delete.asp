<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_basket_ladder_delete '" & Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    'Response.redirect "kospi.asp"
  
%>
<!-- #include virtual="/_include/connect_close.inc"-->
