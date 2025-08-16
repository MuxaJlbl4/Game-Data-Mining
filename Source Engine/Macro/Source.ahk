#Requires AutoHotkey v2.0

; Allowed app
#HotIf WinActive("ahk_exe hl2.exe")

; Admin check
if (!A_IsAdmin)
{
	MsgBox "Please, run this script as Administrator."
	ExitApp
}

; Controls
B_JMP := "Space"			; Jump
B_CRC := "Ctrl"				; Crouch
B_BKW := "S"				; Back
B_USE := "E"				; Use

; Accelerated Back Hopping
~X::
{
	Send "{" B_BKW " down}"
	Sleep 200
	
	Send "{" B_CRC " down}"
	Send "{" B_JMP " down}"
	Sleep 200
	
	Send "{" B_BKW " up}"
	Send "{" B_JMP " up}"
	
	while GetKeyState("X", "P")
	{
		Send "{" B_JMP " down}"
		Sleep 1
		
		Send "{" B_JMP " up}"
		Sleep 1
	}
	
	Send "{" B_CRC " up}"
}

; Object Wall Climbing
~C::
{
	Send "{" B_JMP " down}"
	Sleep 200
	
	Send "{" B_JMP " up}"
	
	while GetKeyState("C", "P")
	{
		Send "{" B_USE " down}"
		Send "{" B_JMP " down}"
		Sleep 10
		
		Send "{" B_USE " up}"
		Send "{" B_JMP " up}"
		Sleep 10
	}
}
