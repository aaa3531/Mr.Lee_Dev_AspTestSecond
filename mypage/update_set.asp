<!-- #include virtual="/_include/connect.inc" -->
<% Response.CharSet = "UTF-8" %>
<%

  strSQL = "p_sm_member_update '" &          session("member_no") & "','" & _
                                             request("member_pwd") & "','" & _
                                             request("member_email") & "','" & _
                                             request("member_phone1") & "','" & _
                                             request("member_phone2") & "','" & _
                                             request("member_phone3") & "','" & _
                                             request("bank_name") & "','" & _
                                             request("account_no") & "','" & _
                                             request("bank_owner") & "','" & _
                                             request("withdraw_pwd") & "'"
    
  'response.Write strSQL
  'response.End

  Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbCon, 1, 1 

  set rsData = nothing
  'set Dbcon = nothing
  
  Response.redirect "/mypage/update.asp"
  
%>