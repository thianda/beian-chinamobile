
'WScript.Sleep 60*1000
'msgbox(year(Now)&"-"&Month(Now)&"-"&day(Now)&" "&Hour(Now)&":"&Minute(Now)&":"&Second(Now))
msgbox(Wscript.ScriptFullName& vbCrLf & "1")
WScript.Quit
call main
sub main()
	Set WshShell = WScript.CreateObject("WScript.Shell")
	Set oExec = WshShell.Exec("ipconfig.exe /all")
	Set oStdOut = oExec.StdOut
	Do Until oStdOut.AtEndOfStream
		strLine = oStdOut.ReadLine
		If InStr(strLine, "oa") > 0 Then
			'If oStdOut.AtEndOfStream<>Ture Then
			For counter = 1 To 12
				strLine = oStdOut.ReadLine
				If InStr(strLine, "DHCP") > 0 Then
					dhcp = Mid(strLine, InStr(strLine, ":") + 2)
					If dhcp = "��" Then
						MsgBox("��ǰ����DHCP�Զ���ȡ���޷�ִ��!")
						currPath = createobject("Scripting.FileSystemObject").GetFolder(".").Path
						MsgBox("���ű�����·����" & vbCrLf & currPath & vbCrLf & "�����Զ���")
						WshShell.Exec("explorer /select " & Wscript.ScriptFullName)
						WScript.Quit
					End If
				End If
			Next
			getway = Mid(strLine, InStr(strLine, ":") + 2)
			MsgBox("��ǰ�������أ�"&getway)
				'strLine = oStdOut.ReadLine
				'If InStr(strLine, "IPv4") > 0 Then
				'If InStr(strLine, "Ĭ������") > 0 Then
				'	getway = Mid(strLine, InStr(strLine, ":") + 2)
				'	Exit For
				'End If
			'End If
		End If
		'Exit Do
	loop

	If getway = "" Then
		MsgBox("��������Ϊ�գ�����")
		Exit sub
	Else
		WshShell.Exec("route delete 0.0.0.0 mask 0.0.0.0 10.61.214.1")
		MsgBox("�������أ�"&getway&"������ɾ��")
	End If
	WScript.Sleep 5*1000
	call main
End sub

sub main2()
	Set WshShell = WScript.CreateObject("WScript.Shell")
	Set oExec = WshShell.Exec("route.exe print -4")
	Set oStdOut = oExec.StdOut
	str = ""
	Do Until oStdOut.AtEndOfStream
		strLine = oStdOut.ReadLine
		If InStr(strLine, "0.0.0.0") > 0 Then
			str = str & vbCrLf & strLine
		End If
	Loop
	msgbox str
End sub
