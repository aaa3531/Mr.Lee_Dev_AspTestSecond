<!-- #include virtual="/_include/header_customer.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

   ' Private_info Detail 뿌리기
  strSQL = "p_sm_private_policy_view_detail  "

  'response.write strSQL
  'response.end

  Set rsDetailList = Server.CreateObject("ADODB.RecordSet")
    rsDetailList.Open strSQL, DbCon, 1, 1

  if rsDetailList.EOF or rsDetailList.BOF then
	NoDataDetailList = True
  Else
	NoDataDetailList = False
  end if 
  
%>

<!-- container -->
	<div id="container">
		<!-- content -->
	
		<div id="content" class="subcon">
			<div class="snb_title">
				<ul>
				<li class="snb_01">개인정보 취급방침<span>HOME > 고객센터 > 개인정보 취급방침</span></li>
				</ul>

			</div>
			<div class="agreement">
						<!-- 	<img src="img/img_top.gif" width="1000" height="60" alt="약관 및 정책" /> -->
							<div>
								<ul class="lst_agree">
    	                                <% if NoDataDetailList = False then ' 데이터가 있으면 데이터 출력 %>
                                        <% Do While Not rsDetailList.EOF   %>
                                           <div style="padding:10px 0 0 0;  font-size:14px; font-weight:bold;"><%=rsDetailList("order_seq") %>.&nbsp;<%=rsDetailList("section_desc") %></div>
                                           <div style="padding:15px 0 15px 0; border-bottom:dotted 1px;"><%=rsDetailList("detail_desc") %></div>
                                        <%                           
        	                                rsDetailList.MoveNext
	                                        Loop 
                                        %>
		                                <% else %>
                                        <div style="text-align:center; padding:10px;">
                                        개인정보 취급방침이 없습니다.
                                        </div>
                                        <% end if

       	                                set DetailList = nothing
                                        %> 
								</ul>
							</div>
							
			</div>


<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
