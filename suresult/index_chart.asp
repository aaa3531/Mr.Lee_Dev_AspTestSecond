<!-- #include virtual="/_include/top_basic.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_sh_game_basket_updown_kospi_status '" & Session("member_no") & "'"  

  'response.write strSQL
  'response.End

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if NOT rsData.EOF and NOT rsData.BOF then
	game_no =  rsData("game_no")
    open_flag = rsData("open_flag")
    game_second = rsData("game_second")
  end if   

  set rsData = nothing
   
  '주가읽기

  strSQL = "p_sh_stock_index_updown_result_chart   'KOSPI'"

  ' response.write strSQL
  'response.end

  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.Open strSQL, DbCon, 1, 1
    
  if rsList.EOF or rsList.BOF then
	NoDataList = True
  Else
	NoDataList = False
  end if  
  'response.write strSQL
  'response.End  
    
%> 



<SCRIPT language="javascript">

  window.onload = function () {

      var chart = new CanvasJS.Chart("chartContainer",
        {
            backgroundColor: "#F5DEB3",
            title:{
                text: "",
                fontSize: 20
            },
            exportEnabled: true,
            axisY: {
                includeZero:false,
                title: "INDEX",
                prefix: "",
                titleFontSize: 18,
            },
            axisX: {
                interval:5,
                intervalType: "minute",
                valueFormatString: "hh:mm",
            },
            data: [
            {
                type: "candlestick",
                risingColor: "#FF0000",
                color: "#0000FF",
                dataPoints: [
            <% if NoDataList = False then %>
            <% 
               Do While Not rsList.EOF   
                 strData = "		{x: new Date(" & rsList("date_data") & "),y:[" & rsList("index_value") & ", " & rsList("index_high") & ", " & rsList("index_low") & ", " & rsList("index_last") & "]}"
    
               rsList.MoveNext       
               if Not rsList.EOF then
                  strData = strData & ", "
                  response.write strData & Chr(13) + Chr(10)
      else
                  response.write strData 
               end if
       
               Loop 
               end if  
         
            set rsList = nothing
            %> 
      ]
      }
]
});
chart.render();
  }
</SCRIPT>

<script type="text/javascript" src="/js/canvasjs.min.js"></script>

  
  <div style="margin:10px 0 5px 0;border:solid 0px #efefef;background-color:#ffffff; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
    <div id="chartContainer" style="width:100%;height:350px;background-color:#ffffff;border:solid 3px #ffffff;margin:0 8px 0 0;"></div>
  </div>

   
<!-- #include virtual="/_include/connect_close.inc" -->