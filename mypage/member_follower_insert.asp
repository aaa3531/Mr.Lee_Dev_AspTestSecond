<%
if request("member_name") = "" then
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

    strSQL = "p_sm_member_follower_insert '" & session("member_no") & "','" & _
                                               request("member_id") & "','" & _
                                               request("member_name") & "','" & _
                                               request("member_email") & "','" & _
                                               request("member_alias") & "','" & _
                                               request("member_phone") & "','" & _
                                               request("member_pwd") & "','" & _
                                               request("margin_rate") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "follow.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
