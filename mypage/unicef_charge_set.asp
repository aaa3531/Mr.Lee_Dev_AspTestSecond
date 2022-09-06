<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_member_unicef_charge '" & Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    Session("point_total") = rsData("point_total")
    result_no = rsData("result_no")
    result_desc = rsData("result_desc")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    'response.write result_desc & "...."
    Response.redirect "charge.asp?result_desc="& result_desc &"&result_no="& result_no

%>
<!-- #include virtual="/_include/connect_close.inc"-->
