local composer = require( "composer" )
local Background = require( "src.Background" )
local Button = require( "src.Button" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
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
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY

        restartBtn.x = display.contentCenterX - restartBtn.width
        restartBtn.y = display.contentCenterY

        restartBtn:registerBeforeTouchHandler(function()
        end)

        restartBtn:registerAfterTouchHandler(function()
            audio.play( roar )
            composer.gotoScene( "scenes.game", {
                effect = "fade",
                time = 500
            })
        end)

        exitBtn.x = display.contentCenterX + exitBtn.width
        exitBtn.y = display.contentCenterY

        exitBtn:registerBeforeTouchHandler(function()
        end)
        exitBtn:registerAfterTouchHandler(function()
            audio.play( roar )
            composer.gotoScene( "scenes.menu", {
                effect = "fade",
                time = 500
            })
        end)

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        endText = display.newText( "Sei sopravvisuto " .. event.params.totalTime .. "!!", display.contentCenterX, 25, "assets/fonts/Windlass.ttf", 18 )

        bg:init()
        restartBtn:init()
        exitBtn:init()

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen
        exitBtn:delete()
        restartBtn:delete()
        endText:removeSelf()
        endText = nil
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        bg:delete()
        
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
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