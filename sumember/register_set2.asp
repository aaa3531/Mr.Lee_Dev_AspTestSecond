<%
if request("member_name") = "" or request("member_email") = "" or request("member_pwd") = ""  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("성명,이메일,비밀번호 항목이 필수입니다.");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif  request("terms_flag") <> "1" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("약관동의를 체크하세요.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
   
  Set Dbcon = Server.CreateObject("eDBConn.CQuery")

  strSQL = "p_gim_member_register_ask '" & request("member_name") & "','" & _
                                             request("member_alias") & "','" & _
                                             request("member_email") & "','" & _
                                             request("member_pwd") & "','" & _
                                             request("subscribe_flag") & "','" & _
                                             request("industry_no") & "','" & _
                                             request("worldflower_flag") & "','" & _
                                             request("member_phone") & "','" & _
                                             request("org_name") & "'"
    
  'response.Write strSQL
    
  bRtn = dbcon.GetResult(strSQL, rsData)
  usage_flag = rsData("usage_flag")
  message = rsData("message")
  member_no = rsData("member_no")    

  set rsData = nothing
  set Dbcon = nothing
  
  if usage_flag = "2" then
    
    email = request("member_email")
    frommail = "글로벌정보<songpanet@naver.com>"
  
    letter_subject = "글로벌정보 회원가입 확인 메일입니다."
    letter_body = "글로벌정보 회원가입 확인 메일입니다.<br>"
    letter_body = letter_body & "링크를 눌러 회원가입을 완료하십시오.<br><br>"
    letter_body = letter_body & message & "<br><br>"
    letter_body = letter_body & "<a href=http://www.globalintelligence.kr/econnect/register_confirm.asp?a=" & member_no & ">글로벌정보 회원가입 확인 ☞</a>"
   
    Set objConfig = Server.CreateObject("CDO.Configuration")

    With objConfig.Fields
        .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
        .item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\pickup"
        .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
        .item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
        .update
    End With

    Set objMessage = Server.CreateObject("CDO.Message")

    With objMessage
    Set .Configuration = objConfig
      .To = email
	  .From = frommail
	  .Subject = letter_subject
	  .HTMLBody = letter_body
	  .Send
    End With

    Set objMessage			= Nothing
    Set objConfig				= Nothing         

  end if
  
  Response.redirect "register.asp?message="&message

end if     
%>