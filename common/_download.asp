<%
	pach = Server.MapPath(Request("pach"))
    file = Request("file")
    '���� �̸�

    Response.ContentType = "application/x-msdownload"
    Response.AddHeader "Content-Disposition","attachment; filename=" & file 
    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    objStream.Type = 1
	objStream.LoadFromFile pach &"\"&  file
    download = objStream.Read
    Response.BinaryWrite download 

    Set objstream = nothing 
%>
