; == Startup Options ===========================================
#SingleInstance force
#NoEnv 
#Persistent ; Stay open in background
SendMode Input 
StringCaseSense, On ; Match strings with case.
Menu, tray, Tip, Exile Tools
#MaxThreadsPerHotkey 2
SetTitleMatchMode, 2 ;A window's title must start with the specified WinTitle to be a match.
Menu, TRAY, Icon, C:\Program Files (x86)\Grinding Gear Games\Path of Exile\PathOfExile.exe

#Include GDIp.ahk
#Include GDIpHelper.ahk

If (A_AhkVersion <= "1.1.22")
{
    msgbox, You need AutoHotkey v1.1.22 or later to run this script. `n`nPlease go to http://ahkscript.org/download and download a recent version.
    exit
}

MouseMoveThreshold := 40
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

SetUpGDIP()
ClearDrawGDIP()

BindGuiToWindow("Path of Exile")
return


#IfWinActive, Path of Exile 

DrawEnabledCircle()

;SetTimer, AutoPotRoar, 5000
;SetTimer, AutoPotAtziri, 5000
;SetTimer, AutoPotToH, 5000
;SetTimer, AutoPotArmor, 5000

return

AutoPotArmor:
if WinActive("Path of Exile")
{
 ; Eva/Armor
 PixelGetColor, potColor, 327, 1015
 if (potColor = 0x44B256)
 {
   Send, 1
 }
}
return

AutoPotEvasion:
if WinActive("Path of Exile")
{
 ; Eva/Armor
 PixelGetColor, potColor, 418, 1013
 if (potColor = 0x4BA05C)
 {
   Send, 3
 }
}
return

AutoPotRoar:
if WinActive("Path of Exile")
{
 PixelGetColor, potColor, 418, 1017
 if (potColor = 0x4D6058)
 {
   Send, 3
 }
}
return

AutoPotToH:
if WinActive("Path of Exile")
{
 PixelGetColor, potColor, 461, 1025
 if (potColor = 0xB79890)
 {
   Send, D
 }
}
return

AutoPotAtziri:
if WinActive("Path of Exile")
{
 PixelGetColor, potColor, 517, 1013
 if (potColor = 0x95285A)
 {
   Send {vkC0sc029}
 }
}
return

f::
  Send, 23df
return

; Remaining
^Tab::
if WinActive("Path of Exile")
{
  Send, {ENTER}/remaining{ENTER
}
return

; Gem swap
^`::
if WinActive("Path of Exile")
{
  MouseGetPos, xpos, ypos 
  Send, v
  Sleep, 100
  Click, 1880, 830
  Click, 1560, 360
  Click, 1880, 830
  Send, v
  MouseMove, %xpos%, %ypos% 
}
return


^F3:: 
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
MsgBox The color at X%MouseX% Y%MouseY% is %color%.
return

F6::
{
  SendMode Input
  loop
  {
    Send {ENTER}
    Send /trade %A_Index%
    Send {ENTER}
    Send {ENTER}  
    Send {Up 2}
    Sleep, 2600
    Send {ENTER}
    If A_Index = 13
    Break
    else
    Sleep, 100
  }
}
return


Numpad1::
{
  SendMode Input
  Send {ENTER}
  Send /invite sixhotbitches
  Send {ENTER}
  Sleep, 250
  Send {ENTER}
  Send /invite wickedlittlemouse
  Send {ENTER}
}
return

#IfWinActive

; == Function Stuff =======================================

DrawEnabledCircle()
{
  DrawStatusCircle(Gdip_ToARGB(255,0,255,0))
}

DrawDisabledCircle()
{
  DrawStatusCircle(Gdip_ToARGB(80,255,0,0))
}

DrawStatusCircle(colorARGB)
{
  global
  x := A_ScreenWidth * 0.237
  y := A_ScreenHeight - A_ScreenHeight * 0.150
  r := 20

  StartDrawGDIP()
  FillCircle(x,y, r, colorARGB)

  argb := Gdip_ToARGB(255,255,255,255)
  DrawCircle(x,y, r, argb, 2)
  EndDrawGDIP()
}
