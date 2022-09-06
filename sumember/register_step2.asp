<!-- #include virtual="/_include/top_menu_home.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<script>
  function JoinFormCheck(form) {
    if (form.terms.checked == false) {
      alert("약관에 동의하셔야 회원가입이 가능합니다.");
      form.terms.focus();
      return false;
    }
    if (form.privateinfo.checked == false) {
      alert("개인정보 수집 및 이용안내에 동의하셔야 회원가입이 가능합니다.");
      form.privateinfo.focus();
      return false;
    }
    if (form.privatepolicy.checked == false) {
      alert("개인정보 취급방침에 동의하셔야 회원가입이 가능합니다.");
      form.privatepolicy.focus();
      return false;
    }

    return true;
  }

</script>

<%

   ' terms Detail 뿌리기
  strSQL = "p_sm_terms_view_detail  "

  'response.write strSQL
  'response.end

  Set rsTermsList = Server.CreateObject("ADODB.RecordSet")
    rsTermsList.Open strSQL, DbCon, 1, 1

  if rsTermsList.EOF or rsTermsList.BOF then
	NoDataTermsList = True
  Else
	NoDataTermsList = False
  end if 

  
   ' private_info Detail 뿌리기
  strSQL = "p_sm_private_info_view_detail  "

  'response.write strSQL
  'response.end

  Set rsPrvateInfo = Server.CreateObject("ADODB.RecordSet")
    rsPrvateInfo.Open strSQL, DbCon, 1, 1

  if rsPrvateInfo.EOF or rsPrvateInfo.BOF then
	NoDataPrvateInfo = True
  Else
	NoDataPrvateInfo = False
  end if 
  

   ' private_policy Detail 뿌리기
  strSQL = "p_sm_private_policy_view_detail  "

  'response.write strSQL
  'response.end

  Set rsPrvatePolicy = Server.CreateObject("ADODB.RecordSet")
    rsPrvatePolicy.Open strSQL, DbCon, 1, 1

  if rsPrvatePolicy.EOF or rsPrvatePolicy.BOF then
	NoDataPrvatePolicy = True
  Else
	NoDataPrvatePolicy = False
  end if 
%>


  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>


<td width=754 valign=top>  

<% membermenu = "GAME"
   menu_desc = "회원가입"
%>
<!-- #include virtual="/_include/guide_membership.inc" -->
<div>
<img src="../images/register_step2.png" />
</div>

  <div style="padding:20px 0 20px 5px; text-align:left;">이용약관 및 개인정보 관련 사항입니다. 반드시 읽어보시고 동의를 하셔야 회원가입이 진행됩니다.</div>

  <form name="join" method="post" onsubmit="return JoinFormCheck(this)" action="register_step3.asp">
  
  <div style="padding:5px 0 10px 0; width:100%; text-align:center; background-color:#dddddd; font-weight:bold;">이용약관</div>
  <div name="terms" style="width:98%;height:135px;padding:5px;margin:0 5px 0 0;border:solid 1px #dddddd;overflow:scroll;text-align:left;">
  <% if NoDataTermsList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsTermsList.EOF   %>
           <div style="padding:10px 0 0 0;  font-size:14px; font-weight:bold;"><%=rsTermsList("order_seq") %>.&nbsp;<%=rsTermsList("section_desc") %></div>
           <div style="padding:15px 0 15px 0; border-bottom:dotted 1px;"><%=rsTermsList("detail_desc") %></div>
        <%                           
        	rsTermsList.MoveNext
	        Loop 
        %>
		<% else %>
        <div style="text-align:center; padding:10px;">
        이용약관이 없습니다
        </div>
        <% end if

       	set TermsList = nothing
        %> 
        </div>
    <div style="padding:5px 0 10px 0; width:100%; text-align:left; " >
    <input name="terms" type="checkbox" value="1">
    이용약관에 동의합니다.</div>

    <br />

     <div style="padding:5px 0 10px 0; width:100%; text-align:center; background-color:#dddddd; font-weight:bold;">개인정보 수집 및 이용안내</div>
  <div name="terms" style="width:98%;height:135px;padding:5px;margin:0 5px 0 0;border:solid 1px #dddddd;overflow:scroll;text-align:left;">
  <% if NoDataPrvateInfo = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsPrvateInfo.EOF   %>
           <div style="padding:10px 0 0 0;  font-size:14px; font-weight:bold;"><%=rsPrvateInfo("order_seq") %>.&nbsp;<%=rsPrvateInfo("section_desc") %></div>
           <div style="padding:15px 0 15px 0; border-bottom:dotted 1px;"><%=rsPrvateInfo("detail_desc") %></div>
        <%                           
        	rsPrvateInfo.MoveNext
	        Loop 
        %>
		<% else %>
        <div style="text-align:center; padding:10px;">
        개인정보 수집 및 이용안내가 없습니다
        </div>
        <% end if

       	set PrvateInfo = nothing
        %> 
        </div>
    <div style="padding:5px 0 10px 0; width:100%; text-align:left; " >
    <input name="privateinfo" type="checkbox" />
    개인정보 수집 및 이용안내에 동의합니다.</div>

    <br />

     <div style="padding:5px 0 10px 0; width:100%; text-align:center; background-color:#dddddd; font-weight:bold;">개인정보 취급방침</div>
  <div name="terms" style="width:98%;height:135px;padding:5px;margin:0 5px 0 0;border:solid 1px #dddddd;overflow:scroll;text-align:left;">
  <% if NoDataPrvatePolicy = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsPrvatePolicy.EOF   %>
           <div style="padding:10px 0 0 0;  font-size:14px; font-weight:bold;"><%=rsPrvatePolicy("order_seq") %>.&nbsp;<%=rsPrvatePolicy("section_desc") %></div>
           <div style="padding:15px 0 15px 0; border-bottom:dotted 1px;"><%=rsPrvatePolicy("detail_desc") %></div>
        <%                           
        	rsPrvatePolicy.MoveNext
	        Loop 
        %>
		<% else %>
        <div style="text-align:center; padding:10px;">
        개인정보 취급방침이 없습니다
        </div>
        <% end if

       	set PrvatePolicy = nothing
        %> 
        </div>
    <div style="padding:5px 0 10px 0; width:100%; text-align:left; " >
    <input name="privatepolicy" type="checkbox" />
    개인정보 취급방침에 동의합니다.</div>

    <br />

    <div style="padding:10px 0 10px 0; width:100%; text-align:center;" >
    <input type="submit" value="동의합니다">
    </div>
    </form>
</td>

<td width=270 valign=top>

  
   <div style="margin:0 0 0 5px ;">
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_mypage.asp" -->
       </div>
</td>

</tr>
</table>


<div class="rightbreak10"></div>
<!-- #include virtual="/_include/connect_close.inc" -->

<!-- #include virtual="/_include/bottom_menu.inc" -->
