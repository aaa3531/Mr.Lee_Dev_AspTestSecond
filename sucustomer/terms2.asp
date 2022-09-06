<!-- #include virtual="/_include/top_menu_user.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("terms_no") = "" then	
    terms_no = "0"
  else
	terms_no = request("terms_no")
    strSQL = "p_sm_terms_detail '" & terms_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      terms_no = rs("terms_no")
      terms_desc = rs("terms_desc")
      terms_version = rs("terms_version")
      start_date = rs("start_date")
      update_date = rs("update_date")
    end if 
    set rs = nothing
  end if 
  
  ' terms 읽기
  strSQL = "p_sm_terms_list "

  'bRtn = dbcon.GetResult(strSQL, rsTerms)

  ' 페이지 작동되는 방식
  Set rsTerms = Server.CreateObject("ADODB.RecordSet")
  rsTerms.cursorlocation = 3
  rsTerms.Open strSQL, DbCon, 1, 3

  if rsTerms.EOF or rsTerms.BOF then
	NoDataTerms = True
  Else
	NoDataTerms = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataTerms = False then
		Cus_pageSize = 10
		rsTerms.PageSize = Cus_pageSize

		pagecount=rsTerms.pagecount
		totalRecord = rsTerms.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsTerms.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsTerms.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>


<td width=754 valign=top>  

<% membermenu = "TERMS"
   menu_desc = "이용약관"
%>
<!-- #include virtual="/_include/guide_customer.inc" -->

  <div style="height:10px;"></div>

  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">NO</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">문서명</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">문서Ver.</td>    
    <td width="15%"  align="center" style="border-right:dotted 1px #ffffff;">시행일자</td>    
    <td width="35%"  align="center" style="border-right:dotted 1px #ffffff;">수정일</td>      
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataTerms = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsTerms.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsTerms.EOF and RowCount > 0         
          %>
          
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="10%" align="center">
          <%=rsTerms("terms_no") %>
          </td>
          <td width="20%" align="left">
          <a href="terms_view.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><span class="linkbtn"><%=rsTerms("terms_desc") %></span></a>
          </td>
          <td width="20%" align="center">
          <a href="terms.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><%=rsTerms("terms_version") %></a>
          </td>
          <td width="15%" align="center">
          <%=rsTerms("start_date") %>
          </td>
          <td width="35%" align="center">
          <%=rsTerms("update_date") %>
          </td>
          </tr>      

        <%                                
        	RowCount = RowCount - 1
        	rsTerms.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	회원이 없습니다.
        </td></tr>
        <% end if         
       	set rsTerms = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataTerms = false Then
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
	Response.Write ShowPageBar("terms.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/left_profile.asp" -->
  <!-- #include virtual="/_include/menu_customer.asp" -->
       
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
