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
    function betLadder() {
        xhr = new XMLHttpRequest();
        game_no = document.getElementById("gameno").value;
        bet_point = document.getElementById("betpoint").value;
        //alert(game_no);
        //alert(bet_point);
        xhr.onreadystatechange = betLadderSet;
        xhr.open("POST", "ladder_bet.asp?game_no=" + game_no + "&bet_point=" + bet_point);
        xhr.send(null);
        //fFrameReload();
    }

    function betLadderSet() {
        //alert(xhr.readyState);
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');
            windowclose();
            opener.betReload();
        }
    }



    function windowclose() {
        window.close();
    }
</script>
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
        
		<!-- S : 베팅확인 팝업창 -->
		<div class="bx_idsearch">
			
            
  <form action="ladder_bet.asp" id="form1" name="formBet" method="post">
    <input type="hidden" id="betpoint" name="bet_point" value="<%=request("bet_point") %>" /> 	
    <input type="hidden" id="gameno" name="game_no" value="<%=request("game_no") %>" /> 
  </form>
			<div class="bx_type msg_type">
				<p class="msg_title">
                '<%=request("ladderdesc") %>'&nbsp;에&nbsp;<span class="span_green"><%=request("bet_point") %>원</span> 을 베팅하시겠습니까?</p>
				<p class="msg_date">
                <%=now() %>
				</p>
			
			<input type="button" value="확인" class="btn_red"  onclick="javascript: betLadder();">
			<input type="button" value="취소" class="btn_gray"  onclick="javascript: windowclose();">
			</div>
		</div>
		<!-- E : 베팅확인 팝업창 -->	
        </div>
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->


</body>
</html>
