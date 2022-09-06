<!-- #include virtual="/_include/connect.inc" -->
<% 
member_alias = Request.Form("mnick") 

strSQL = "p_sm_member_nickcheck  '" & member_alias & "'" 
Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 


If not rsData.EOF Then 
result_no = rsData("result_no") 
result_desc = rsData("result_desc") 
End If 
rsData.Close 
Set rsData = nothing 
if cCur(result_no)=1 then 
%>
<script>alert("<%=result_desc %>");</script>
<% 
response.end 
else 
%>
<script>$("#nickchkspan").text("<%=result_desc %>");</script>
<% 
response.end 
end if 
%> 
<!-- #include virtual="/_include/connect_close.inc" -->