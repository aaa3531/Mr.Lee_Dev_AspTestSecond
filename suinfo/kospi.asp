<!-- #include virtual="/_include/header_info.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

   strSQL = "p_sh_info_author_check '" & session("member_no") & "'"

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if NOT rsData.EOF and NOT rsData.BOF then
	count = rsData("count")
  end if  
  Set rsData = nothing


  if request("info_no") <> "" then
     info_no = request("info_no")
  end if  
  
   ' terms Detail 뿌리기
  strSQL = "p_sh_info_user_kospi_list  "

  'response.write strSQL
  'response.end

  Set rsInfo = Server.CreateObject("ADODB.RecordSet")
    rsInfo.Open strSQL, DbCon, 1, 1

  if rsInfo.EOF or rsInfo.BOF then
	NoDataInfo = True
  Else
	NoDataInfo = False
  end if 
  
%>

<SCRIPT language="javascript">

    function infoCounter(ele){
 
    var infono = ele.getAttribute("infono");   
            xhr = new XMLHttpRequest();
            xhr.open("Get", "info_counter.asp?info_no=" + infono);
            xhr.send(null);
    }  
        
</SCRIPT> 

	<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="snb_title">
				<ul>
				<li class="snb_01">KOSPI 증권정보<span>HOME > 증권정보 > KOSPI증권정보</span></li>
				</ul>

			</div>
            <% if count > "0" then %>
            <a href="kospi_scr.asp?market_cd=KOSPI" class="btn_red">정보등록</a>
            <% end if %>
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
							<col width="710"></col>		
							<col width="*"></col>		
							<col width="80"></col>		
						</colgroup>
							
						
						<thead>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회수</th>
						</thead>
						<tbody>
						
    <% if NoDataInfo = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsInfo.EOF    %> 

							<tr>
								<td><%=rsInfo("serial_no") %></td>
								<td class="board_title">[<%=rsInfo("info_type") %>] <a href="kospi.asp?info_no=<%=rsInfo("info_no") %>"><span onclick="javascript:infoCounter(this);" infono="<%=rsInfo("info_no") %>"><%=rsInfo("info_desc") %></span></a></td>
								<td><%=mid(rsInfo("register_date"),1,10) %></td>
								<td><%=rsInfo("info_cnt") %></td>								
							</tr>
							<% if rsInfo("info_no") * 1 - info_no = 0 then  %>
							<tr class="ans" style="display: table-row;">
								<td>내용</td>
								<td colspan="2" >
									<div class="ans_content"><p><%=rsInfo("info_note") %></p></div>
								</td>
								<td></td>								
							</tr>
							<% end if %>

    <% 	
        rsInfo.MoveNext
	    Loop 
    %>
	<% else %>
	<tr>
	<td colspan="10">증권정보가 없습니다.</td>
	</tr>
    <% end if         
    set rsInfo = nothing
    %>        
						
						
						</tbody>
					</table>

			</div>
			
			<div class="paging">
						<a href="#" class=""><span>&lt;&lt;</span></a> <a href="#" class=""><span>&lt;</span></a> <a href="#" class="current"><span>1</span></a> <a href="#" class=""><span>&gt;</span></a> <a href="#" class=""><span>&gt;&gt;</span></a>
			</div>
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
