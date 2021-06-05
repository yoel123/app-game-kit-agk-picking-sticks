
// Project: picking stick 
// Created: 2021-05-17

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "picking stick" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//load images

global stick_img = 1
global stick_sprite = 1
global player_img = 2
global player_sprite = 2

LoadImage(stick_img,"stick.png")
LoadImage(player_img,"stick_picker.png")

//create sprites

CreateSprite(stick_sprite,stick_img)
CreateSprite(player_sprite,player_img)

//config spritemap
SetSpriteAnimation(player_sprite,36,36,20)
//change sprite to third frame
SetSpriteFrame(player_sprite,3)
//player movment speed
global speed = 5
//player points
global points = 0
//player rank
global rank as String
rank = "none"

//player and stick random pos for the begining of the game
random_pos(player_sprite)
random_pos(stick_sprite)

//create text
global points_txt = 1
global rank_txt = 2
CreateText(points_txt,"points")
CreateText(rank_txt,"rank")
SetTextPosition(points_txt,50,10)
SetTextPosition(rank_txt,250,10)
SetTextSize(points_txt,30)
SetTextSize(rank_txt,30)


//game loop
do
    
	control_player(player_sprite)
    pick_stick(player_sprite)
    update_text()
    Sync()
loop


function random_pos(sid)
	x = random(1,300)
	y =  random(1,300)
	
	setspriteX(sid,x)
	setspriteY(sid,y)

endfunction

function control_player(sid)
	x = GetSpriteX(sid)
	y = GetSpriteY(sid)
	
	key = GetRawKeyState(38) //up arrow
	if key
		setspritey(sid,y-speed)
		SetSpriteFrame(sid,1)
	endif
	
	key = GetRawKeyState(40) //down arrow
	if key
		setspritey(sid,y+speed)
		SetSpriteFrame(sid,3)
	endif
	
	key = GetRawKeyState(37) //down left
	if key
		setspritex(sid,x-speed)
		SetSpriteFrame(sid,4)
	endif
	
	key = GetRawKeyState(39) //down right
	if key
		setspritex(sid,x+speed)
		SetSpriteFrame(sid,2)
	endif
endfunction

function pick_stick(sid)
	
	if GetSpriteCollision(sid,stick_sprite)
		random_pos(stick_sprite)
		inc points
	endif
	
endfunction

function update_text()
	SetTextString(points_txt,"points: "+str(points))
	SetTextString(rank_txt,"rank: "+rank)
	
	if points > 10 then rank = "stick picker" 
	if points > 20 then rank = "pro stick picker" 
	if points > 30 then rank = "master stick picker" 
	if points > 40 then rank = "no life" 
endfunction
