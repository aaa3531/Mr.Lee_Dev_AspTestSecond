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
  message = "이메일 회원가입입니다."
else
  message = request("message")
end if
 %>

<table  width=1024 align=center>
<tr>
<td width=754 valign=top>



<% membermenu = "REGISTER"
   menu_desc = "회원가입"
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
      <td width="15%" align="center">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명
      </td>
      <td width="85%">
      <input type="text" name="member_name" size="255" style="width:120" class="input" ID="Text3" placeholder="필수항목입니다" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">이&nbsp;메&nbsp;일
      </td>
      <td width="85%">
      <input type="email" name="member_email" size="255" style="width:240" class="input" ID="Text5" placeholder="필수항목입니다" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">비밀번호
      </td>
      <td width="85%">
      <input type="password" name="member_pwd" size="255" style="width:120" class="input" ID="Password1" placeholder="필수항목입니다" required>
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명
      </td>
      <td width="85%">
      <input type="text" name="member_alias" size="255" style="width:120" class="input" ID="Text1"> (없으면 이메일앞 아이디 자동부여)
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속
      </td>
      <td width="85%">
      <input type="text" name="org_name" size="255" style="width:120" class="input" ID="Text4"> (예 : 삼성, 대학교 ...)
      </td>
      </tr>
      <tr height="32">
      <td width="15%" align="center">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;별
      <input type="checkbox" name="terms_flag" value="1" > 약관동의&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="subscribe_flag" value="1" checked> 정보레터 구독&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="worldflower_flag" value="1" > 세계화 참여
      </td>
      </tr>
      <tr height="35">
      <td colspan="2">
      <!-- #include virtual="/_include/note_terms.inc" -->
      </td>
      </tr>
      <tr height="35">
      <td colspan="2">관심앱 : 
      <% if NoDataIndustry = False then ' 데이터가 있으면 데이터 출력 %>

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
      <input class="linkbtnblue" name="submit1" type="submit" value="회원가입">
      <div style="margin:5px 0 0 0;padding:5px;text-align:center;line-height:180%;">
      <span style="font-weight:bold;padding:30px;color:#3388cc;">가입 후 이메일에서 확인하면 회원가입이 완료됩니다.</span>
      </div>
      </td>
      </tr>
      </table>      
    </form>
</div>

    <div style="margin:20px 0 30px 0;padding:15px 35px 15px 5px;text-align:center;">
    <form action="password_find.asp" id="form2" name="formemail" method="post">
    <span style="font-weight:bold;color:#3388cc;">비밀번호찾기</span>
    <input type="text" name="email_address" size="255" style="width:240" class="input" id="Text2" /> (이메일)
    <input id="submit3" name="submit1" type="submit" value="비밀번호전송"> 
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
