#NoEnv  
#SingleInstance force
#MaxThreadsPerHotkey 1

#Include GDIp.ahk
#Include GDIpHelper.ahk

SetKeyDelay, 50
SetMouseDelay, 50

SetUpGDIP()

ClearDrawGDIP()

DrawTextTimer("Script started Gauntlet, awaiting for commands")

#IfWinActive Gauntlet

1::
DrawTextTimer("Fireball")

Send {Space down}
Send {Space up}
Send {Space down}
Send {Space up}
return

0:: ; Fire Leap
Send {Space down}
Send {Space up}
Send {LShift down}
Send {LShift up} 
return

2::
DrawTextTimer("Fire bomb")
Send {Space down}
Send {Space up}
Send {Click right}
return

3::
DrawTextTimer("Shockgun")
Send {Click right}
Send {Space down}
Send {Space up}
return

X::
DrawTextTimer("Chain")
Send {Click right}
Send {LShift down}
Send {LShift up}
return

R::
DrawTextTimer("Ice blast")
Send {LShift down}
Send {LShift up}
Send {Space down}
Send {Space up}
return

Z::
DrawTextTimer("Ice orb")
Send {LShift down}
Send {LShift up}
Send {RButton down}
Send {RButton up}
return

F10::
DrawTextTimer("Shield")
Send {Click right}
Send {Click right}
Send {Click left}
return

#IfWinActive
