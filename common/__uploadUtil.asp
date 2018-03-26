<%
dim resizeWidth, resizeHeight ' 이미지 리사이즈를 위해 전역변수 설정
' ========================================================================
' Function명 : DextFileUpload
' 목      적 : 임시 ABC 업로더로 교체
' 입      력 : 
' ========================================================================
Function DextFileUpload(ByVal ControlName,ByVal sFolderName,ByVal s_w)

	'set objImage = Server.CreateObject("DEXT.ImageProc") '//-- 이미지 리사이즈를 위해 필요한 객체
	
	Dim NowYear			: NowYear		= Year(Date())
	Dim NowMonth		: NowMonth		= Month(Date())
	Dim NowDay			: NowDay		= Day(Date())
	Dim NowHour			: NowHour		= Hour(Time())
	Dim NowMinute		: NowMinute		= Minute(Time())
	Dim NowSecond		: NowSecond		= Second(Time())
	Dim NowRandomStr	: NowRandomStr	= RandomNumber(5,"")

	Dim NewFileName		: NewFileName = NowRandomStr & NowYear & NowMonth & NowDay & NowHour & NowMinute & NowSecond
	Dim sNewFileName    : sNewFileName = "s_" & NewFileName
	
	Dim f,i
	Dim arrFileName,strFilePath_new

	' 이미지 기본 가로 사이즈 650
	Dim s_width  : s_width = 300

	If s_w > 0 Then 
		s_width = s_w
	End If
	
	Set f = UPLOAD__FORM(ControlName)(1)
	if getfile.FileExists then
		Dim file_ext : file_ext = mid(f.RawFileName, InStrRev(f.RawFileName, ".") + 1)	'파일명에서 확장자만 분리
		'새이름 중복검사
		strFilePath_new = chkFileDup(sFolderName, NewFileName & "." & file_ext )
		'원본 저장
		f.Save strFilePath_new

		arrFileName=Right(strFilePath_new, len(strFilePath_new) - instrRev(strFilePath_new, "/"))

	Else
		arrFileName=""
	End If
	DextFileUpload=arrFileName

	'set objImage = Nothing ''객체소멸
	if err <> 0 then
		alert("에러발생")
	end if
End Function

' ==================================================================
' Function명 : 중복된 파일명 처리
' 목      적 : 중복된 파일명이 있는지 검사해서 다른이름으로 대체
' 입      력 : FileNameWithoutExt(확장자를 제외한 파일명), FileExt(확장자)
' 리  턴  값 : chkFileDup(파일경로를 포함한 파일명)
' ===================================================================
Function chkFileDup(sFolderName,sFileName)
	Dim strFilePath,f_exist, count
	Dim file_ext, file_name_without_ext
	Dim FSO : Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	f_exist = true
	count = 0
	
	strFilePath=sFolderName & sFileName
	file_ext = mid(sFileName, InStrRev(sFileName, ".") + 1)				'파일명에서 확장자만 분리
	file_name_without_ext = mid(sFileName, 1, InStrRev(sFileName,".")-1)'파일명에서 이름만 분리
	
	Do while f_exist
		If(fso.fileExists(strFilePath)) Then
			sFileName = file_name_without_ext & "(" & count & ")." & file_ext
			strFilePath = sFolderName & sFileName
			count = count + 1
		Else
			f_exist = false
		End If
	Loop

	chkFileDup = strFilePath
End Function
'랜덤
Function RandomNumber(NumberLength,NumberString)
	Const DefaultString = "ABCDEFGHIJKLMNOPQRSTUVXYZ1234567890"
	Dim nCount,RanNum,nNumber,nLength

	Randomize
	If NumberString = "" Then 
		NumberString = DefaultString
	End If

	nLength = Len(NumberString)

	For nCount = 1 To NumberLength
	nNumber = Int((nLength * Rnd)+1)
	RanNum = RanNum & Mid(NumberString,nNumber,1)
	Next

	RandomNumber = RanNum
End Function

Sub get_ImgResizeValue(ByVal ImageWidth,ByVal ImageHeight, ByVal fixWidth ) 
	If ImageWidth > fixWidth then
		resizeWidth = fixWidth
		resizeHeight = ImageHeight * fixWidth / ImageWidth
	Else
		resizeWidth  = ImageWidth
		resizeHeight = ImageHeight
	End If
End Sub
%>