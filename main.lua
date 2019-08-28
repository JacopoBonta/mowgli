local composer = require( "composer" )
 
-- Code to initialize your app

-- hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- enable multitouch
system.activate( "multitouch" )
 
composer.gotoScene( "scenes.game", {
    effect = "crossFade",
    time = 500
})