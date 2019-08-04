local composer = require( "composer" )
local physics = require( "physics" )
local BackgroundCreator = require( "src.BackgroundCreator" )
local GroundCreator = require( "src.GroundCreator" )
 
local scene = composer.newScene()

local bg, ground
 
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

    bg = BackgroundCreator()
    ground = GroundCreator('assets/ground.png', 384, 64)


    bg:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg:addImage('assets/backgrounds/Background3.png', 384, 224)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- physics.setDrawMode( "hybrid" )

        bg:setPos(display.contentWidth / 2, display.contentHeight / 2)

        ground:setPos(display.contentCenterX, display.contentHeight - 16)
        ground:setPhysic('static')
        

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()

        bg:show(sceneGroup)
        ground:show(sceneGroup)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
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