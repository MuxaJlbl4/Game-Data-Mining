#Requires AutoHotkey v2.0

; Allowed apps
#HotIf WinActive("ahk_exe pcsx2-qt.exe")

; Admin check
if (!A_IsAdmin)
{
	MsgBox "Please, run this script as Administrator."
	ExitApp
}

; Controls
KeyStart	:= "Enter"
KeySelect	:= "Backspace"
KeyCross	:= "K"
KeyCircle	:= "L"

; Delays
DelMin := 1000/60

; Simple key press
PressKey(key, pressDelay := DelMin, releaseDelay := DelMin)
{
	Send "{" key " down}"
	PreciseSleep(pressDelay)
	Send "{" key " up}"
	PreciseSleep(releaseDelay)
}

; Double key press
PressDouble(key1, key2, pressDelay := DelMin, releaseDelay := DelMin)
{
	Send "{" key1 " down}"
	Send "{" key2 " down}"
	PreciseSleep(pressDelay)
	Send "{" key1 " up}"
	Send "{" key2 " up}"
	PreciseSleep(releaseDelay)
}

; Key hold
HoldKey(key, delay := DelMin)
{
	Send "{" key " down}"
	PreciseSleep(delay)
}

; Key release
ReleaseKey(key, delay := DelMin)
{
	Send "{" key " up}"
	PreciseSleep(delay)
}

; HVE
HintVideoExploit(paused := false)
{
	if (paused)
		PressKey(KeyCross, DelMin, DelMin)
	else
		PressKey(KeySelect, DelMin, DelMin)
	Loop (7)
		PressKey(KeyCross, DelMin, DelMin)
	PressKey(KeySelect, DelMin, DelMin)
}

; Full Spin HVE (FSHVE)
$Numpad0::
{
	HoldKey(KeyCircle, DelMin*13)
	HintVideoExploit()
	ReleaseKey(KeyCircle, DelMin)
}

; Instant HVE (IHVE)
$Numpad1::
{
	PressDouble(KeyCircle, KeyStart, DelMin, DelMin)
	HintVideoExploit(paused := true)
}

; More accurate sleep
PreciseSleep(ms)
{
	DllCall("QueryPerformanceFrequency", "Int64*", &freq := 0)
	DllCall("QueryPerformanceCounter", "Int64*", &start := 0)
	target := start + (ms * freq) / 1000
	while (true)
	{
		DllCall("QueryPerformanceCounter", "Int64*", &current := 0)
		if (current >= target)
			break
	}
}
