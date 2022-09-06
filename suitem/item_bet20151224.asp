<!-- #include virtual="/_include/login_check.inc" -->


<script>
    function windowclose(){
        window.close();
        }
</script>

<%
if request("bet_point") = ""    then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Betting point empty!");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_game_item_bet '" & Session("member_no") & "','" & _
                                                       replace(request("bet_point"),",","") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    result_no = rsData("result_no")
    result_desc = rsData("result_desc")
    
          
    set rsData = nothing
    set Dbcon = nothing
    
    'response.write result_desc & "...."

end if     
%>

<body onLoad="javascript:windowclose();">
</body>
<!-- #include virtual="/_include/connect_close.inc"-->
