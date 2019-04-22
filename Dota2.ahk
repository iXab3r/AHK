#NoEnv  
#MaxThreadsPerHotkey 2
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 2 ;A window's title must start with the specified WinTitle to be a match.

#Include GDIp.ahk
#Include GDIpHelper.ahk

#IfWinActive,DOTA 2

NumpadAdd::
PressKey:=1

Send, {F7}
Sleep, 500

MoveToStartPoint(1000)
AttackRoshan(2500)
MoveToStartPoint(2600)
ClickWard(100)
Stop(450)
MoveToPoint(850, 340, 400)
AttackRoshan(1200)


loop
{
	If !PressKey 
	{
		Reload
	}
	if WinActive("DOTA 2")
	{
		MoveToStartPoint(2200)
		ClickWard(100)
		Stop(450)
		MoveToPoint(850, 340, 200)
		AttackRoshan(1300)
	}
}
return

NumpadSub::
Reload
return
		
#IfWinActive

MoveToPoint(x, y, delay)
{
	MouseClick, Right, %x%, %y%
	Sleep, %delay%
}

MoveToStartPoint(delay)
{
	MoveToPoint(610, 340, delay)
}

AttackRoshan(delay)
{
	MouseMove, 1160, 240
	Sleep, 50
	Send, {A}
	Sleep, %delay%
}

ClickWard(delay)
{
	MouseClick, Right, 740, 570
	Sleep, %delay%
}

Stop(delay)
{
	Send, {S}
	Sleep, %delay%
}

PlaceWard(delay)
{
	MouseMove, 740, 570
	Sleep, 50
	Send, {3}
	Sleep, %delay%
}

