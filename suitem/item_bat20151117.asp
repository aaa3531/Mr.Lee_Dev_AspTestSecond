<%
if Session("member_no") < "1"  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Register or Login please...");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif request("bet_point") < "0"    then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("No betting point...");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif  (request("bet_point") * 1 - request("point_total") > 0)  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Check total point...");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_item_bat '" & request("game_no") & "','" & _
                                      Session("member_no") & "','" & _
                                      request("bat_stock") & "','" & _
                                      request("bat_point") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp?game_no="&request("game_no")&"&flag="&request("flag")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc"-->
