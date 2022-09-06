<!-- #include virtual="/_include/header_customer.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  if request("qna_no") <> "" then
  qna_no = request("qna_no")
  end if

  strSQL = "p_sh_qna_list "
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.cursorlocation = 3
  rsData.Open strSQL, DbCon, 1, 3
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  end if  

  
  '페이징처리관련
  page =Cint(request("page"))
  If NoData = False then
		Cus_pageSize = 20
		rsData.PageSize = Cus_pageSize

		pagecount=rsData.pagecount
		totalRecord = rsData.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsData.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsData.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 

%>



	<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="snb_title">
				<ul>
				<li class="snb_01">Q&A<span>HOME > 고객센터 > Q&A</span></li>
				</ul>

			</div>
			<!-- <div class="sub_tab">
				<ul>
					<li><a href="#" class="submnu_tab on">UP&amp;DOWN</a></li>
					<li><a href="#" class="submnu_tab">종목별매치</a></li>
					<li><a href="#" class="submnu_tab">종목별레이스</a></li>
				</ul>
			</div> -->
			
			<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
						<colgroup>
							<col width="63"></col>		
							<col width="810"></col>		
							<col width=""></col>		
						</colgroup>
							
						
						<thead>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
						</thead>
						<tbody>

    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       if FirstPage <> 1 then
       RowCount = rsData.PageSize
	   end If
       Do While Not rsData.EOF and RowCount > 0    %> 
							<tr>
								<td><%=rsData("qna_no") %></td>
								<td class="board_title"><a href="qna.asp?qna_no=<%=rsData("qna_no") %>"><%=rsData("qna_desc") %></a></td>
								<td><%=rsData("register_date") %></td>
							</tr>
    <% if rsData("qna_no") * 1 - qna_no = 0 then %>
							<tr class="ans" style="display: table-row;">
								<td></td>
								<td colspan="2" >
									<div class="ans_content"><p><%=rsData("qna_note") %></p></div>
								</td>
							</tr>
    <% end if %>
    <% 	
        RowCount = RowCount - 1
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr>
    <td  colspan="3">Q&A가 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>  		
						
						</tbody>
					</table>

			</div>

    <!-- 페이징 처리-->					
<%if NoData = false Then
	Cus_Tar = "peio_no=" & peio_no 
%>
<!--#include virtual="/_include/asp_page_function.asp"-->
			<div class="paging">
<%
	Response.Write ShowPageBar("qna.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
%>
			</div>
	<%end if%>		
	<!-- 페이징 처리 끝-->


<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
