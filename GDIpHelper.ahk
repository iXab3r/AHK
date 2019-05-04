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

ElevateIfNeeded() {
	; If the script is not elevated, relaunch as administrator and kill current instance:
	full_command_line := DllCall("GetCommandLine", "str")
	if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
	{
	    try ; leads to having the script re-launching itself as administrator
	    {
	        if A_IsCompiled
	            Run *RunAs "%A_ScriptFullPath%" /restart
	        else
	            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	    }
	    ExitApp
	}
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
	defaultGuidHwnd := WinExist()
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

	; Set the smoothing mode to antialias = 4 to make shapes appear smother (only used for vector drawing and filling)
	Gdip_SetSmoothingMode(G, 4)
}

EndDrawGDIP() {
	global
	
	; Update the specified window we have created (defaultGuidHwnd) with a handle to our bitmap (hdc), specifying the x,y,w,h we want it positioned on our screen
	; So this will position our gui at (0,0) with the Width and Height specified earlier
	UpdateLayeredWindow(defaultGuidHwnd, hdc, 0, 0, Width, Height)

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

CreateMovableWindow(windowName, width, height){
	local
	; Set the width and height we want as our drawing area, to draw everything in. This will be the dimensions of our bitmap

	; Create a layered window (+E0x80000 : must be used for UpdateLayeredWindow to work!) that is always on top (+AlwaysOnTop), has no taskbar entry or caption
	Gui, MovableOverlay: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
    
	; Show the window
	Gui, MovableOverlay: Show, NA

	; Get a handle to this window we have created in order to update it later
	hwnd := WinExist()

	; Create a gdi bitmap with width and height of what we are going to draw into it. This is the entire drawing area for everything
	hbm := CreateDIBSection(width, height)

	; Get a device context compatible with the screen
	hdc := CreateCompatibleDC()

	; Select the bitmap into the device context
	obm := SelectObject(hdc, hbm)

	; Get a pointer to the graphics of the bitmap, for use with drawing functions
	G := Gdip_GraphicsFromHDC(hdc)

	; Set the smoothing mode to antialias = 4 to make shapes appear smother (only used for vector drawing and filling)
	Gdip_SetSmoothingMode(G, 4)

	; Create a partially transparent, black brush (ARGB = Transparency, red, green, blue) to draw a rounded rectangle with
	pBrush := Gdip_BrushCreateSolid(0x77000000)

	; Fill the graphics of the bitmap with a rounded rectangle using the brush created
	; Filling the entire graphics - from coordinates (0, 0) the entire width and height
	; The last parameter (20) is the radius of the circles used for the rounded corners
	Gdip_FillRoundedRectangle(G, pBrush, 0, 0, width, height, 10)

	; Delete the brush as it is no longer needed and wastes memory
	Gdip_DeleteBrush(pBrush)

	; Update the specified window we have created (hwnd) with a handle to our bitmap (hdc), specifying the x,y,w,h we want it positioned on our screen
	; With some simple maths we can place the gui in the centre of our primary monitor horizontally and vertically at the specified heigth and width
	UpdateLayeredWindow(hwnd, hdc, (A_ScreenWidth-Width)//2, (A_ScreenHeight-Height)//2, Width, Height)

	; By placing this OnMessage here. The function WM_LBUTTONDOWN will be called every time the user left clicks on the gui
	OnMessage(0x201, "WM_LBUTTONDOWN")

	; Select the object back into the hdc
	SelectObject(hdc, obm)

	; Now the bitmap may be deleted
	DeleteObject(hbm)

	; Also the device context related to the bitmap may be deleted
	DeleteDC(hdc)

	; The graphics may now be deleted
	Gdip_DeleteGraphics(G)

	Return hwnd
}

; This function is called every time the user clicks on the gui
; The PostMessage will act on the last found window (this being the gui that launched the subroutine, hence the last parameter not being needed)
WM_LBUTTONDOWN()
{
	PostMessage, 0xA1, 2
}

class OverlayWindow {
    __New(wndName) {
    	global TimeElapsedHwnd

    	this.cycleIdx := 0
        this.windowName := wndName
    	this.overlayWindowName := A_ScriptName
        
		Gui, Test: -Caption +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
	    Gui, Test: Add, Text,, STATS
	    Gui, Test: Add, Text, vTimeElapsedHwnd, TIME ELAPSED:  
	    this.timeElapsedLabelHwnd := TimeElapsedHwnd

		Gui, Test: Font,, MS Sans Serif
		Gui, Test: Show
		;WinSet, TransColor, Red
		OnMessage(0x201, "WM_LBUTTONDOWN")

		this.hwnd := WinExist()
        this.timer := ObjBindMethod(this, "CheckWindowState")

		windowName := this.windowName
		hwnd := this.hwnd

        this.BindGuiToWindowByHandle()
        this.Start()
    }

    BindGuiToWindowByHandle()
	{
	 	timer := this.timer
		SetTimer, %timer%, 250
	}

	Start(){
    	this.start := A_TickCount
	}

	CheckWindowState(){
		GuiControl,,TimeElapsedHwnd, "HELLO"

		windowName := this.windowName
		hwnd := this.hwnd
 		if WinActive(this.windowName) or WinActive(this.overlayWindowName) or 1
		{
			;ToolTip, Showing WindowName %windowName% HWND %hwnd%
			WinShow, ahk_id %hwnd%
		} else {
			;ToolTip, Hiding WindowName %windowName% HWND %hwnd%
			WinHide, ahk_id %hwnd%
		}
		return
	}
}