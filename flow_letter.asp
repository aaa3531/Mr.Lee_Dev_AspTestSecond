<html>

    <head>

        <title> �귯���� ���� </title>

<script language='javascript'>

<!--




    var nbsp = 100;

    var cnt = nbsp;

    var pos = -1;

    var speed = 40;

    var delay = 3000;




    var ary = new Array();

    ary.push('<font color=#000000>[09-25 09:18] �귯���� ���� �ҽ��Դϴ�. ������ �Ǽ����� �մϴ�.</font>');

    ary.push('<font color=8fe4e3>[09-24 15:03] ������ó�� �ٸ缭 ���ڰ� Ȱ���Ͻñ� �ٶ��ϴ�.</font>');

    ary.push('<font color=f8a2a2>[09-24 14:44] �帣�� �׸� �߰��ô� ary�� �߰��Ͻø� �˴ϴ�.</font>');

    ary.push('<font color=a4de8c>[09-24 11:38] �ҽ��� �����ؼ� ���ϴ� ��ġ�� ��ġ��Ű�ø� �˴ϴ�.</font>');

    ary.push('<font color=dba7ef>[09-24 09:31] �����մϴ�. ��� �޾��ִ� ����!!</font>');




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