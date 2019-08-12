local composer = require( "composer" )
 
-- Code to initialize your app
system.activate( "multitouch" )
 
composer.gotoScene( "scenes.menu", {
    effect = "crossFade",
    time = 500
})