
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_withdraw_pwd_check '" & session("member_no") & "','" & _
                                         request("withdraw_pwd") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 
    
    result_no = rsData("result_no")
    result_desc = rsData("result_desc")
    'response.Write result_desc
    'response.end
    set rsData = nothing
  
    response.write result_no
%>
<!-- #include virtual="/_include/connect_close.inc" -->
