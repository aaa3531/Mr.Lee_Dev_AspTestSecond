<!-- #include virtual="/_include/login_check.inc" -->
<%
if request("select_no") <> "1" and  request("select_no") <> "2"   then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Select wrong...");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif request("bet_point") = ""    then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Check Betting point (minimum 5000)....");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif  (request("bet_point") * 1 - request("point_total") > 0)  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Check total point, please charge money...");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_item_bet '" & request("game_no") & "','" & _
                                      Session("member_no") & "','" & _
                                      request("select_no") & "','" & _
                                      request("bet_point") & "'"

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
