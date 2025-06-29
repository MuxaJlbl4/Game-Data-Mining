#Requires AutoHotkey v2.0
#HotIf WinActive("ahk_exe SheepD3D.exe")

; Check Admin
if (!A_IsAdmin)
{
	MsgBox "Please, run this script as Administrator."
	ExitApp
}

; Control Buttons
B_USE := "X"			; 🖐️
B_JMP := "Space"		; ⏫
B_SEE := "Shift"		; 👀
B_RUN := "Z"			; ⏩
B_INV := "Alt"			; 📦
B_MAP := "F12"			; 🗺️
B_UP := "Up"			; ⬆️
B_DN := "Down"			; ⬇️
B_RT := "Right"			; ➡️
B_LT := "Left"			; ⬅️

; Delays
D_JMP := 400			; Delay for double jump sequence
D_NXT := 100			; Delay for next sequence
D_MIN := 25				; Delay for button hold
D_MAP := 900			; Delay for map enter
D_BUT := 500			; Delay for map buttons sequence
D_RET := 400			; Delay for map return

; Key Press
PressKey(key, pressDelay := D_MIN, releaseDelay := D_MIN)
{
	Send "{" key " down}"
	Sleep pressDelay
	Send "{" key " up}"
	Sleep releaseDelay
}

; Double Key Press
PressDouble(key1, key2, pressDelay := D_MIN, releaseDelay := D_MIN)
{
	Send "{" key1 " down}"
	Send "{" key2 " down}"
	Sleep pressDelay
	Send "{" key1 " up}"
	Send "{" key2 " up}"
	Sleep releaseDelay
}

; Equip item from quick inventory
Equip()
{
	PressDouble(B_INV, B_LT, D_NXT, D_BUT) ; Take item
}

; Unequip current item
Unequip()
{
	PressKey(B_INV, D_MIN, D_MIN)	; Return item
}

; Equip item from map menu
MapEquip()
{
	PressKey(B_MAP, D_MIN, D_MAP)	; Open Map
	PressKey(B_USE, D_MIN, D_BUT)	; Select Item
	PressKey(B_RT, D_MIN, D_BUT)	; Select Equip
	PressKey(B_USE, D_MIN, D_RET)	; Equip Item
}

; Double jump
DoubleJump()
{
	PressKey(B_JMP, D_MIN, D_JMP)	; First Jump
	PressKey(B_JMP, D_MIN, D_NXT)	; Second Jump
}

; Inventory jump
InventoryJump()
{
	Equip()
	DoubleJump()
	Unequip()
	DoubleJump()
}

; Map jump
MapJump(count)
{
	Loop count
	{
		MapEquip()
		DoubleJump()
		Unequip()
		DoubleJump()
	}
}

; Inventory Jump (x4)
$Numpad0::
{
	InventoryJump()
}

; Inventory + Map Jump (x8)
$Numpad1::
{
	InventoryJump()
	MapJump(1)
}

; Multiple Inventory + Map Jump (x12)
$Numpad2::
{
	InventoryJump()
	MapJump(2)
}

; Multiple Inventory + Map Jump (x16)
$Numpad3::
{
	InventoryJump()
	MapJump(3)
}

; Finish Level Cheat Code
$Home::
{
	PressKey(B_JMP) ; ⏫
	PressKey(B_JMP) ; ⏫
	PressKey(B_SEE) ; 👀
	PressKey(B_JMP) ; ⏫
	PressKey(B_SEE) ; 👀
	PressKey(B_RUN) ; ⏩
	PressKey(B_RUN) ; ⏩
}

; Unknown Cheat Code
$End::
{
	PressKey(B_JMP) ; ⏫
	PressKey(B_JMP) ; ⏫
	PressKey(B_SEE) ; 👀
	PressKey(B_SEE) ; 👀
	PressKey(B_RUN) ; ⏩
	PressKey(B_RUN) ; ⏩
}
