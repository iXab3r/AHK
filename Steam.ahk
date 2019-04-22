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

#IfWinActive, Steam

!+^0::
PressKey := ! PressKey   ;Toggle PressKey True/Fals
If !PressKey 
{
	return
}

loop
{
	If !PressKey 
	{
		Reload
	}
	if WinActive("Steam")
	{
		Send, {Click}
		Sleep, 500
	}
}
return


T::
Send, T
If !PressKey 
{
	return
}
Reload
return

#IfWinActive

