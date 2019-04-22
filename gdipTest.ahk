#NoEnv  
#InstallKeybdHook
SendMode Play  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 1 ;A window's title must start with the specified WinTitle to be a match.
CoordMode, Mouse, Relative
SetDefaultMouseSpeed, 1

#Include GDIp.ahk
#Include GDIpHelper.ahk
 
SetUpGDIP()

StartDrawGDIP()
ClearDrawGDIP()
 
pBrush := Gdip_BrushCreateSolid(0xffff0000)
Random, X, 20, 300
Gdip_FillRectangle(G, pBrush, X, 5, 200, 300)
Gdip_DeleteBrush(pBrush)
 
EndDrawGDIP()
return