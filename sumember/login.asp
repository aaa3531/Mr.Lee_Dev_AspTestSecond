<!-- #include virtual="/_include/top_menu_member.inc" -->


<table width=1024 align=center>
<tr>
<td width=754 valign=top>

  <div id="guideleft">
  ▣ 고객센터 - 로그인
  </div>
  <div id="guide">
  <a href="/">HOME</a> >
  <a href="/gicustomer/notice.asp">고객센터</a> >
  <span class="sel">로그인</span>
  </div>

  <div style="clear:both;"></div>    
  
    <div style="margin:60px 0 0 0;padding:10px;text-align:center;color:#3388cc;font-size:11pt;font-weight:bold;">
    <%=request("message") %>
    </div>
    <div class="newsbox754">
    <div style="margin:10px 0 10px 0;">
    <form action="/sumember/login_set.asp" id="formLogin" name="formLogin" method="post">
    <input type="hidden" name="remote_url" value="<%=Request("remote_url") %>" id="Hidden10" /> 	
    <table>
    <tr height="25">
    <td width="100"></td>
    <td width="100" align="center">이메일
    </td>
    <td width="300">
    <input type="email" name="member_email" size="8" style="width:240" class="input" id="Text1"  required />&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
    <td width="274">
    <input class="linkbtnblue" name="submit1" type="submit" value="로그인">
    </td>
    </tr>
    <tr height="25">
    <td width="100"></td>
    <td width="100" align="center">비밀번호
    </td>
    <td width="300">
    <input type="password" name="member_pwd" size="8" style="width:120" class="input" id="Password1" required >
    </td>
    <td width="274">
    </td>
    </tr>
    </table>
    </form>  
    </div>   
    </div>   

    <div style="margin:50px 0 50px 0;text-align:center;">
    <a href="/gimember/register.asp"><span class="linkbtnblue">회원가입</span></a>
    </div>

    <div style="margin:10px 0 10px 0;">
    <form action="password_find.asp" id="form1" name="formemail" method="post">
    <table>
    <tr height="55" style="margin:20px 0 30px 0;padding:15px 35px 15px 5px;">
    <td width="100"></td>
    <td width="100" align="center">비밀번호찾기
    </td>
    <td width="300" align="left">
    <input type="email" name="email_address" size="255" style="width:240" class="input" id="Text3"  required  placeholder="이메일을 넣어 주세요. 비밀번호 전송" />
    <td width="274" align="left">
    <input  class="linkbtnblue" name="submit1" type="submit" value="비밀번호전송"> 
    </td>
    </tr>
    </table>
    </form> 
    </div>

    <div style="height:50px;">
    </div>
      
</td>
<td width=270 valign=top>

<!-- #include virtual="/_include/right_contents_member.asp" -->

</td>
</tr>
</table>

<!-- #include virtual="/_include/bottom_menu.inc" -->
