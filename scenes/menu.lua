local composer = require( "composer" )
local Background = require( "src.LayeredBackground" )
local Button = require( "src.Button" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local bg, titleButton
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    -- Qui creiamo gli oggetti che ci serviranno all'interno della scena

    bg = Background:new(sceneGroup)
    bg:addLayer('assets/backgrounds/plx-1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-3.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-4.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-5.png', display.contentWidth, display.contentHeight)
    
    titleButton = Button:new("assets/backgrounds/title.png", 300, 200)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Qui settiamo la posizione degli oggetti perchè se la scena viene ricaricata ripartirebbe da qui e non da create()

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY
        
        titleButton.x = display.contentCenterX
        titleButton.y = titleButton.height / 2

        titleButton:registerBeforeTouchHandler(function()
        end)

        titleButton:registerAfterTouchHandler(function()
            audio.play( roar )
            composer.gotoScene( "scenes.game", {
                effect = "fade",
                time = 500
            })
        end)

        roar = audio.loadSound( "assets/audio/roar.wav" )

        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Qui mostriamo gli oggetti e facciamo partire audio ed eventuali timer
        bg:init()
        titleButton:init()
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        -- Qui stoppiamo fisica, audio ed eventuali timer
        titleButton:delete()
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        audio.dispose( roar )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    -- Qui facciamo il dispose dell'audio e rimuoviamo i listener per tutti gli oggetti che non sono dentro a sceneGroup (se un displayObject viene inserito all'interno dello sceneGroup corona si occupa di rimuoverlo per noi - listeners compresi) 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene