<!-- #include virtual="/_include/header_mypage.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%        

' member 읽기
  strSQL = "p_sh_point_inout_list '" & session("member_no") & "'"

  'bRtn = dbcon.GetResult(strSQL, rsMember)
  'response.write strSQL

  ' 페이지 작동되는 방식
  Set rsPoint = Server.CreateObject("ADODB.RecordSet")
  rsPoint.Open strSQL, DbCon, 1, 1

  if rsPoint.EOF or rsPoint.BOF then
	NoDataPoint = True
  Else
	NoDataPoint = False
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
        var ledgerno = myNodelist[i].getAttribute("ledgerno");
        var inout_code = myNodelist[i].getAttribute("inout_code");

    if (myNodelist[i].checked == true) {  
    //alert(memono);
            xhr = new XMLHttpRequest();
            xhr.open("Get", "point_delete.asp?ledger_no=" + ledgerno + "&inout_code=" + inout_code);
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
				<li class="snb_01">입/출금 조회<span>고객님의 입/출금 조회 내역입니다.</span></li>
				</ul>

			</div>
		<div class="snb_01_con">

		</div>
				<div class="snb_01_board" >

					<table width="1000" border="0" cellpadding="0" cellspacing="0" class="tbl_board" >
						<caption>입출금조회 내역</caption>
							<col width="50">
							<col width="160">
							<col width="*">
							<col width="135 ">
							<col width="135">
						   <thead>
								<tr>
									<th><input id="checkboxbtn" type="checkbox" onclick="javascript:checkPredict();" /></th>
									<th>거래내용</th>
									<th>거래일시</th>
									<th>금액</th>
									<th>처리결과</th>
								</tr>
						   </thead>
						 
						 <tbody>
								
    <% if NoDataPoint = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsPoint.EOF    %> 
								<tr>
									<td><input type="checkbox" name="memochecked" ledgerno="<%=rsPoint("ledger_no") %>" inout_code="<%=rsPoint("inout_code") %>" /></td>
									<td><%=rsPoint("inout_desc") %></td>
									<td><%=rsPoint("register_date") %></td>
									<td><%=rsPoint("point_amt") %></td>
									<td><%=mid(rsPoint("ledger_desc"),1,4) %></td>
								</tr>

    <% 	
        rsPoint.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td colspan="6">입출금 거래 내역이 없습니다.</td>
    </tr>
    <% end if         
    set rsPoint = nothing
    %>  
								
						   </tbody>
					</table>
					<input type="button" class="btn_red" onclick="javascript:deleteMemo();" style="border:solid 0px #ffffff;cursor:pointer;" value="선택삭제" />
				</div>
	

			
		</div>
		
	</div>
	
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
