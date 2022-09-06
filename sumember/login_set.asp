<% Response.CharSet = "UTF-8" %>
<%
if request("member_id") = "" or request("member_pwd") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("항목이 비었습니다.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%
    
    strSQL = "p_sm_login_check'" &  request("member_id") & "','" & _
                                     request("member_pwd") & "','" & _
                                     Request.SerVerVariables("REMOTE_ADDR")  & "'"
    
    Set rsData=Server.CreateObject("ADODB.Recordset")
    rsData.Open strSQL, Dbcon, 1, 1
    count = rsData("count")
    
    response.Write strSQL
    response.Write rsData
    'response.End
    
    'bRtn = Dbcon.GetResult(strSQL, rsData)    
     
     
    
    if count > "0" then
      Session("member_no") = rsData("member_no")
      Session("member_email") = request("member_email")
      Session("member_id") = request("member_id")
      Session("member_alias") = rsData("member_alias")
      Session("member_phone") = rsData("member_phone")
      Session("point_total") = rsData("point_total")
      Session("admin_flag") = rsData("admin_flag")
      Session("b2b_flag") = rsData("b2b_flag")
      Session("subscribe_flag") = rsData("subscribe_flag")
      Session("yyyymmdd") = rsData("yyyymmdd")
      Session("gameday") = rsData("gameday")
      Session("memo_cnt") = rsData("memo_cnt")
      Session("grade_cd") = rsData("grade_cd")
      Session("bet_limit") = rsData("bet_limit")

      result_desc = "정상 : " & rsData("result_desc")
      response.redirect "/default.asp?result_desc="&result_desc&"&member_no="&Session("member_no")

    else

      result_desc = "에러 : " & rsData("result_desc")

      Session.Abandon
      response.redirect "/default.asp?result_desc="&result_desc
      
    end if
    

    set rsData = nothing


end if     
%>

<!-- #include virtual="/_include/connect_close.inc" -->