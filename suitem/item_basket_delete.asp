<!-- #include virtual="/_include/login_check.inc" -->

<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_basket_item_delete '" & Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    %>
    <script>
    alert("베팅이 취소되었습니다.");
    location.href ="default.asp";
    </script>

<!-- #include virtual="/_include/connect_close.inc"-->
