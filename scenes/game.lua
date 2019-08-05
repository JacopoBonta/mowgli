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
    bg:addImage('assets/backgrounds/Nuvens.png', 384, 224)
    bg:addImage('assets/backgrounds/Background1.png', 384, 224)
    bg:addImage('assets/backgrounds/Background2.png', 384, 224)
    bg:addImage('assets/backgrounds/Background3.png', 384, 224)
    
    ground = Ground('assets/ground.png', 384, 64)

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
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- physics.setDrawMode( "hybrid" )

        bg:setPos(display.contentWidth / 2, display.contentHeight / 2)

        ground:setPos(display.contentCenterX, display.contentHeight - 16)
        ground:setPhysic('static')
        
        mainPg:setPos(200, 200)
        mainPg:setPhysic('dynamic')

        leftButton:setPos(32, 192)
        leftButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('right', 1)
        end)
        leftButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

        rightButton:setPos(352, 192)
        rightButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('left', 1)
        end)
        rightButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()

        bg:show(sceneGroup)
        ground:show(sceneGroup)
        mainPg:show(sceneGroup)

        -- for i, displayObject in ipairs(bg.displayObjects) do
        --     camera:addDisplayObject(displayObject)
        -- end
        -- camera:addDisplayObject(ground.displayObject)
        -- camera:addDisplayObject(mainPg.displayObject)

        mainPg.displayObject:setSequence("runLeft")
        mainPg.displayObject:play()

        leftButton:show(sceneGroup)
        rightButton:show(sceneGroup)

        Runtime:addEventListener('enterFrame', function()
            if mainPg.pv > 0 then
                mainPg:updatePosition()
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