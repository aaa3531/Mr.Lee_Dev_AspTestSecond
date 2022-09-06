<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_withdraw_insert '" & session("member_no") & "','" & _
                                        replace(request("withdraw_net_amt"),",","")  & "','" & _
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
    
%>

    <script>
           opener.location.href = "/mypage/withdraw_end.asp";
           self.close();
    </script>

<!-- #include virtual="/_include/connect_close.inc" -->

</html>