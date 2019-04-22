#NoEnv  
#MaxThreadsPerHotkey 2
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 2 ;A window's title must start with the specified WinTitle to be a match.

#Include GDIp.ahk
#Include GDIpHelper.ahk

SetUpGDIP()

ClearDrawGDIP()

BindGuiToWindow("Diablo III")

DrawDisabledCircle()

#IfWinActive,Diablo III

!+^0::
PressKey := ! PressKey   ;Toggle PressKey True/Fals
If !PressKey 
{
	Reload
	return
}

DrawEnabledCircle()

loop
{
	if WinActive("Diablo III")
	{
		Send, {NUMPAD1}
		Sleep, 500
	}
}
return

!+^4::
Process, close, turbohud.exe
Process, waitclose, turbohud.exe
Run, C:\Work\TurboHUD\TurboHUD.exe
return
		
#IfWinActive
