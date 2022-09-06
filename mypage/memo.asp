<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        
  if request("memo_no") <> "" then
  memo_no = request("memo_no")
  end if

  strSQL = "p_sh_memo_list '" & session("member_no") & "','" & memo_no & "' "
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
    session("memo_cnt") = rsData("memo_cnt")
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
            xhr.open("Get", "memo_delete.asp?memo_no=" + memono);
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
				<li class="snb_01">받은쪽지함<span>받은 쪽지를 확인할 수 있습니다.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">

		</div>
			
				<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
					
						<caption>쪽지 내역</caption>
							<col width="50">
							<col width="160">
							<col width="*">
							<col width="120 ">
							<col width="120">


						   <thead>
								<tr>
									<th><input id="checkboxbtn" type="checkbox" onclick="javascript:checkPredict();" /></th>
									<th>보낸사람</th>
									<th>내용</th>
									<th>받은날짜</th>
									<th>상태</th>
								</tr>
						   </thead>
						 
						 <tbody>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
								<tr>
									<td><input type="checkbox" name="memochecked" memono="<%=rsData("memo_no") %>" /></td>
									<td>항하사증권</td>
									<td><a href="memo.asp?memo_no=<%=rsData("memo_no") %>"><%=rsData("memo_desc") %></a></td>
									<td><%=rsData("status_desc") %></td>
                                    <td><%=rsData("register_date") %></td>									
									<!-- <td colspan="6">받은 쪽지가 없습니다.</td> -->
								</tr>

    <% if rsData("memo_no") * 1 - memo_no = 0 then %>
								<tr>
									<td colspan="5" style="word-break:break-all; white-space:normal; line-height:30px;"><%=rsData("memo_note") %></td>
    </tr>
    <% end if %>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="5">메모가 없습니다.</td>
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
