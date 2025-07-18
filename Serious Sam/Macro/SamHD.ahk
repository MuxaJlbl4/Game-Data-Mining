#Requires AutoHotkey v2.0

; Allowed apps
#HotIf WinActive("ahk_exe SamHD.exe") or WinActive("ahk_exe SamHD_TSE.exe") or WinActive("SamHD_TSE_Unrestricted.exe")

; Admin check
if (!A_IsAdmin)
{
	MsgBox "Please, run this script as Administrator."
	ExitApp
}

; Controls
B_JMP := "Space"			; Jump
B_CRC := "C"				; Crouch
B_ATK := "LButton"			; Attack
B_CMD := "``"				; Console
B_RET := "Enter"			; Return

B_LT := "A"				; Console
B_RT := "D"			; Return


; Delays
D_FPS := 10					; FPS lock value
D_QUA := 1000/D_FPS/4		; Quarter frame time
D_HAL := 1000/D_FPS/2		; Half frame time
D_ACC := 1150				; Delay after fire
D_CLP := 250				; Delay after clip
D_MIN := 1					; Delay for turbo key

; Simple key press
PressKey(key, pressDelay := D_HAL, releaseDelay := D_HAL)
{
	Send "{" key " down}"
	Sleep pressDelay
	Send "{" key " up}"
	Sleep releaseDelay
}

; Turbo key press for frame catch
FrameKey(key, pressDelay := D_QUA, releaseDelay := D_HAL)
{
	Loop pressDelay
	{
		Send "{" key " down}"
		Sleep D_MIN
	}
	Send "{" key " up}"
	Sleep releaseDelay
}

; Type console command
Console(cmd)
{
	PressKey(B_CMD)
	Send cmd
	Sleep D_HAL
	PressKey(B_RET)
	PressKey(B_CMD)
}

; Ground clip with rocket jump
$F8::
{
	Console("gfx_iMaxFPSActive=" D_FPS)
	PressKey(B_JMP, D_HAL, D_QUA)
	FrameKey(B_ATK, D_QUA, D_ACC)
	FrameKey(B_CRC, D_QUA, D_CLP)
	Console("gfx_iMaxFPSActive=10000")
}

~RButton::
{
	; Turbo XL2 Lasergun
    if GetKeyState("LButton", "P")
    {
        while GetKeyState("RButton", "P") && GetKeyState("LButton", "P")
        {
            MouseClick "Left", , , , , "D"
            Sleep D_MIN
            MouseClick "Left", , , , , "U"
            Sleep D_MIN
        }
    }
	
	; Turbo harpy jump
	if GetKeyState("Space", "P")
    {
        while GetKeyState("RButton", "P") && GetKeyState("Space", "P")
        {
			Send "{" B_JMP " down}"
			Sleep D_MIN
			Send "{" B_JMP " up}"
			Sleep D_MIN
		}
	}
}
