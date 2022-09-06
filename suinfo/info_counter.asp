<!-- #include virtual="/_include/connect.inc" -->
<%   
    info_no = request("info_no")
    strSQL = "p_sh_info_counter '" & info_no & "'"
    
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
