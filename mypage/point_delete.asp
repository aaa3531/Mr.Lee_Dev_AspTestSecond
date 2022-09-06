<!-- #include virtual="/_include/connect.inc" -->
<%   
    ledger_no = request("ledger_no")
    inout_code = request("inout_code")
    strSQL = "p_sh_point_inout_delete '" & ledger_no & "' , '" & inout_code & "'"
    
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
