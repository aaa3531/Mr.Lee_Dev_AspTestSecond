
<% Response.CharSet = "UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<title>항하사증권입니다.</title>
<link rel="stylesheet" type="text/css" href="/_css/sub.css">
</head>
<script>
    function windowclose(){
        window.close();
        }
</script>
<onLoad="javascript:open_win();">
<body>

<div id="wrap" class="popupwrap">
	<!-- header -->
	<div id="header">
	</div>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<!-- content -->
		<div id="content">

        <div class="bx_idsearch">
			

			<div class="bx_type msg_type">
				<p class="msg_title"><span class="span_green"><%=request("charge_amt") %>원</span> 충전하시겠습니까?</p>
				<p class="msg_date">
                <%=now() %>
				</p>
			
            <form action="charge_insert.asp" id="form2" name="formTool" method="post">
            <input type="hidden" name="charge_amt" value="<%=request("charge_amt") %>" ID="Hidden3"> 	
            <input type="hidden" name="charge_name" value="<%=request("charge_name") %>" ID="Hidden4"> 	
			<input type="submit" value="확인" class="btn_red">
			<input type="button" value="취소" class="btn_gray" onclick="windowclose()">
            </form>
			</div>
		</div>

		</div>
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->

</div>

</body>
</html>