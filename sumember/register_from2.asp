<!-- #include virtual="/_include/top_menu_member.inc" -->
<tr>
<td bgcolor=#477500>
<table bgcolor=white width=1024 align=center>
<tr>
<td width=900 valign=top>
  <table border=0 cellpadding="0" cellspacing=0 border="0"  width="100%">
  <tr height="35">
  <td>
  <font style="font-size:11pt;font-weight:bold;color:#477500">�� �Ǹŵ�� - �α��� / ȸ������</font>
  </td>
  </tr>
  <tr height="35">
  <td bgcolor="#aaddaa" width="100%">
  <font style="font-weight:bold;">&nbsp;&nbsp;�α����̳� ȸ�������� �ʿ��մϴ�.</font>
  </td>
  </tr>
  <tr height="15">
  <td bgcolor="#ffffff" width="100%">
  </td>
  </tr>
  <tr height="25">
  <td bgcolor="#ffffff" width="100%">
  <%=request("message") %>
  </td>
  </tr>
  <tr height="55">
  <td width="100%" align="left">
    <form action="register_set.asp" id="formMember" name="formMember" method="post">
    <table bgcolor="#EEEEEE">
    <tr>
    <td width="150" valign=middle align=center>
    �α���
    </td>
    <td width="350">
      <table>
      <tr height="22">
      <td width="100" align="center">�̸���
      </td>
      <td width="250">
      <input type="text" name="member_email" size="255" style="width:240" class="input" ID="Text1">
      </td>
      </tr>
      <tr height="22">
      <td width="100" align="center">��й�ȣ
      </td>
      <td width="250">
      <input type="password" name="member_pwd" size="255" style="width:120" class="input" ID="Text2">
      </td>
      </tr>
      </table>
    </td>
    <td width="254" bgcolor="#EEEEEE" align="center">
    <input id="submit2" name="submit1" type="submit" value="�α���">
    </td>
    </tr>
    </table>
    </form>
    <hr />
    <form action="register_set.asp" id="form1" name="formMember" method="post">
    <table bgcolor="#EEEEEE">
    <tr>
    <td width="150" valign=middle align=center>
    ȸ������
    </td>
    <td width="350">
      <table>
      <tr height="22">
      <td width="100" align="center">����
      </td>
      <td width="250">
      <input type="text" name="member_name" size="255" style="width:120" class="input" ID="Text3">
      </td>
      </tr>
      <tr height="22">
      <td width="100" align="center">�̸���
      </td>
      <td width="250">
      <input type="text" name="member_email" size="255" style="width:240" class="input" ID="Text5">
      </td>
      </tr>
      <tr height="22">
      <td width="100" align="center">��й�ȣ
      </td>
      <td width="250">
      <input type="password" name="member_pwd" size="255" style="width:120" class="input" ID="Password1">
      </td>
      </tr>
      <tr height="35">
      <td colspan="2" align="center">
      <input type="checkbox" name="subscribe_flag" value="1" checked> �������� ����
      </td>
      </tr>
      </table>
    </td>
    <td width="254" bgcolor="#EEEEEE" align="center">
    <input id="submit1" name="submit1" type="submit" value="ȸ������">
    </td>
    </tr>
    </table>
    </form>

  </td>
  </tr>    
  </table>
</td>
<td width=270 valign=top>

<!-- #include virtual="/_include/right_contents_member.asp" -->



</td>
</tr>
</table>

<!-- #include virtual="/_include/bottom_menu.inc" -->
