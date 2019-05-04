#SingleInstance force
#Persistent
#MaxThreadsPerHotkey 1
#InstallKeybdHook

SendMode Input 
SetTitleMatchMode, 1 
Menu, TRAY, Icon, L2.ico
CoordMode, Mouse, Relative
SetDefaultMouseSpeed, 1
SetKeyDelay, 10

If (A_AhkVersion <= "1.1.22")
{
    msgbox, You need AutoHotkey v1.1.22 or later to run this script. `n`nPlease go to http://ahkscript.org/download and download a recent version.
    exit
}

#Include GDIp.ahk
#Include GDIpHelper.ahk

ElevateIfNeeded()
#Include AHI\Lib\AutoHotInterception.ahk

global AHI := new AutoHotInterception()
global keyboardId := AHI.GetKeyboardId(0x1E7D, 0x319C, 1)
global keyboardContext := AHI.CreateContextManager(keyboardId)

SetUpGDIP()
ClearDrawGDIP()

global WindowName = "Lineage II"

statsWindow := new OverlayWindow("")

adminText = "USER"
if (A_IsAdmin){
	adminText = "ADMIN"
}
DrawTextTimer("Script started(" . adminText . "), awaiting for commands")

#IfWinActive, Lineage II

Numpad0::
DrawTextTimer("[ExpLoot] Buffing...")
RebuffIfNeeded()
return

Numpad1::
DrawTextTimer("GCP")
ControlSend , ,2,Lineage II
Sleep, 100
return

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

F10:: 
NumpadSub::  
DrawTextTimer("[ExpLoot] Exping...")
Loop {	
	DrawTextTimer("[ExpLoot] Cycle #")
	RebuffIfNeeded()
	Random, rand, 600000, 900000
	Sleep, %rand%
}
return

NumpadAdd::  
DrawTextTimer("[PartyLoop] Inviting party members...")
InviteToParty("sdnss")
InviteToParty("Quo")
InviteToParty("qm")
InviteToParty("Qkk")
InviteToParty("Zhizha")
InviteToParty("Rnv")
return

NumpadMult::  
CoordMode Pixel  
PixelSearch, Px, Py, 400, 1300, 500, 1400, 0x01A217, 3, Fast RGB
if (ErrorLevel != 0) {
	;MsgBox, That color was not found in the specified region.
    DrawTextTimer("[Auto-exp] DISABLED")
    return
}
    
DrawTextTimer("[Auto-exp] * exp...")
;MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.

MouseGetPos, xpos, ypos 
MouseClick, right, %Px%, %Py%
Sleep, 100
MouseMove, %xpos%, %ypos% 
return

F9::  
	SendToChat("!куплю Печать отставания, Печать безмолвия, Печать замедления, Печать оков, Ритуал жизни")
return

F12::
NumpadDiv::  
	Reload
return

#IfWinActive

InviteToParty(nickname) {
DrawTextTimer("[Party] Inviting " . nickname . "...")
SendToChat("/invite " . nickname)
Sleep, 500
}

SendToChatBackground(msg) {
ControlSend , , {ENTER},Lineage II
Sleep, 250
ControlSend , , %msg%,Lineage II
Sleep, 250
ControlSend , , {ENTER},Lineage II
}

RebuffIfNeeded() {
	WinActivate, Lineage II
	WinWait, Lineage II
	Sleep, 500
	AHI.SendKeyEvent(keyboardId, 63, 1)
	Sleep, 500
	AHI.SendKeyEvent(keyboardId, 63, 1)
	Sleep, 500
	AHI.SendKeyEvent(keyboardId, 63, 1)
}

SendToChat(msg) {
Send, {ENTER}
Send, %msg%
Send, {ENTER}
}