#SingleInstance, Force
#Persistent
SetWorkingDir, %A_ScriptDir%
CoordMode,Mouse,screen
CoordMode,Pixel,screen
CoordMode, ToolTip

Gui, 2:Add,Text, x10 y25 w150 h20,F1 To Toggle
Gui, 2: Submit, NoHide
Gui, 2: +AlwaysOnTop   
Gui, 2:Show, x1300 y430, PokeOne Bot


toggle := 0, fixedY := A_ScreenHeight/2 ; choose the y you like

F1::
MouseGetPos, MouseX, MouseY
if toggle := !toggle
 gosub, MoveTheMouse
else
 SetTimer, MoveTheMouse, off
return

MoveTheMouse:
Random, x, 1, % A_ScreenWidth
MouseMove, %x%, %fixedY%
click, %x%,%fixedY%
Random,time, 1000*3, 1000*8
SetTimer, MoveTheMouse, -%time%  ; every 3 seconds 
return


2GuiClose:
ExitApp

z::
ExitApp