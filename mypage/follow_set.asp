﻿<!-- #include virtual="/_include/login_check.inc" -->
<%
if request("follower_no") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("항목이 비었습니다.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_member_follower_toggle '" & Session("member_no") & "','" & _
                                               request("follower_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "follow.asp?page="&request("page")
end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
