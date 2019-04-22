JustTheBasics() {
	global
	
	; Start gdi+
	If !pToken := Gdip_Startup()
	{
		MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
		ExitApp
	}
	OnExit, Exit
	return
	
	
	Exit:
	; gdi+ may now be shutdown on exiting the program
	Gdip_Shutdown(pToken)
	ExitApp
	Return

}

SetUpGDIP(iWidth=-1, iHeight=-1) {
	global
	Width := iWidth
	Height := iHeight
	If (iWidth < 0) {
		Width := A_ScreenWidth
	}
	if (iHeight < 0) {
		height := A_ScreenHeight
	}
	
	
	JustTheBasics()
	
	; Create a layered window (+E0x80000 : must be used for UpdateLayeredWindow to work!) that is always on top (+AlwaysOnTop), has no taskbar entry or caption
	Gui, 1: -Caption +E0x20 +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs

	; Show the window
	Gui, 1: Show, NA

	; Get a handle to this window we have created in order to update it later
	hwnd1 := WinExist()
	return
}

StartDrawGDIP() {
	global
	
	; Create a gdi bitmap with width and height of what we are going to draw into it. This is the entire drawing area for everything
	hbm := CreateDIBSection(Width, Height)

	; Get a device context compatible with the screen
	hdc := CreateCompatibleDC()

	; Select the bitmap into the device context
	obm := SelectObject(hdc, hbm)

	; Get a pointer to the graphics of the bitmap, for use with drawing functions
	G := Gdip_GraphicsFromHDC(hdc)	
}

EndDrawGDIP() {
	global
	
	; Update the specified window we have created (hwnd1) with a handle to our bitmap (hdc), specifying the x,y,w,h we want it positioned on our screen
	; So this will position our gui at (0,0) with the Width and Height specified earlier
	UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)


	; Select the object back into the hdc
	SelectObject(hdc, obm)

	; Now the bitmap may be deleted
	DeleteObject(hbm)

	; Also the device context related to the bitmap may be deleted
	DeleteDC(hdc)

	; The graphics may now be deleted
	Gdip_DeleteGraphics(G)
}

ClearDrawGDIP() {
	global
	Gdip_GraphicsClear(G)
}

DrawText(text,textX=-1,textY=-1)
{
	global
	if (textX = -1)
	{
		textX := A_ScreenWidth/2
	}
	if (textY = -1)
	{
		textY := 30
	}
	StartDrawGDIP()
	Gdip_TextToGraphics(G,text,"x" . textX . " y" . textY . " cFFFF0000 r4 s68 Center Vcenter")
	EndDrawGDIP()
}

DrawCircle(x, y, radius, penARGB, penWidth)
{
	global
	pen := Gdip_CreatePen(penARGB, penWidth)
	Gdip_DrawEllipse(G, pen, x, y, radius, radius)
}

FillCircle(x, y, radius, brushARGN)
{
	global
	pen := Gdip_BrushCreateSolid(brushARGN)
	Gdip_FillEllipse(G, pen, x, y, radius, radius)
}

DrawTextTimer(text,sleepMs=2000)
{
	global
	DrawText(text)
	SetTimer, DrawTextTimerLabel, %sleepMs%
	return
DrawTextTimerLabel:
	SetTimer, DrawTextTimerLabel, Off
	StartDrawGDIP()
	EndDrawGDIP()
	return
}

BindGuiToWindow(windowName)
{
	global
	wndName = %windowName%
	SetTimer, BindGuiToWindow_recheck, 1000
	return

BindGuiToWindow_recheck:
	if WinActive(wndName)
	{
		WinShow, ahk_id %hwnd1%
	} else {
		WinHide, ahk_id %hwnd1%
	}
	return
}
