<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%   

    strSQL = "p_sh_game_ladder_bet '" & Session("member_no") & "','" & _
                                        replace(request("bet_point"),",","") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    result_no = rsData("result_no")
    result_desc = rsData("result_desc")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    response.write result_desc
    'Response.redirect "kospi.asp?result_desc="& result_desc &"&result_no="& result_no
  
%>
<!-- #include virtual="/_include/connect_close.inc"-->
 