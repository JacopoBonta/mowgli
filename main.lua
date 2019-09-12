local composer = require( "composer" )

-- setta il seme per il random
math.randomseed(os.time())
 
-- nasconde barra di stato
display.setStatusBar( display.HiddenStatusBar )

-- abilita il multitouch
system.activate( "multitouch" )

-- avvia la prima scena
composer.gotoScene( "scenes.menu", {
    effect = "crossFade",
    time = 500
})