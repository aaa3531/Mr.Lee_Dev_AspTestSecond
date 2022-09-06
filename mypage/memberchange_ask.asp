<!-- #include virtual="/_include/connect.inc" -->
<%   
    strSQL = "p_sm_member_userchange_ask '" & Session("member_no") & "'"
    
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
