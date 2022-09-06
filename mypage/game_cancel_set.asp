<!-- #include virtual="/_include/login_check.inc" -->

<%
if request("betting_no") = ""    then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Select betting!");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_cancel_set '" & Session("member_no") & "','" & _
                                        request("betting_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    result_no = rsData("result_no")
    result_desc = rsData("result_desc")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    'response.write result_desc & "...."
    Response.redirect "bet_cancel.asp?game_no="&request("game_no")&"&result_desc="& result_desc &"&result_no="& result_no

end if     
%>
<!-- #include virtual="/_include/connect_close.inc"-->
