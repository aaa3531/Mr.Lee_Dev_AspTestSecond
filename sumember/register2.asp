<!-- #include virtual="/_include/top_menu_member.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
  strSQL = "p_gim_industry_list_read"  


  bRtn = dbcon.GetResult(strSQL, rsIndustry)   
  
  'response.Write strSQL
  
  if rsIndustry.EOF or rsIndustry.BOF then
	NoDataIndustry = True
  Else
	NoDataIndustry = False
  end if  
%>
<% 
if request("message") = "" then
  message = "�̸��� ȸ�������Դϴ�."
else
  message = request("message")
end if
 %>

<table  width=1024 align=center>
<tr>
<td width=754 valign=top>



<% membermenu = "REGISTER"
   menu_desc = "ȸ������"
%>
<!-- #include virtual="/_include/menu_customer.inc" --> 

    <div style="height:20px;">
    </div>
    
    
<div class="newsbox754">
    <div style="margin:5px 0 0 0;padding:5px;text-align:center;line-height:180%;">
      <span style="font-weight:bold;padding:30px;color:#3388cc;"><%=message %></span>
    </div>
    <form action="register_set.asp" id="form1" name="formMember" method="post">
    <input type="hidden" name="flag" value="1" ID="Hidden4"> 
    <table border=0 cellpadding="0" cellspacing=0 border="0"  width="100%">    
      <tr height="32">
      <td width="15%" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
      </td>
      <td width="85%">
      <input type="text" name="member_name" size="255" style="width:120" class="input" ID="Text3" placeholder="�ʼ��׸��Դϴ�" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">��&nbsp;��&nbsp;��
      </td>
      <td width="85%">
      <input type="email" name="member_email" size="255" style="width:240" class="input" ID="Text5" placeholder="�ʼ��׸��Դϴ�" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">��й�ȣ
      </td>
      <td width="85%">
      <input type="password" name="member_pwd" size="255" style="width:120" class="input" ID="Password1" placeholder="�ʼ��׸��Դϴ�" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
      </td>
      <td width="85%">
      <input type="text" name="member_alias" size="255" style="width:120" class="input" ID="Text1"> (������ �̸��Ͼ� ���̵� �ڵ��ο�)
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
      </td>
      <td width="85%">
      <input type="text" name="org_name" size="255" style="width:120" class="input" ID="Text4"> (�� : �Ｚ, ���б� ...)
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
      <input type="checkbox" name="terms_flag" value="1" > �������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="subscribe_flag" value="1" checked> �������� ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="worldflower_flag" value="1" > ����ȭ ����
      </td>
      </tr>
      <tr height="35">
      <td colspan="2">
      <!-- #include virtual="/_include/note_terms.inc" -->
      </td>
      </tr>
      <tr height="35">
      <td colspan="2">���ɾ� : 
      <% if NoDataIndustry = False then ' �����Ͱ� ������ ������ ��� %>

      <% 
       Do While Not rsIndustry.EOF    %> 
      <input type=radio name=industry_no  value="<%=rsIndustry("industry_no") %>"><%=rsIndustry("industry_alias") %>&nbsp;
      <% 	
        rsIndustry.MoveNext
	    Loop 
      %>
      <% end if         
      set rsIndustry = nothing
      %>
      
      </td>
      </tr>
      <tr height="35">
      <td colspan="2" align="center">
      <input class="linkbtnblue" name="submit1" type="submit" value="ȸ������">
      <div style="margin:5px 0 0 0;padding:5px;text-align:center;line-height:180%;">
      <span style="font-weight:bold;padding:30px;color:#3388cc;">���� �� �̸��Ͽ��� Ȯ���ϸ� ȸ�������� �Ϸ�˴ϴ�.</span>
      </div>
      </td>
      </tr>
      </table>      
    </form>
</div>

    <div style="margin:20px 0 30px 0;padding:15px 35px 15px 5px;text-align:center;">
    <form action="password_find.asp" id="form2" name="formemail" method="post">
    <span style="font-weight:bold;color:#3388cc;">��й�ȣã��</span>
    <input type="text" name="email_address" size="255" style="width:240" class="input" id="Text2" /> (�̸���)
    <input id="submit3" name="submit1" type="submit" value="��й�ȣ����"> 
    </form>  
    </div>

</td>
<td width=270 valign=top>

<!-- #include virtual="/_include/right_contents_member.asp" -->



</td>
</tr>
</table>

      <!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
