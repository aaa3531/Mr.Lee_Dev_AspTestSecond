<html>
<head>
<title>
K-1 SECURITIES
</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script type="text/javascript">

    var xhr;
    function betItem() {
        xhr = new XMLHttpRequest();
        game_no = document.getElementById("gameno").value;
        bet_point = document.getElementById("betpoint").value;
        //alert(game_no);
        //alert(bet_point);
        xhr.onreadystatechange = betItemSet;
        xhr.open("Get", "item_bet.asp?game_no=" + game_no + "&bet_point=" + bet_point);
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
            alert(slipdata[0]);
            windowclose();
            opener.document.location.reload();
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
<body style="background-color:#3388cc;">

<div style="padding:15px 0 0 0; line-height:200%; text-align:center; font-weight:bold; width:300px; height:120px; color:#ffffff; font-family:맑은 고딕,Arial;">
<%=request("bet_point") %>원 베팅하시겠습니까?
  <form action="item_bet.asp" id="form1" name="formBet" method="post">
    <input type="hidden" id="betpoint" name="bet_point" value="<%=request("bet_point") %>" /> 	
    <input type="hidden" id="gameno" name="game_no" value="<%=request("game_no") %>" /> 	
  </form>
    <input id="submit2" name="submit1" type="button" value="확인" onclick="javascript: betItem();">
    <input type="button" value="닫기" onclick="javascript: windowclose();">
</div>

</body>
</html>
