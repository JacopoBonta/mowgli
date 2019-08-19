-- zizza suka
local composer = require( "composer" )
local physics = require( "physics" )
local Background = require( "src.Background" )
local Ground = require( "src.Ground" )
local Character = require( "src.Character" )
local Camera = require( "src.Camera" )
local Button = require( "src.Button" )

local scene = composer.newScene()

local bg, ground, mainPg, camera
local leftButton, rightButton

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

    bg = Background()
    bg2 = Background()
    bg3 = Background()
    bg:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg:addImage('assets/backgrounds/Background3.png', 384, 224)
    bg2:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg2:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg2:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg2:addImage('assets/backgrounds/Background3.png', 384, 224)
    bg3:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg3:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg3:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg3:addImage('assets/backgrounds/Background3.png', 384, 224)

    ground1 = Ground('assets/ground.png', 384, 64)
    ground2 = Ground('assets/ground.png', 384, 64)
    ground3 = Ground('assets/ground.png', 384, 64)

    mainPg = Character()
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

    camera = Camera()
    leftButton = Button()
    leftButton:setSprite("assets/buttons/left.png", 32, 32)
    rightButton = Button()
    rightButton:setSprite("assets/buttons/right.png", 32, 32)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    local pgSpeed = 2
    local cameraSpeed = 2

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- physics.setDrawMode( "hybrid" )

        bg:setPos(display.contentCenterX, display.contentCenterY)
        bg2:setPos(display.contentCenterX * 3, display.contentCenterY)
        bg3:setPos(display.contentCenterX * 5, display.contentCenterY)

        ground1:setPos(display.contentCenterX, display.contentHeight - 16)
        ground1:setPhysic('static')
        ground2:setPos(display.contentCenterX * 3, display.contentHeight - 16)
        ground2:setPhysic('static')
        ground3:setPos(display.contentCenterX * 5, display.contentHeight - 16)
        ground3:setPhysic('static')

        mainPg:setPos(display.contentCenterX / 2, 160)
        mainPg:setPhysic('dynamic')

        leftButton:setPos(32, 192)
        leftButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('right', pgSpeed)
        end)
        leftButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

        rightButton:setPos(352, 192)
        rightButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('left', pgSpeed)
        end)
        rightButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

        camera:setPos(0,0)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()

        bg:show(sceneGroup)
        bg2:show(sceneGroup)
        bg3:show(sceneGroup)

        for i, displayObject in ipairs(bg.displayObjects) do
            camera:addDisplayObject(displayObject)
        end
        for i, displayObject in ipairs(bg2.displayObjects) do
            camera:addDisplayObject(displayObject)
        end
        for i, displayObject in ipairs(bg3.displayObjects) do
            camera:addDisplayObject(displayObject)
        end

        ground1:show(sceneGroup)
        ground2:show(sceneGroup)
        ground3:show(sceneGroup)

        camera:addDisplayObject(ground1.displayObject)
        camera:addDisplayObject(ground2.displayObject)
        camera:addDisplayObject(ground3.displayObject)

        mainPg:show(sceneGroup)
        camera:addDisplayObject(mainPg.displayObject)

        leftButton:show()
        rightButton:show()

        mainPg.displayObject:setSequence("runLeft")
        mainPg.displayObject:play()

        Runtime:addEventListener('enterFrame', function()
            if mainPg.pv > 0 then
                mainPg:updatePosition()
            end

            -- update camera
            if mainPg.displayObject.x >= camera.borderRight - 80 then
                camera:moveForward(cameraSpeed)
            elseif mainPg.displayObject.x <= camera.borderLeft + 80 then
                camera:moveBackward(cameraSpeed)
            end
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
