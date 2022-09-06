<% response.CharSet = "UTF-8" %>
<%
if request("memo_desc") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("제목이 비었습니다.");
    history.go(-1);
    //-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

     memo_desc = request("memo_desc")
     memo_desc = Replace(memo_desc, "'", "''")
     memo_desc = Replace(memo_desc, "`", "''")
     memo_desc = Replace(memo_desc, chr(13), "<BR>")
     memo_desc = Replace(memo_desc, "display:none", "")

     memo_note = request("memo_note")
     memo_note = Replace(memo_note, "'", "''")
     memo_note = Replace(memo_note, "`", "''")
     memo_note = Replace(memo_note, chr(13), "<BR>")
     memo_note = Replace(memo_note, "display:none", "")

    strSQL = "p_sh_memo_directask '"    & session("member_no") & "','" & _
                                          memo_desc & "','" & _
                                          memo_note & "'"
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "directask_end.asp"

    end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->
