<%
function setCodeOption(optionKey , htmlType , value , selecter )
	Dim arrList  , html , setValue , checked
	Dim cntList  : cntList  = -1

	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "M_COMM_CODE2_P"
		.Parameters("@actType").value  = "VIEW"
		.Parameters("@PIdx").value      = optionKey
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing

	for iLoop = 0 to cntList
		checked = ""
		If value = 0 Then 
			setValue = arrList(FI_idx, iLoop)
		Else
			setValue = arrList(FI_name, iLoop)
		End If
		
		If htmlType = "select" Then 
			If setValue = selecter Then
				checked = "selected"
			End If
			html = html & "<option value=""" & setValue & """ "&checked&">" & arrList(FI_name, iLoop) & "</option>"
		ElseIf htmlType = "checkbox" Then 
			If setValue = selecter Then
				checked = "checked"
			End If
			html = html & "<input type=""checkbox"" name=""" & optionKey & """ value=""" & setValue & """ "&checked&"> " & arrList(FI_name, iLoop)
		ElseIf htmlType = "radio" Then 
			If setValue = selecter Then
				checked = "selected"
			End If
			html = html & "<input type=""radio"" name=""" & optionKey & """ value=""" & setValue & """ "&checked&"> " & arrList(FI_name, iLoop)
		End If
	Next

	setCodeOption = html	
End Function



function sendSmsEmail( actType , userId , userEmail , contants , attachPath )
	Dim strFile,strTitle

	If actType = "join" Then 
		'server.mapPath("/common/mailform/join.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\join.html"
		strTitle = "[길산파이프 고객센터] 회원가입이 완료되었습니다."
	ElseIf actType = "id_search" Then 
		'strFile = server.mapPath("/common/mailform/id_search.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\id_search.html"
		strTitle = "[길산파이프 고객센터] 요청하신 아이디를 알려드립니다."
	ElseIf actType = "pwd_search" Then 
		'strFile = server.mapPath("/common/mailform/pwd_search.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\pwd_search.html"
		strTitle = "[길산파이프 고객센터] 요청하신 비밀번호를 알려드립니다."
	ElseIf actType = "pwd_change" Then 
		'strFile = server.mapPath("/common/mailform/pwd_change.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\pwd_change.html"
		strTitle = "[길산파이프 고객센터] 고객님의 비밀번호가 변경되었습니다."
	ElseIf actType = "email" Then 
		'strFile = server.mapPath("/common/mailform/mail_change.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\mail_change.html"
		strTitle = "[길산파이프 고객센터] 고객님의 이메일이 변경되었습니다."
	ElseIf actType = "secede" Then 
		'strFile = server.mapPath("/common/mailform/secede.html")
		strFile = "D:\web\www.gilsan.co.kr\common\mailform\secede.html"
		strTitle = "[길산파이프 고객센터] 회원 탈퇴가 성공적으로 이루어졌습니다."
	End If

	Dim mfrom		: mfrom		= "길산파이프<no-reply@gilsan.co.kr>"
	Dim mto			: mto		= userEmail
	Dim mtitle		: mtitle	= strTitle
	Dim mcontents	: mcontents	= ReadFile(strFile)
		
	mcontents = replace(mcontents, "#ID#"      , userId )
	mcontents = replace(mcontents, "#EMAIL#"   , userEmail )
	mcontents = replace(mcontents, "#CONTANTS#", contants )

	Dim mailMessage : mailMessage = MailSend(mtitle, mcontents, mto, mfrom, attachPath)
	sendSmsEmail = mailMessage	
End function
'** ---------------------------------------------------------------------------
' 함 수 명 : MailSend(strSubject, strBody, strTo, strFrom)
' 인    자 : 1. strSubject	: 메일 제목
'            2. strBody		: 메일 내용
'            3. strTo		: 받는 사람 메일 주소
'            4. strFrom		: 보내는 사람 메일 주소
' 목    적 : 메일 발송
'** ---------------------------------------------------------------------------
function MailSend(strSubject, strBody, strTo, strFrom, attachPath)
	dim result
	Dim objConfig, objSendMail, Flds

	on error resume Next
	
	Const cdoSendUsingMethod		= "http://schemas.microsoft.com/cdo/configuration/sendusing" 
	Const cdoSendUsingPort			= 2 
	Const cdoSMTPServer				= "http://schemas.microsoft.com/cdo/configuration/smtpserver" 
	Const cdoSMTPServerPort			= "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
	Const cdoSMTPConnectionTimeout	= "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
	Const cdoSMTPAccountName		= "http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
	Const cdoSMTPAuthenticate		= "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
	Const cdoBasic					= 1 
	Const cdoSendUserName			= "http://schemas.microsoft.com/cdo/configuration/sendusername" 
	Const cdoSendPassword			= "http://schemas.microsoft.com/cdo/configuration/sendpassword" 

	' SMTP Configuration 
	set objConfig = createobject("CDO.Configuration") 
	Set Flds = objConfig.Fields 
	With Flds 
		.Item(cdoSendUsingMethod) = cdoSendUsingPort 
		.Item(cdoSMTPServer) = "mailsw.gilsan.co.kr" 
		.Item(cdoSMTPServerPort) = 25
		.Item(cdoSMTPAuthenticate) = cdoBasic 
		'.Item(cdoSendUserName) = "cbt1489@cbt1489.ithelper.kr"
		'.Item(cdoSendPassword) = "cbt148963"
		.Update
	End With 
	
	Set objSendMail = Server.CreateObject("CDO.Message")
	With objSendMail 
		.BodyPart.Charset = "ks_c_5601-1987" 
		.Configuration = objConfig 
		'.MimeFormatted = false 
		.From		= strFrom
		.To			= strTo
		.Subject	= strSubject
		.HTMLBody	= strBody
		if LEN(attachPath)>0 then
			.AddAttachment attachPath
		end if
		.fields.update 
		.Send
	End With

	Set objSendMail = Nothing

	if err.number <> 0 then
		result = replace(replace(replace(err.description,vbCrLf,""),vbCr,""),vbLf,"")
	else
		result = "ok"
	end if

	MailSend = result
end function


'** ---------------------------------------------------------------------------
' 함 수 명 : ReadFile(strFileName)
' 인  자 : 1. strFileName : 파일명
' 목    적 : 파일 읽기
'** ---------------------------------------------------------------------------
function ReadFile(strFileName)
	Dim objStream
	Set objStream = CreateObject("ADODB.Stream")
	objStream.CharSet = "utf-8"
	objStream.Open
	objStream.LoadFromFile(strFileName)
	ReadFile = objStream.ReadText()
end Function


'------------------------------------------------------------------------------------
' 페이징
'------------------------------------------------------------------------------------
Function printPageList(pTotCount, pPageNo, pRows, url)
	if pTotCount = 0 then 
		printPageList = "<a class=""on"">1</a>"	: Exit Function
	end if
	
	' 하단에 보여줄 페이지 건수...
	Dim tPrintCount, tPageCount, tCurRange, tCount, tPageNo
	Dim tmpStr
	
	tPrintCount = 10
	tPageCount = Fix((pTotCount + (pRows-1)) / pRows)
	tCurRange  = FIX((pPageNo-1) / tPrintCount)* tPrintCount

	tCount = 1
	tPageNo = 0
	
	' 두단계 앞으로....
	tmpStr = ""
	if ( tCurRange > 0) then
		tmpStr = tmpStr & ""
	else
		tmpStr = tmpStr & ""
	end if
	
	' 한단계 앞으로....
	if ( tCurRange > 0) then
		tmpStr = tmpStr & "<a href=""" & replace(url,"__PAGE__",(tCurRange-tPrintCount+1)) & """ class=""prev""><span class=""blind"">이전</span></a>"
	else
		tmpStr = tmpStr & "<a class=""prev_off""><span class=""blind"">이전</span></a>"
	end if

	while (tCount <= tPrintCount AND (tCurRange+tCount) <= tPageCount )
		tPageNo = tCurRange+tCount

		if (tPageNo = pPageNo)	then
			tmpStr = tmpStr & "<a class=""on"">" & tPageNo & "</a>"
		else
			tmpStr = tmpStr & "<a href='" & replace(url,"__PAGE__",tPageNo) & "'>" & tPageNo & "</a>"
		end if
		
		tCount = tCount + 1
	wend
	
	' 한단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & "<a href=""" & replace(url,"__PAGE__",(tCurRange+tPrintCount+1)) & """ class=""next""><span class=""blind"">다음</span></a>"
	else
		tmpStr = tmpStr & "<a class=""next_off""><span class=""blind"">다음</span></a>"
	end if
	
	' 두단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & ""
	else
		tmpStr = tmpStr & ""
	end if
	
	printPageList = tmpStr
	
End Function
%>