
<% Response.CharSet = "UTF-8" %>
<%
if request("info_desc") = "" or  request("info_type") = "" or  request("info_note") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("정보구분과 제목, 내용을 입력하세요.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_info_insert '"    & request("market_cd") & "','" & _
                                       request("author_name") & "','" & _
                                       request("info_type") & "','" & _
                                       request("info_desc") & "','" & _
                                       request("info_note") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    if request("market_cd") = "KOSPI" then
    Response.redirect "kospi.asp"
    else
    Response.redirect "kosdaq.asp"
    end if

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
