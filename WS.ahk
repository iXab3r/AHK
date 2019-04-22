#NoEnv  
#InstallKeybdHook
SendMode Play  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 1 ;A window's title must start with the specified WinTitle to be a match.
CoordMode, Mouse, Relative
SetDefaultMouseSpeed, 1
Menu, TRAY, Icon, WS.ico
#MaxThreadsPerHotkey 1

#Include GDIp.ahk
#Include GDIpHelper.ahk

SetUpGDIP()

ClearDrawGDIP()

DrawTextTimer("Script started, awaiting for commands")

#IfWinActive, WildStar

NumpadSub::  
DrawTextTimer("[ExpLoot] Exping...")
Loop {	
	ControlSend,,q,WildStar
	Sleep, 100000
}
return


NumpadDiv::  
	Reload
return

#IfWinActive