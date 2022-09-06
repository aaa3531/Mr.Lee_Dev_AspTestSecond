
<% Response.CharSet = "UTF-8" %>
<!-- #include virtual="/_include/connect.inc" -->

<%

  strSQL = "p_sm_member_set '" &             request("member_id") & "','" & _
                                             request("member_name") & "','" & _
                                             request("member_email") & "','" & _
                                             request("member_alias") & "','" & _
                                             request("member_pwd") & "','" & _
                                             request("recommend_id") & "','" & _
                                             request("sex_flag") & "','" & _
                                             request("member_phone1") & "','" & _
                                             request("member_phone2") & "','" & _
                                             request("member_phone3") & "','" & _
                                             request("subscribe_flag") & "','" & _
                                             request("bank_name") & "','" & _
                                             request("account_no") & "','" & _
                                             request("bank_owner") & "','" & _
                                             request("withdraw_pwd") & "','" & _
                                             Request.SerVerVariables("REMOTE_ADDR") & "'"
    
  'response.Write strSQL
  'response.End

  Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbCon, 1, 1 

  set rsData = nothing
  'set Dbcon = nothing
  
  Response.redirect "/sumember/register_step4.asp"
  
%>