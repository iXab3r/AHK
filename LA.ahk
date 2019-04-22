#NoEnv 
#SingleInstance force
#Persistent
#MaxThreadsPerHotkey 1
#InstallKeybdHook

SendMode Play 
SetTitleMatchMode, 1 
Menu, TRAY, Icon, L2.ico
CoordMode, Mouse, Relative
SetDefaultMouseSpeed, 1

If (A_AhkVersion <= "1.1.22")
{
    msgbox, You need AutoHotkey v1.1.22 or later to run this script. `n`nPlease go to http://ahkscript.org/download and download a recent version.
    exit
}

#Include GDIp.ahk
#Include GDIpHelper.ahk

SetUpGDIP()
ClearDrawGDIP()

BindGuiToWindow("Lineage II")

DrawTextTimer("Script started, awaiting for commands")

#IfWinActive, Lineage II

F8::  
MsgBox, 1, , Start countdown from 10 ?, 5 
IfMsgBox, Cancel
    Return  
IfMsgBox, Timeout
	return

	SendToChat("10 seconds")
	Sleep, 3000
	SendToChat("7 seconds")
	Sleep, 2000
	SendToChat("5")
	Sleep, 2000
	SendToChat("3")
	Sleep, 1000
	SendToChat("2")
	Sleep, 1000
	SendToChat("1")
	Sleep, 1000
	SendToChat("GO !")
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
DrawTextTimer("[PartyLoop] Inviting party members...")
SendToChat("/invite Xbr")
Sleep, 500
SendToChat("/invite Xab3r")
Sleep, 500
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

SendToChat(msg) {
ControlSend , , {ENTER},Lineage II
		Sleep, 250
ControlSend , , %msg%,Lineage II
		Sleep, 250
ControlSend , , {ENTER},Lineage II
}