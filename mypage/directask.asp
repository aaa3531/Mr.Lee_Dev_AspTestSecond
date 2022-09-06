<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  if request("memo_no") <> "" then
  memo_no = request("memo_no")
  end if
  
  strSQL = "p_sh_memo_directask_list '" & session("member_no") & "'"
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  

%>
<SCRIPT language="javascript">

    function checkPredict(){
    //alert("000");
    var checkbox = document.getElementById("checkboxbtn");
    var myNodelist = document.getElementsByName("memochecked");
    if (checkbox.checked == true) 
      {
      for (i = 0; i <	myNodelist.length; i++) 
      {
        myNodelist[i].checked=true;     
      }
      }
    else 
      for (i = 0; i <	myNodelist.length; i++) 
      {
        myNodelist[i].checked=false;     
      }
    }

    function deleteMemo(){

    var	myNodelist = document.getElementsByName("memochecked");

    var i;
    for (i = 0; i <	myNodelist.length; i++) 
    {
    var memono = myNodelist[i].getAttribute("memono");   

    if (myNodelist[i].checked == true) {  
            xhr = new XMLHttpRequest();
            xhr.open("Get", "directask_delete.asp?memo_no=" + memono);
            xhr.send(null);
    }
    }
    document.location.reload();
    }  
        
</SCRIPT> 

	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">1:1 문의<span>1:1 문의 게시판입니다. </span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>사이트, 게임과 기타관련 고객님의 문의와 답변을 해드리는 게시판입니다.</p>
			</div>
		</div>
		<a href="directask_scr.asp" class="btn_red">1:1 문의하기</a>

	
				<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
						<caption>1:1문의 게시판</caption>
							<col width="40">
							<col width="60">
							<col width="140">
							<col width="* ">
							<col width="110">
							<col width="70">
							<col width="90">

						   <thead>
								<tr>
									<th><input id="checkboxbtn" type="checkbox" onclick="javascript:checkPredict();" /></th>
									<th>번호</th>
									<th>제목</th>
									<th>내용</th>
									<th>작성일</th>
									<th>처리상태</th>
								</tr>
						   </thead>
						 
						 <tbody>

    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
                                <% if rsData("reply_flag") <> "1" then %>
								<tr>
									<td><input type="checkbox" name="memochecked" memono="<%=rsData("memo_no") %>" /></td>
									<td><%=rsData("memo_no") %></td>
									<td><%=rsData("memo_desc") %></td>
									<td style="word-break:break-all; white-space:normal;"><%=rsData("memo_note") %></td>
									<td><%=mid(rsData("register_date"),1,10) %></td>
									<td><%=rsData("admin_check_desc") %></td>
									<!-- <td colspan="6">등록된 글이 없습니다.</td> -->
								</tr>
                                <% else %>
								<tr>
									<td><input type="checkbox" name="memochecked" memono="<%=rsData("memo_no") %>" /></td>
									<td><span style="color:#FF6600; font-weight:bold;">┗</span></td>
									<td><%=rsData("memo_desc") %></td>
									<td><%=rsData("memo_note") %></td>
									<td><%=mid(rsData("register_date"),1,10) %></td>
									<td></td>
									<!-- <td colspan="6">등록된 글이 없습니다.</td> -->
								</tr>
                                <% end if %>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td colspan="5">등록된 글이 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %> 

								
						   </tbody>
					</table>
					<input type="button" class="btn_red" onclick="javascript:deleteMemo();" style="border:solid 0px #ffffff;cursor:pointer;" value="선택삭제" />
				</div>
	

			
		</div>
		
	</div>
	
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
