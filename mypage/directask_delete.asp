<!-- #include virtual="/_include/connect.inc" -->
<%   
    memo_no = request("memo_no")
    strSQL = "p_sh_memo_directask_delete '" & memo_no & "'"
    
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
