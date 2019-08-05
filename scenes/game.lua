local composer = require( "composer" )
local physics = require( "physics" )
local BackgroundCreator = require( "src.BackgroundCreator" )
local GroundCreator = require( "src.GroundCreator" )
local CharacterCreator = require( "src.CharacterCreator" )
local CameraCreator = require( "src.CameraCreator" )

local scene = composer.newScene()

local bg, ground, mainPg, camera
 
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
    bg:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg:addImage('assets/backgrounds/Background3.png', 384, 224)
    
    ground = GroundCreator('assets/ground.png', 384, 64)

    mainPg = CharacterCreator()
    mainPg:setSprite("assets.pg.pg-sheet", "assets/pg/pg-sheet.png", {
        { name = 'idle', frames = {
            'idle-0',
            'idle-1',
            'idle-2',
            'idle-3',
            'idle-4',
            'idle-5',
            'idle-6',
            'idle-7',
            'idle-8',
            'idle-9',
            'idle-10',
            'idle-11'
        }, time = 800},
        { name = 'run', frames = {
            'run-0',
            'run-1',
            'run-2',
            'run-3',
            'run-4',
            'run-5',
            'run-6',
            'run-7'
        }, time = 800}
    })

    camera = CameraCreator()
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
        
        mainPg:setPos(200, 200)
        mainPg:setPhysic('dynamic')

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()

        bg:show(sceneGroup)
        ground:show(sceneGroup)
        mainPg:show(sceneGroup)

        for i, displayObject in ipairs(bg.displayObjects) do
            camera:addDisplayObject(displayObject)
        end
        camera:addDisplayObject(ground.displayObject)
        camera:addDisplayObject(mainPg.displayObject)

        mainPg.displayObject:setSequence("runLeft")
        mainPg.displayObject:play()

        Runtime:addEventListener('enterFrame', function()
            
        end)
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