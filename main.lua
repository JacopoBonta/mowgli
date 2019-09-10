local composer = require( "composer" )

math.randomseed(os.time())
 
-- Code to initialize your app

-- hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- enable multitouch
system.activate( "multitouch" )
 
composer.gotoScene( "scenes.menu", {
    effect = "crossFade",
    time = 500
})