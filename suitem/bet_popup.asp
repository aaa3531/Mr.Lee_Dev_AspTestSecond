<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<title>항하사증권입니다.</title>
<link rel="stylesheet" type="text/css" href="/_css/sub.css">
</head>

<script type="text/javascript">

    var xhr;
    function betItem() {
        xhr = new XMLHttpRequest();
        game_no = document.getElementById("gameno").value;
        bet_point = document.getElementById("betpoint").value;
        //alert(game_no);
        //alert(bet_point);
        xhr.onreadystatechange = betItemSet;
        xhr.open("POST", "item_bet.asp?game_no=" + game_no + "&bet_point=" + bet_point);
        xhr.send(null);
        //fFrameReload();
    }

    function betItemSet() {
        //alert(xhr.readyState);
        if (xhr.readyState == 4) {
            //status_no1 = elem.getAttribute("name3");
            //alert(status_no1);
            var data = xhr.responseText;
            var slipdata = data.split(',');
            //alert(slipdata[0]);
            windowclose();
            opener.betReload();
            //document.getElementById("companyname1").innerHTML = slipdata[0];
        }
    }



    function windowclose() {
        window.close();
    }
    function betSubmit() {
        formBet.submit();
        self.close();
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

		<!-- S : 아이디찾기 팝업창 -->

        <div class="bx_idsearch">
			

			<div class="bx_type msg_type">
				<p class="msg_title"><span class="span_green"><%=request("bet_point") %></span>원 베팅하시겠습니까?</p>
				<p class="msg_date">
                <%=now() %>
				</p>
			<form action="item_bet.asp" id="form1" name="formBet" method="post">
                    <input type="hidden" id="betpoint" name="bet_point" value="<%=request("bet_point") %>" /> 	
                    <input type="hidden" id="gameno" name="game_no" value="<%=request("game_no") %>" /> 	
                  </form>

			<input type="button" value="확인" class="btn_red" onclick="javascript: betItem();">
			<input type="button" value="취소" class="btn_gray" onclick="javascript: windowclose();">
			</div>
		</div>

		<!-- E : 아이디찾기 팝업창 -->		
		
			
			
		</div>
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->

</div>

</body>
</html>