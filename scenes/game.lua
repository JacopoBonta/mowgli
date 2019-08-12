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
    -- Qui creiamo gli oggetti che ci serviranno all'interno della scena

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
    leftButton:setImage("assets/buttons/left.png", 32, 32)
    rightButton = Button()
    rightButton:setImage("assets/buttons/right.png", 32, 32)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    local pgSpeed = 2
    local cameraSpeed = 2
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Qui settiamo la posizione degli oggetti perchè se la scena viene ricaricata ripartirebbe da qui e non da create()

        bg:setPos(display.contentCenterX, display.contentCenterY)
        bg2:setPos(display.contentCenterX * 3, display.contentCenterY)
        bg3:setPos(display.contentCenterX * 5, display.contentCenterY)
        bg:setCamera(camera.displayObjects)
        bg2:setCamera(camera.displayObjects)
        bg3:setCamera(camera.displayObjects)

        ground1:setPos(display.contentCenterX, display.contentHeight - 16)
        ground1:setPhysic('static')
        ground1:setCamera(camera.displayObjects)
        ground2:setPos(display.contentCenterX * 3, display.contentHeight - 16)
        ground2:setPhysic('static')
        ground2:setCamera(camera.displayObjects)
        ground3:setPos(display.contentCenterX * 5, display.contentHeight - 16)
        ground3:setPhysic('static')
        ground3:setCamera(camera.displayObjects)
        
        mainPg:setPos(display.contentCenterX / 2, 160)
        mainPg:setPhysic('dynamic')
        mainPg:setCamera(camera.displayObjects)

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
        -- Qui mostriamo gli oggetti e facciamo partire audio ed eventuali timer

        physics.start()
        physics.setDrawMode( "hybrid" )

        sceneGroup:insert(camera.displayObjects)

        bg:show()
        bg2:show()
        bg3:show()

        leftButton:show(sceneGroup)
        rightButton:show(sceneGroup)

        ground1:show()
        ground2:show()
        ground3:show()

        mainPg:show()

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
        -- Qui stoppiamo fisica, audio ed eventuali timer 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
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