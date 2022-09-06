<!-- #include virtual="/_include/header_info.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<script type="text/javascript" src="/SmartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<SCRIPT language="javascript">

    function infoInsert() {
        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
        formEdit.submit();
    }

</SCRIPT>
<script>
fuction askSubmit()
{
  formAsk.submit();
}
fuction askCancel()
{
  history.go(-1);
}
</script>

	<!-- container -->
	<div id="container">
	
		<!-- content -->
		<div id="content" class="subcon">
		<div class="snb_title">
				<ul>
				<li class="snb_01">KOSPI 증권정보<span>HOME > 증권정보 > KOSPI증권정보</span></li>
				</ul>

			</div>
		<div class="snb_01_con">
			<div class="charge_title">
			<p>KOSPI 관련 증권정보를 올리는 게시판입니다.</p>
			<ul>
				<li><span class="emp">* 필수항목은 반드시 입력해 주시기 바랍니다.</span> </li>
			</ul>
			</div>
		</div>
		<!-- [s]입금내역 서식-->
    <form action="kospi_insert.asp" id="formEdit" name="formEdit" method="post">
    <input type="hidden" name="info_no" value="<%=info_no %>" ID="info_no"> 
    <input type="hidden" name="market_cd" value="<%=request("market_cd") %>" ID="Hidden2"> 
    <table width="100%"  bgcolor="#f2f2f2" border="0" cellpadding="0" cellspacing="0">
    <tr height="35" >
      <td width="100%" align="left"> 
      정보구분 <select name="info_type" required>
                 <option value="" selected>선택</option>
                 <option value="주식시황" >주식시황</option>
                 <option value="주식시세" >주식시세</option>
                 <option value="종목정보" >종목정보</option>
                 <option value="주식공부" >주식공부</option>
               </select>&nbsp;&nbsp;&nbsp;
           작성자
           <input type="text" name="author_name" style="width:15%;text-align:center;" class="input" ID="Text1" required value="<%=Session("member_alias") %>">
      </td>
      <td>

      </td>
    </tr>
    <tr height="35">
    <td width="90%" align=left>
    <input type="text" name="info_desc" style="width:100%;" class="input" ID="Text3" >
    </td>
    </tr>  
    
    <tr height="35">
    <td width="90%" align=left>
    <textarea name="info_note" id="ir1" style="width:100%;" rows="5" onkeyup="check_byte('info_note','char_count')" ></textarea>
    <script language="javascript"> check_byte('info_note', 'char_count'); </script>


    </td>
    </tr> 
  
    </table>
    </form>
		
<div style="margin:0 0 20px 0;width:100%;text-align:right;">
    <a href="kospi.asp">
    <input type="button"  value="목록">
    </a>
    <input id="submit1" name="submit1" type="submit" onclick="javascript: infoInsert();" value="저장">

</div>	
		<div>
		<!-- [e]입금내역 서식-->
			
		</div>
		

<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->

<script language="JavaScript">
<!--
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame(oEditors, "ir1", "/SmartEditor/SmartEditor2Skin.html", "createSEditorInIFrame");

    function frmChk(elClicked) {
        // 에디터의 내용을 에디터 생성시에 사용했던 textarea에 넣어 줍니다.
        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

        // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

        $("#frm")
                .attr({
                    action: "info_insert.asp",
                    target: "_self"
                })
    .submit();
    }

    function pasteHTML() {
        var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
        oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
        var sHTML = "<span style='color:#FF0000;'>정말입니까?<\/span><br>";
        oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
    }

    function showHTML() {
        var sHTML = oEditors.getById["ir1"].getIR();
        alert(sHTML);
    }

    function submitContents(elClickedObj) {
        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.

        // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

        try {
            elClickedObj.form.submit();
        } catch (e) { }
    }

    function setDefaultFont() {
        var sDefaultFont = '궁서';
        var nFontSize = 24;
        oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
    }

    //-->
</script>