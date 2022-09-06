<html>

    <head>

        <title> 흘러가는 글자 </title>

<script language='javascript'>

<!--




    var nbsp = 100;

    var cnt = nbsp;

    var pos = -1;

    var speed = 40;

    var delay = 3000;




    var ary = new Array();

    ary.push('<font color=#000000>[09-25 09:18] 흘러가는 글자 소스입니다. 도움이 되셨으면 합니다.</font>');

    ary.push('<font color=8fe4e3>[09-24 15:03] 전광판처럼 꾸며서 예쁘게 활용하시기 바랍니다.</font>');

    ary.push('<font color=f8a2a2>[09-24 14:44] 흐르는 항목 추가시는 ary를 추가하시면 됩니다.</font>');

    ary.push('<font color=a4de8c>[09-24 11:38] 소스를 복사해서 원하는 위치에 배치시키시면 됩니다.</font>');

    ary.push('<font color=dba7ef>[09-24 09:31] 감사합니다. 댓글 달아주는 센스!!</font>');




    window.onload = function () {

        fncInit();

    }




    function fncInit() {

        pos++;

        if (pos >= ary.length - 1) pos = 0;

        fncMoveText();

    }




    function fncMoveText() {

        var str = '';

        for (var i = 0; i < cnt; i++) {

            str += '&nbsp;';

        }




        document.getElementById('scrl').innerHTML = '<nobr>' + str + ary[pos] + '<nobr>';




        if (cnt == 0) {

            cnt = nbsp;

            setTimeout(fncInit, delay);

        }

        else {

            cnt--;

            setTimeout(fncMoveText, speed);

        }

    }




    //-->

</script>

    </head>

    <body>

<form name='frm'>




        <div style='border:solid 1px #000000; height:26px; width:450; overflow:hidden; background-color:#FFFF00; padding:5px; font-weight:bold; color:gray;' id='scrl'></div>




</form>

    </body>

</html>