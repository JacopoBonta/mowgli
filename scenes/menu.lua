local composer = require( "composer" )
local Background = require( "src.Background" )
local Button = require( "src.Button" )
 
local scene = composer.newScene()

-- Scena menu. Mostriamo lo sfondo ed il pulsante per passare alla scena di gioco
 
local bg, titleButton
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create() viene chiamata una sola volta. Qui vengono creati gli oggetti che saranno utilizzati nel menu
function scene:create( event )
 
    local sceneGroup = self.view

    bg = Background:new(sceneGroup)
    -- il background è formato da più strati. Attenzione all'ordinamento.
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

        -- resettiamo la posizione degli oggetti

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY
        
        titleButton.x = display.contentCenterX
        titleButton.y = titleButton.height / 2

        -- registriamo la funzione che sarà eseguita al tocco del pulsante
        titleButton:registerAfterTouchHandler(function()
            audio.play( roar )
            composer.gotoScene( "scenes.game", {
                effect = "fade",
                time = 500
            })
        end)

        -- carichiamo il suono
        roar = audio.loadSound( "assets/audio/roar.wav" )
    elseif ( phase == "did" ) then
        
        -- inizializziamo gli oggetti
        bg:init()
        titleButton:init()
    end
end

-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- cancelliamo gli oggetti al cambio scena
        titleButton:delete()
        bg:delete()
        
    elseif ( phase == "did" ) then

    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    audio.dispose( roar )
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