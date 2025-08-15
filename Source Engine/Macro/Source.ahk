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

; Delays
D_HUN := 100
D_TEN := 10
D_ONE := 1


; Accelerated Back Hopping
~Down::
{
	Send "{" B_BKW " down}"
	Sleep D_HUN
	Send "{" B_CRC " down}"
	Send "{" B_JMP " down}"
	Sleep D_HUN
	
	Send "{" B_BKW " up}"
	Send "{" B_JMP " up}"
	
	while GetKeyState("Down", "P")
	{
		Send "{" B_JMP " down}"
		Sleep D_ONE
		Send "{" B_JMP " up}"
		Sleep D_ONE
	}
	
	Send "{" B_CRC " up}"
}

; Object Wall Climbing
~Up::
{
	Send "{" B_JMP " down}"
	Sleep D_HUN
	
	Send "{" B_JMP " up}"
	
	while GetKeyState("Up", "P")
	{
		Send "{" B_USE " down}"
		Send "{" B_JMP " down}"
		Sleep D_TEN
		Send "{" B_USE " up}"
		Send "{" B_JMP " up}"
		Sleep D_TEN
	}
}
