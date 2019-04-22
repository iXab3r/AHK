#NoEnv  
#InstallKeybdHook
SendMode Play  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 1 ;A window's title must start with the specified WinTitle to be a match.
Menu, TRAY, Icon, GameIcon.ico
CoordMode, Mouse, Relative
SetDefaultMouseSpeed, 1
#MaxThreadsPerHotkey 1

#Include GDIp.ahk
#Include GDIpHelper.ahk

SetUpGDIP()

ClearDrawGDIP()

DrawTextTimer("Script started, awaiting for commands")

#IfWinActive, - ArcheAge

Numpad0::  
	SendToChat("Куплю золотой Стеганый камзол телекинеза")
return

F8::  
MsgBox, 1, , Start countdown from 10 ?, 5 
IfMsgBox, Cancel
    Return  
IfMsgBox, Timeout
	return

	SendToChat("10 секунд до старта")
	Sleep, 3000
	SendToChat("7 секунд")
	Sleep, 2000
	SendToChat("5")
	Sleep, 2000
	SendToChat("3")
	Sleep, 1000
	SendToChat("2")
	Sleep, 1000
	SendToChat("1")
	Sleep, 1000
	SendToChat("Старт !")
return

Numpad7::  
Loop,  {	
IfWinActive,  - ArcheAge
	{
		BlockInput, MouseMove

		GetKeyState, state, RButton
		if state = D
		{
			MouseClick,RIGHT,,,,,U
		}
		ControlSend , , {ESC},- ArcheAge
		Sleep, 200
		ControlSend , , {F4},- ArcheAge
		Sleep, 500
		ControlSend , , {F8},- ArcheAge
		Sleep,500
		MouseGetPos, px, py
		Mousemove 958, 454, 0
		Sleep, 500 
		MouseClick
		Sleep, 1000 
		Mousemove %px%,%py%, 0
		ControlSend , , {F4},- ArcheAge
		BlockInput, MouseMoveOff

	}
	Random, rand, 4000, 6000
	Sleep, %rand%
}
Reload
return

^0::  
Send, {F6}
Sleep, 400
Send, {F6}
Sleep, 400
Send, {F4}
Send, {F5}
return

NumpadMult::  
MouseGetPos, px, py
x := 0
DrawTextTimer("[AuctionLoop] Started")
Loop {
	x := x + 1
	if (Mod(x,60)=0)
	{
		ControlSend , ,{F8},- ArcheAge
		Sleep, 1000
		ControlSend , ,{F8},- ArcheAge
		Sleep, 1000
	}

	IfWinActive,  - ArcheAge
	{
		Mousemove %px%,%py%, 0
		Sleep, 500
		ControlClick,, - ArcheAge,,,, NA
	}
	Sleep, 3000
}

return

NumpadDot::  

return

NumpadAdd::  
Loop {
	ControlSend , , {F12},- ArcheAge
	Sleep, 3000
	ControlSend , , {F12},- ArcheAge
	Sleep, 300000
}
return

^1::  
!1::  
Send, ^1
Sleep, 100
Send, ^s2
return

NumpadSub::  
x := 0
DrawTextTimer("[ExpLoot] Exping...")
Loop {	
	if (Mod(x,120)=0)
	{
		ControlSend , ,4,- ArcheAge
		Sleep, 500
	}
		if (Mod(x,120)=0)
		{
			Sleep, 1300
			ControlSend , ,{Ctrl down}3{Ctrl up},- ArcheAge
			Sleep, 100
		}
	
	ControlSend , ,3,- ArcheAge
	Sleep, 100
	ControlSend , ,q,- ArcheAge
	Sleep, 100
	ControlSend , ,f,- ArcheAge
	Sleep, 100
	x := x + 1
}
return


NumpadDiv::  
	Reload
return



#IfWinActive

#F12::  
TrayTip, F12 pressed, Sending UP+Right to ArcheAge...
ControlSend , , {Up down},- ArcheAge
ControlSend , , {Right down},- ArcheAge
return


SendToChat(msg) {
ControlSend , , {ENTER},- ArcheAge
		Sleep, 250
ControlSend , , %msg%,- ArcheAge
		Sleep, 250
ControlSend , , {ENTER},- ArcheAge
}