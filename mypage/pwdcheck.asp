
<% Response.CharSet = "UTF-8" %>
<!-- #include virtual="/_include/connect.inc" -->

<% 
strSQL = "p_sm_member_pwdcheck '" & request("member_pwd") & "','" & _
                                  Session("member_no") & "'"

Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

Cnt = 0 
If not rsData.EOF Then 
Cnt = rsData("pwd_cnt") 
bank_info = rsData("bank_info")
End If 
rsData.Close 
Set rsData = nothing 

response.Write Cnt & "," & bank_info
%> 
<!-- #include virtual="/_include/connect_close.inc" -->