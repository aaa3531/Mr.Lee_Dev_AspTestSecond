<!-- #include virtual="/_include/connect.inc" -->
<% 
member_id = Request.Form("mid") 
if member_id="" then 
%>
<script>alert("아이디를 입력하여 주시기 바랍니다.");</script>
<% 
response.end 
end if 

strSQL = "p_sm_member_idcheck  '" & member_id & "'" 
Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 


Cnt = 0 
If not rsData.EOF Then 
Cnt = rsData("id_cnt") 
End If 
rsData.Close 
Set rsData = nothing 
if cCur(Cnt)<>0 then 
%>
<script>alert("존재하는 아이디입니다.");</script>
<% 
response.end 
else 
%>
<script>$("#idchkspan").text("이용가능한 ID");</script>
<% 
response.end 
end if 
%> 
<!-- #include virtual="/_include/connect_close.inc" -->