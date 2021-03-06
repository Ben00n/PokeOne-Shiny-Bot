#SingleInstance, Force
#Persistent
SetWorkingDir, %A_ScriptDir%
CoordMode,Mouse,screen
CoordMode,Pixel,screen
CoordMode, ToolTip

;Settings Reads
IniRead,ReadRunTimes,settings.ini,MainStatistics,FledTimes
IniRead,ReadShinyTimes,settings.ini,MainStatistics,ShinyTimes

Gui, 2:Add,Button, x10 y25 w150 h20 gStart, Start
Gui, 2:Add,CheckBox, x180 y51 cRed Checked vShinyCheck1 gShinyCheck, Shiny
Gui, 2:Add, Button, x185 y125 w60 h40 gOpenGame , Open PokeOne
Gui, 2:Add,Text, x15 y100, Times Fled:
Gui, 2:Add,Text, x150 y100, Shinies Found:
Gui, 2:Add,Text, x85 y100 vReadRunTimes gRun_Counter, %ReadRunTimes%
Gui, 2:Add,Text, x235 y100 w50 vReadShinyTimes gShiny_Counter, %ReadShinyTimes%
Gui, 2: Submit, NoHide
Gui, 2: +AlwaysOnTop   

RunCounter = %ReadRunTimes%
ShinyCounter = %ReadShinyTimes%

Gui, 2:Show, x1300 y180, PokeOne Bot
return



OpenGame:
IfWinNotExist, ahk_exe PokeOne.exe
{
	Run,C:\PokeOne\files\PokeOne
}                                                           ;Open the game BTN
IfWinExist, ahk_exe PokeOne.exe
{
	MsgBox, Already Running
}
return

Shiny_Counter:
Gui,Submit,NoHide
ShinyCounter++
IniWrite,%ShinyCounter%,settings.ini,MainStatistics,ShinyTimes
IniRead,ReadShinyTimes,settings.ini,MainStatistics,ShinyTimes
GuiControl,,ReadShinyTimes,%ReadShinyTimes%
return


Run_Counter:
Gui,Submit,NoHide
RunCounter++
IniWrite,%RunCounter%,settings.ini,MainStatistics,FledTimes
IniRead,ReadRunTimes,settings.ini,MainStatistics,FledTimes
GuiControl,,ReadRunTimes,%ReadRunTimes%
return

ShinyCheck:
Gui,Submit, NoHide
if(ShinyCheck1==1)
{
    ImageSearch, Loc_XShiny1, Loc_YShiny1, 0,0, A_ScreenWidth, A_ScreenHeight, shiny.png
	if(ErrorLevel==0)
	{
		ShinyWasNotFound=0 ;Found
		return
    }
	else if(ErrorLevel==1)
	{
		ShinyWasNotFound=1 ;WasntFound
		return
	}
}

Start:
Stop = 0
while(Stop == 0)
{
	ImageSearch, Loc_X, Loc_Y, 0,0, A_ScreenWidth, A_ScreenHeight, try.png
	if(ErrorLevel=2)
	{
		MsgBox,ErrorLevel = 2`Something is wrong, place all the files in a folder on desktop.
		return
	}
	else if(ErrorLevel=1)
	{
		ImageSearch, Loc_XRun, Loc_YRun, 0, 0, A_ScreenWidth, A_ScreenHeight, run.png
		if(ErrorLevel=0)
		{
			ImageSearch, Loc_XShiny, Loc_YShiny, 0 , 0, A_ScreenWidth, A_ScreenHeight, shiny.png
			if(ErrorLevel=0)
			{
				gosub, Shiny_Counter
				SoundPlay, shiny.mp3
				MsgBox, Found Shiny!
				return
			}
			else if(ErrorLevel=1)
			{
				;found run but not shiny
				Random,CursorRunDecidor,0,2
				Random,MaxRunX1,1062,1199
				Random,MaxRunY1,1023,1058
				Random,MaxRunX2,1062,1199
				Random,MaxRunY2,1023,1058
				Random,IntervalCursorRun1,3,8
				Random,IntervalCursorRun2,3,8
				if(CursorRunDecidor == 1)
				{
					MouseMove,%MaxRunX1%, %MaxRunY1%, %IntervalCursorRun1%
					click, %MaxRunX1%, %MaxRunY1%
					gosub, Run_Counter
				}
				else if(CursorRunDecidor == 2)
				{
					MouseMove,%MaxRunX2%, %MaxRunY2%, %IntervalCursorRun2%
					click, %MaxRunX2%, %MaxRunY2%		
					gosub, Run_Counter
				}
			}
		}
		else if(ErrorLevel=1)
		{
			Sleep, 666
			Random, RandomMouseDecidor,0,2
			Random, RandomOfRandomMouseDecidor,0,2
			Random, RandomMouseX1,500,1050
			Random, RandomMouseY1,500,1050
			Random, RandomMouseX2,300,1600
			Random, RandomMouseY2,400,1000
			Random, Interval1,3,8
			Random, Interval2,3,8
			if(RandomMouseDecidor == 1)
			{
				if(RandomOfRandomMouseDecidor == 1)
				{
					MouseMove, %RandomMouseX1% , %RandomMouseY1%, %Interval1%
				}
				else if(RandomOfRandomMouseDecidor == 2)
				{
					MouseMove, %RandomMouseX2%, %RandomMouseY2%, %interval2%
				}
			}
			else if(RandomMouseDecidor == 2)
			{
				if(RandomOfRandomMouseDecidor == 1)
				{
					MouseMove, %RandomMouseX2% , %RandomMouseY2%, %Interval2%
				}
				else if(RandomOfRandomMouseDecidor == 2)
				{
					MouseMove, %RandomMouseX1% , %RandomMouseY1%, %Interval1%
				}
			}
		}
	}
	else if(ErrorLevel=0) ;found try.png
	{
		Random, RandomLeftWalk, 111,888
		Random, RandomRightWalk, 111,900
		Random, MovementDecidor, 0,2 ;Randoming 1-2 included both
		if(MovementDecidor==1)
		{
			Send {Left down}
			Sleep,%RandomLeftWalk%
			Send,{Left up}
			Send {Right down}
			Sleep,%RandomRightWalk%
			Send,{Right up}
		}
		else if(MovementDecidor==2)
		{
			send {Right down}
			Sleep,%RandomRightWalk%
			send {Right up}
			send {Left down}
			Sleep,%RandomLeftWalk%
			send {Left up}
		}
	}
}
return


2GuiClose:
ExitApp

z::
ExitApp