<!-- #include virtual="/_include/login_check.inc" -->


<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_basket_item_all_delete '" & Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "betting_frame.asp?result_no=1"

%>
<!-- #include virtual="/_include/connect_close.inc"-->
