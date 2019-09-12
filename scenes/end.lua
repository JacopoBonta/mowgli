local Background = require( "src.Background" )
local Button = require( "src.Button" )
local composer = require( "composer" )
local scene = composer.newScene()

-- Scena finale. Mostra punteggio e pulsanti riavvia / esci

local bg

-- create() viene chiamata solo la prima volta che la scena compare. Crea sfondo e pulsanti
function scene:create( event )
 
    local sceneGroup = self.view

    bg = Background:new(sceneGroup)
    bg:addLayer('assets/backgrounds/plx-1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-3.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-4.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-5.png', display.contentWidth, display.contentHeight)

    restartBtn = Button:new("assets/buttons/restart.png", 112, 39)
    exitBtn = Button:new("assets/buttons/exit.png", 112, 39)
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        -- Qui fermiamo l'audio della scena precedente. Questo perchè se lo stoppassimo prima perderemmo il roar della tigre che azzanna mowgli
        audio.stop()

        -- resettiamo posizioni ed handler

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY

        restartBtn.x = display.contentCenterX - restartBtn.width
        restartBtn.y = display.contentCenterY

        restartBtn.afterCb = function()
            audio.play( roar )
            composer.gotoScene( "scenes.game", {
                effect = "fade",
                time = 500
            })
        end

        exitBtn.x = display.contentCenterX + exitBtn.width
        exitBtn.y = display.contentCenterY

        exitBtn.afterCb = function()
            composer.gotoScene( "scenes.menu", {
                effect = "fade",
                time = 500
            })
        end

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        -- inizializziamo gli oggetti
        bg:init()

        endText = display.newText( "Sei sopravvisuto " .. event.params.totalTime .. " secondi !!", display.contentCenterX, 35, "assets/fonts/Windlass.ttf", 22 )

        restartBtn:init()
        exitBtn:init()
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        -- eliminamo oggetti
        exitBtn:delete()
        restartBtn:delete()
        endText:removeSelf()
        endText = nil
        bg:delete()

    elseif ( phase == "did" ) then

    end
end
 
 
-- destroy()
function scene:destroy( event )
    local sceneGroup = self.view
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