<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<SCRIPT language="javascript">
    function gradeselect() {
        formGrade.submit();
    }
</SCRIPT>
<%

  if request("grade_cd") <> "" then	
     grade_cd = request("grade_cd")
  end if
  
    strSQL = "p_sm_member_detail '" & session("member_no") & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      parent_id = rs("member_id")
      parent_email = rs("member_email")
      parent_alias = rs("member_alias")
      parent_grade = rs("grade_desc")
    end if 
    set rs = nothing

  if request("member_no") <> "" then	
     member_no = request("member_no")
     
    strSQL = "p_sm_member_detail '" & request("member_no") & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      member_id = rs("member_id")
      member_pwd = rs("member_pwd")
      member_name = rs("member_name")
      member_alias = rs("member_alias")
      member_email = rs("member_email")
      margin_rate = rs("margin_rate")
      point_total = rs("point_total")
    end if 
    set rs = nothing

  end if
  'response.write   grade_no & "..."
  
    
  
  ' member 읽기
  strSQL = "p_sm_member_user_follower '" & session("member_no") & "'"
  'response.Write strSQL
  

  ' 페이지 작동되는 방식
  Set rsMember = Server.CreateObject("ADODB.RecordSet")
  rsMember.cursorlocation = 3
  rsMember.Open strSQL, DbCon, 1, 3

  if rsMember.EOF or rsMember.BOF then
	NoDataMember = True
  Else
	NoDataMember = False
  end if 
  
  '페이징처리관련
  page =request("page")
  If NoDataMember = False then
		Cus_pageSize = 20
		rsMember.PageSize = Cus_pageSize

		pagecount=rsMember.pagecount
		totalRecord = rsMember.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsMember.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsMember.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 




%>
<div style="height:20px;"></div>
<table width="1024" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width=754 valign=top>  

<% membermenu = "FOLLOW"
   menu_desc = "FOLLOW관리"
%>
<!-- #include virtual="/_include/guide_admin_mypage.inc" -->


    <div style="padding:10px;text-align:center;height:20px;background-color:#47B7AD; font-weight:bold;">
    <%=parent_id %>
    (<%=parent_alias %>, <%=parent_email %>) <%=parent_grade %>
    </div>


  <table width="100%" cellpadding="0" cellspacing="0" border="1">
  <tr>
  <td width=300 valign=top>
  <div style="text-align:center; padding:5px; background-color:#ffffff;">
  FOLLOWER
  </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">ID</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">등급</td>    
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;">마진율</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;"></td>  
    </tr>
    </table>
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataMember = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMember.EOF and RowCount > 0    %>    
        <%   if rsMember("member_no") * 1 - member_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>        
          <td width="20%" align="left">&nbsp;
          <a href="follow.asp?member_no=<%=rsmember("member_no") %>"> <%=rsMember("member_id") %> </a>
          </td>        
          <td width="20%" align="center">&nbsp;
           <%=rsMember("grade_desc") %>
          </td>
          <td width="40%" align="center">
           <%=rsMember("margin_rate") %>
          </td>
          <td width="20%" align="center">
          <a href="follow_toggle.asp?member_no=<%=session("member_no") %>&follower_no=<%=rsMember("member_no") %>"><input type="button" value="해제" /></a>
          </td>
          </tr>

        <%                                
        	RowCount = RowCount - 1
        	rsMember.MoveNext
	        Loop 
        %>
		<% else %>
		<tr height="35">
		<td align="center" colspan="3">
        	회원이 없습니다.
        </td></tr>
        <% end if         
       	set rsMember = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataMember = false Then
	Cus_Tar = "peio_no=" & peio_no 
%>
<!--#include virtual="/_include/asp_page_function.asp"-->
<table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
<%
	Response.Write ShowPageBar("follow.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
	<%end if%>		
	<!-- 페이징 처리 끝-->

  </td>


  <% '오른쪽 부분 %>


  <td width=454 valign=top>
  <% if member_no = "" then %>
  <div>
        <form action="member_follower_insert.asp" id="form1" name="formTool" method="post">
        <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden3"> 	
        <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr  height="25" >
        <td style="padding:5px;"> 아이디 :
          <input type="text" name="member_id" style="width:100px;" class="input" ID="Text1">&nbsp;
        </td>
        </tr>
        <tr  height="25" >
        <td style="padding:5px;"> 비밀번호 :
          <input type="text" name="member_pwd" style="width:100px;" class="input" ID="Text2">&nbsp;
        </td>
        </tr>
        <tr  height="25" >
        <td style="padding:5px;"> 이름 :
          <input type="text" name="member_name" style="width:100px;" class="input" ID="Text3" >&nbsp;
        </td>
        </tr>
        <tr  height="25" >
        <td style="padding:5px;"> 닉네임 :
          <input type="text" name="member_alias" style="width:100px;" class="input" ID="Text4" >&nbsp;
        </td>
        </tr>
        <tr  height="25" >
        <td style="padding:5px;"> 이메일 :
          <input type="text" name="member_email" style="width:300px;" class="input" ID="Text5">&nbsp;
        </td>
        </tr>
        <tr  height="25" >
        <td style="padding:5px;"> 마진율 :
          <input type="text" name="margin_rate" style="width:100px;" class="input" ID="Text6">&nbsp;
        </td>
        </tr>
        <tr>
        <td width="20%" align="center" style="padding:5px;">
        <input id="submit2" name="submit1" type="submit" value="등록">
        </td>
        </tr>
      </table>
      </form>
  </div> 
  <% else %>
  <div>
        <form action="member_follower_update.asp" id="form2" name="formTool" method="post">
        <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden1"> 	
        <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr  height="25" >
        <td align="left" style="padding:5px;">아이디
        <input type="text" name="member_id" style="width:80px;" class="input" ID="Text7" value="<%=member_id %>" >
        </td>
        </tr>
        <tr  height="25" >
        <td align="left" style="padding:5px;">비밀번호
        <input type="text" name="member_pwd" style="width:80px;" class="input" ID="Text8" value="<%=member_pwd %>" >
        </td>
        </tr>
        <tr  height="25" >
        <td align="left" style="padding:5px;">이름
        <input type="text" name="member_name" style="width:80px;" class="input" ID="Text9" value="<%=member_name %>" >
        </td>
        </tr>
        <tr  height="25" >
        <td align="left" style="padding:5px;">닉네임
        <input type="text" name="member_alias" style="width:80px;" class="input" ID="Text10" value="<%=member_alias %>" >
        </td>
        </tr>
        <tr  height="25" >
        <td align="left" style="padding:5px;">이메일
        <input type="text" name="member_email" style="width:200px;" class="input" ID="Text11" value="<%=member_email %>" >
        </td>
        </tr>
        <tr  height="25" >
        <td align="left" style="padding:5px;">마진율
        <input type="text" name="margin_rate" style="width:80px;" class="input" ID="Text12" value="<%=margin_rate %>" >
        </td>
        </tr>
        <tr>
        <td style="border-bottom:dotted 1px; padding:5px;" align="center" style="padding:5px;">
        <a href="follow.asp">[NEW]</a>
        <input id="submit1" name="submit1" type="submit" value="수정">
        </td>
        </tr>
      </table>
      </form>

      <div style="text-align:center; background-color:#47B7AD; height:25px;">
      총 포인트 : <%=point_total %>
      </div>

      <% ' 아래에 아래 %>

      
        <form action="member_follower_charge.asp" id="form3" name="formTool" method="post">
        <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden2"> 
        <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr  height="25" >
        <td align="left" style="padding:5px;">
        <input type="text" name="charge_amt" style="width:100px;text-align:center;" class="input" ID="Text13" value="10000" >
        <input id="submit3" name="submit1" type="submit" value="포인트충전">
        </td>
        </tr>
        </table>
        </form>
      
      
        <form action="member_follower_withdraw.asp" id="form4" name="formTool" method="post">
        <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden4"> 
        <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr  height="25" >
        <td align="left" style="padding:5px;">
        <input type="text" name="charge_amt" style="width:100px;text-align:center;" class="input" ID="Text14" value="10000" >
        <input id="submit4" name="submit1" type="submit" value="포인트회수">
        </td>
        </tr>
        </table>
        </form>


  </div> 
  <% end if %>
  </td>
  </table>

  
</td>


<td width=270 valign=top>

  
   <div style="margin:0 0 0 5px ;">
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_mypage.asp" -->
       </div>
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
