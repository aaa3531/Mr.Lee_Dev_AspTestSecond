<!-- #include virtual="/_include/login_check.inc" -->

<%
session("current_game") = "I"
if request("game_no") < "1"  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Game not selected...");
    history.go(-1);
    //-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_basket_item_set '" & Session("member_no") & "','" & _
                                             request("game_no") & "','" & _
                                             request("select_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    data_desc = rsData("data_desc")

    set rsData = nothing
    set Dbcon = nothing
    
    Response.write data_desc

end if     
%>
<!-- #include virtual="/_include/connect_close.inc"-->
