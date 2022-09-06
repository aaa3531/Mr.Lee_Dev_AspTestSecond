
<% Response.CharSet = "UTF-8" %>
<!-- #include virtual="/_include/login_check.inc" -->


<script>
    function windowclose(){
        window.close();
        }
</script>

<%
if request("charge_amt") < 10000    then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("10000원 이상부터 충전이 가능합니다.");
    history.go(-1);
    //-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_charge_insert '" & session("member_no") & "','" & _
                                     request("charge_name") & "','" & _
                                     request("charge_amt") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    end if     
%>


<script language="javascript">
    opener.location.href = "/mypage/charge_end.asp";
    self.close();
 </script> 

<!-- #include virtual="/_include/connect_close.inc" -->
