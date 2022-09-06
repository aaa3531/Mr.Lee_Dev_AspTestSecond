<!-- #include virtual="/_include/connect3.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
  if request("member_no") <> "" then
     Session("member_no") = request("member_no")
   end if

  strSQL = "p_sh_stock_index_ladder_candle "
  'response.write strSQL
  'response.end

  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.Open strSQL, DbCon2, 1, 1
    
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
                  interval:20,
                  intervalType: "minute",
                  valueFormatString: "hh:mm",
              },
              data: [
              {
                  markerBorderColor : "#00856A",
                  type: "candlestick",
                  risingColor: "#FF6600",
                  color: "#3388CC",
                  dataPoints: [
              <% if NoDataList = False then %>
              <% 
                 Do While Not rsList.EOF   
                   strData = "		{x: new Date(" & rsList("date_data") & "),y:[" & rsList("index_start") & ", " & rsList("index_high") & ", " & rsList("index_low") & ", " & rsList("index_last") & "]}"
    
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


<% if Session("grade_cd") = "U" then %>

  
  <div style="margin:10px 0 5px 0;border:solid 0px #efefef;background-color:#ffffff; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;" oncontextmenu="return false">
    <div id="chartContainer" style="width:100%;height:350px;background-color:#ffffff;border:solid 3px #ffffff;margin:0 8px 0 0;"></div>
  </div>
  <% else %>
  
  <div style="height:150px;padding:150px 0 0 0;text-align:center;">
  B2B회원은 베팅할 수 없습니다.
  </div>  

<% end if %>
   
<!-- #include virtual="/_include/connect_close3.inc" -->
<!-- #include virtual="/_include/connect_close.inc" -->