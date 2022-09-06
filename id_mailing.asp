
<% Response.CharSet = "UTF-8" %>
<%

  email = "hspark0815@hanmail.net"
  manager_email = "songpanet@naver.com"
  
  frommail = "글로벌정보 보험관리 <songpanet@naver.com>"

  mail_body = "<!DOCTYPE HTML> " & _
              "<html> " & _
              "<head> " & _
              "<title>" & Session("top_title") & "글로벌정보 보험관리 비밀번호찾기 이메일 수신입니다.</title> " & _               "</head> " & _               "<body> " & _               "<table border=0 cellpadding=0 cellspacing=0 border=0  width=900> " & _
              "<tr height=35> " & _
              "<td bgcolor=#dddddd align=center> " & _
              "<span style=font-size:14pt;font-weight:bold;>보헌관리 앱 비밀번호 이메일 수신입니다.</span>" & _
              "</td> " & _
              "</tr> " & _
              "<tr height=25><td></td></tr> " & _
              "</table> " & _
              "</body> " & _
              "</html> "
  
  'asp mail site reference
  'http://monkeychoi.blog.me/60118971734
  
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
		.Subject = "내용"
		.HTMLBody = mail_body
		.Send
  End With
  

  Set objMessage			= Nothing
  Set objConfig				= Nothing

%>
