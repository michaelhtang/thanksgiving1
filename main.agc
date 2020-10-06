
// Project: TurkeyRun 
// Created: 2020-10-02
// Author: Michael Tang

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Turkey Run" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
// Variables
turkeyCaught = 0
gameOver = 0

// Images
LoadImage(1, "turkey.png")
LoadImage(2, "farmer.png")
CreateImageColor(3, 255, 200, 70, 255)


// Create Background
CreateSprite(99,3)
SetSpriteSize(99, GetVirtualWidth(), GetVirtualHeight())
SetSpritePosition(99, 0, 30)

// Create Turkey
CreateSprite(1,1)
SetSpriteScale(1, 0.25, 0.25)
SetSpriteFlip(1,1,0)
turkeyX = Random(0, GetVirtualWidth() - GetSpriteWidth(1))
turkeyY = Random(40, GetVirtualHeight() - GetSpriteHeight(1))
SetSpritePosition(1, turkeyX, turkeyY)
turkeySPD = 5
turkeyDirX = 1
turkeyDirY = 1

// Create Farmer
CreateSprite(2,2)
SetSpriteScale(2, 0.5, 0.5)
farmerX = GetVirtualWidth()/2 -  GetSpriteWidth(2)/2
farmerY = (GetVirtualHeight() - GetSpriteHeight(2))/2
farmerSPD = 5
farmerStartX = farmerX
farmerStartY = farmerY

do
	// move turkey
	turkeyX = turkeyX + turkeyDirX * turkeySPD
	turkeyY = turkeyY + turkeyDirY * turkeySPD
	// create boundries for turkey
	if turkeyX > GetVirtualWidth() - GetSpriteWidth(1)
		turkeyDirX = - 1
		SetSpriteFlip(1,0,0)
	endif
	if turkeyX < 0 
		turkeyDirX = 1
		SetSpriteFlip(1,1,0)
	endif
	if turkeyY > GetVirtualHeight() - GetSpriteHeight(1)
		turkeyDirY = - 1
		
	endif
	if turkeyY < 40
		turkeyDirY = 1
	endif
	
	// make the farmer move with wasd
	if GetRawKeyState(68) = 1 // 'd' key
		farmerX = farmerX + farmerSPD
		SetSpriteFlip(2,1,0)
	else
		if GetRawKeyState(65) = 1 // 'a' key
			farmerX = farmerX - farmerSPD
			SetSpriteFlip(2,0,0)
		endif
	endif
	if GetRawKeyState(83) = 1 // 's' key
		farmerY = farmerY + farmerSPD
	else
		if GetRawKeyState(87) = 1 // 'w' key
			farmerY = farmerY - farmerSPD
		endif
	endif
	// make boundries for farmer
	if farmerX  > GetVirtualWidth() - GetSpriteWidth(2)
		farmerX = GetVirtualWidth() - GetSpriteWidth(2)
	endif
	 if farmerX < 0
		 farmerX = 0
	 endif
	 if farmerY > GetVirtualHeight() - GetSpriteHeight(2)
		 farmerY = GetVirtualHeight() - GetSpriteHeight(2)
	 endif
	 if farmerY < 40
		 farmerY = 40
	 endif
	// Turkey Farmer Collision
	if GetSpriteCollision(1, 2)
		//reset farmer and turkey positions
		turkeyX = Random(0, GetVirtualWidth() - GetSpriteWidth(1))
		turkeyY = Random(40, GetVirtualHeight() - GetSpriteHeight(1))
		SetSpritePosition(1, turkeyX, turkeyY)
		farmerX = farmerStartX
		farmerY = farmerStartY
		SetSpritePosition(2, farmerX, farmerY)
		turkeyCaught = turkeyCaught + 1 // increases score by 1
		if turkeySPD < 25 // give turkeySPD a max 
			turkeySPD = turkeySPD + 3 // speed increases after each one is caught
		endif
		if turkeyCaught > 0
			gameOver = 1
		endif	
	endif
	Printc("Turkeys Caught: ")
	Print(turkeyCaught)
	
	while gameover = 1
		SetSpritePosition(1, GetVirtualWidth(), GetVirtualHeight())
		SetSpritePosition(2, GetVirtualHeight(), GetVirtualHeight())
		Print("Game Over")
		Print("You won")
		Print("Play again? Y/N")
		if GetRawKeyPressed(89) = 1 // 'y' key
			turkeyCaught = 0 
			turkeyX = Random(0, GetVirtualWidth() - GetSpriteWidth(1))
			turkeyY = Random(0, GetVirtualHeight() - GetSpriteHeight(1))
			SetSpritePosition(1, turkeyX, turkeyY)
			farmerX = farmerStartX
			farmerY = farmerStartY
			SetSpritePosition(2, farmerX, farmerY)
			turkeySPD = 5
			gameover = 0
		 endif
		if GetRawKeyPressed(78) = 1 // 'n' key
			end // closes the program
		endif
		Sync()
	endwhile
		
    SetSpritePosition(1, turkeyX, turkeyY)
    SetSpritePosition(2, farmerX, farmerY)
    Sync()
loop
