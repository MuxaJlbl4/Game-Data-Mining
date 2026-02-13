#Requires AutoHotkey v2.0

; Allowed apps
#HotIf WinActive("ahk_exe Generals.exe") or WinActive("ahk_exe generalsv.exe") or WinActive("ahk_exe generalszh.exe")

; Admin check
if (!A_IsAdmin)
{
	MsgBox "Please, run this script as Administrator."
	ExitApp
}

; Key behavior check
Rebind(OrigKey, NewKey)
{
	if GetKeyState("Shift", "P")
		SendEvent "{" OrigKey "}"
	else
		SendEvent "{Blind}{" NewKey " DownTemp}"
}

; WASD + QE rebinding
*W::Rebind("w", "up")
*W up::SendEvent "{Blind}{up up}"

*A::Rebind("a", "left")
*A up::SendEvent "{Blind}{left up}"

*S::Rebind("s", "down")
*S up::SendEvent "{Blind}{down up}"

*D::Rebind("d", "right")
*D up::SendEvent "{Blind}{right up}"

*Q::Rebind("q", "numpad4")
*Q up::SendEvent "{Blind}{numpad4 up}"

*E::Rebind("e", "numpad6")
*E up::SendEvent "{Blind}{numpad6 Up}"

; RMB hold preventing
RButton::SendEvent "{RButton down}{RButton up}"

; Unlock FPS and decrease TickRate
; FPS:	30	50	56	60	65	70	72	75	80	85	90	100	110	120	144	240	480	1000000
; Id:	-1	0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16
$NumpadEnter::
{
	SetKeyDelay 20, 20
	SendEvent "^{NumpadAdd}"	; Max Render FPS is 50
	SendEvent "^+{NumpadSub 4}"	; Logic Time Scale FPS is 30
	SendEvent "^{NumpadAdd 14}"	; Max Render FPS is 240
}
