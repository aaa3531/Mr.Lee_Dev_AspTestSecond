<%
  'Session.CodePage = 65001
  'response.CharSet = "UTF-8"
  
if request("email_address") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("�׸��� ������ϴ�.");
    history.go(-1);
//-->
</SCRIPT>
<%
else

  Set Dbcon = Server.CreateObject("eDBConn.CQuery")

  email = Request("email_address")
  frommail = "�۷ι����� <songpnet@naver.com>"

  strSQL = "select a.* from gim_member a where a.member_email = '" & email & "' and usage_flag = '1'"
  'response.Write strSQL
  bRtn = dbcon.GetResult(strSQL, rs)

  if rs.EOF or rs.BOF then
	member_no = ""
	member_name = ""
	member_alias = ""
	member_pwd = ""
  Else
	member_no = rs("member_no")
	member_name = rs("member_name")
	member_alias = rs("member_alias")
	member_pwd = rs("member_pwd")
  end if   
  set rs = nothing
  
  mail_body = "<!DOCTYPE HTML> " & _
              "<html> " & _
              "<head> " & _
              "<title>�۷ι����� ��й�ȣ email ����</title> " & _               "</head> " & _               "<body> " & _               "<table border=0 cellpadding=0 cellspacing=0 border=0  width=900> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff> " & _
              "�۷ι����� ��й�ȣ email �����Դϴ�. " & _
              "</td> " & _
              "</tr> " & _
              "<tr height=25><td></td></tr> " & _
              "</table> " & _
              "<table border=0 cellpadding=0 cellspacing=0 border=0  width=900> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>����</td> " & _
              "<td bgcolor=#ffffff width=200> " & member_name & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>ALIAS</td> " & _
              "<td bgcolor=#ffffff width=200> " & member_alias & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>����</td> " & _
              "<td bgcolor=#ffffff width=200> " & email & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>���</td> " & _
              "<td bgcolor=#ffffff width=200><font style=font-weight:bold;> " & member_pwd & "</font></td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td colspan=2 align=center><a href=http://www.globalintelligence.kr/gimember/login.asp><font style=font-weight:bold;> [ �α��� �ٷΰ��� ] </font></a></td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=25><td></td></tr> " & _
              "</table> " & _
              "<table border=0 cellspacing=0 cellpadding=0 width=900 bgcolor=#ffffff> " & _
              "<tr height=30><td width=900 valign=middle> " & _
              "</td></tr> " & _
              "<tr height=45><td bgcolor=#efefef width=900>" & _
              "&nbsp;&nbsp;&nbsp;Mission<br> " & _
              "* �۷ι����� ����,�м�,����,���� �ַ���� �����մϴ�.<br> " & _
              "* �۷ι������� �����մϴ�.<br> " & _
              "* �۷ι������� ������ ��� �� �� �ִ� �۷ι�����MARKET�� �����մϴ�.<br> " & _
              "* ���谢���� ������ ��û�ϰ� �������� �亯�� ���� �� �ֽ��ϴ�. Global Intelligence<br> " & _
              "<a href=http://www.globalintelligence.kr/giprosuming/subscribe.asp><b>[������û]</b></a><br> " & _
              "</td></tr> " & _
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
		.Subject = "�۷ι����� ��й�ȣ �̸��� �����Դϴ�."
		.HTMLBody = mail_body
		.Send
  End With

  Set objMessage			= Nothing
  Set objConfig				= Nothing

  strSQL = "p_giz_mailing_log '" & member_no & "','" & _
									model_no & "','" & _
									"songpanet@naver.com','" & _
									email & "','" & _
									mail_body & "','FINDPWD'"

  'response.Write strSQL		
  bRtn = Dbcon.GetResult(strSQL, rs)

  set rs = nothing 

  set DbCon = nothing
  
  message = "Password mailing Success!"
 
  Response.Redirect "login.asp?message="&message
	
End If
%>