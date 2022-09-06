<!-- #include virtual="/_include/login_check.inc" -->

<%
if request("charge_amt") = "" then
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

    strSQL = "p_sm_member_follower_withdraw '" & request("member_no") & "','" & _
                                                 request("charge_amt") & "','" & _
                                                 session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    response.Redirect "follow.asp?page="&request("page") & "&member_no="&request("member_no")
    end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
