-- zizza suka
local composer = require( "composer" )
local physics = require( "physics" )
local LayeredBackground = require( "src.LayeredBackground" )
local Ground = require( "src.Ground" )
local Character = require( "src.Character" )
local Camera = require( "src.Camera" )
local ButtonImage = require( "src.ButtonImage" )
local scene = composer.newScene()

local bg, mainPg, camera
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

    bg = LayeredBackground:new()
    
    bg:addLayer('assets/backgrounds/Nuvens.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background3.png', display.contentWidth, display.contentHeight)

    firstGround = Ground:new('assets/ground.png', display.contentWidth, 70)
    secondGround = Ground:new('assets/ground.png', display.contentWidth, 70)

    mainPg = Character:new()
    mainPg:setSprite("assets.pg.pg-sheet", "assets/pg/pg-sheet.png")

    camera = Camera:new()
    bg:addToCamera(camera.displayObjects)
    firstGround:addToCamera(camera.displayObjects)
    secondGround:addToCamera(camera.displayObjects)
    mainPg:addToCamera(camera.displayObjects)


    leftButton = ButtonImage:new()
    leftButton:setImage("assets/buttons/left.png", 32, 32)

    rightButton = ButtonImage:new()
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

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY

        -- position the current ground and the next ground
        firstGround.x = display.contentCenterX
        firstGround.y = display.contentHeight - 16
        secondGround.x = firstGround.x + firstGround.width
        secondGround.y = firstGround.y
        
        mainPg.x = display.contentCenterX - 20
        mainPg.y = 160
        mainPg:setPhysic('dynamic')

        leftButton.x = 60
        leftButton.y = display.contentHeight - 40
        leftButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('left', pgSpeed)
        end)
        leftButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

        rightButton.x = display.contentWidth - 60
        rightButton.y = display.contentHeight - 40
        rightButton:registerBeforeTouchHandler(function()
            mainPg:setDirection('right', pgSpeed)
        end)
        rightButton:registerAfterTouchHandler(function()
            mainPg:stand()
        end)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Qui mostriamo gli oggetti e facciamo partire audio ed eventuali timer

        physics.start()
        -- physics.setDrawMode( "hybrid" )

        sceneGroup:insert(camera.displayObjects)

        bg:show()
        
        mainPg:show()
        leftButton:show(sceneGroup)
        rightButton:show(sceneGroup)

        firstGround:show()

        local currentGround = firstGround
        local nextGround = secondGround

        mainPg:setDirection('right', pgSpeed)

        Runtime:addEventListener('enterFrame', function()
            if mainPg.pv > 0 then
                -- update player position
                mainPg:updatePosition()

                -- print the next ground when the character reach half of the camera viewport
                if (mainPg.sprite.x >= camera.borderRight / 2) and nextGround.isShow == false then
                    print('load next ground')
                    nextGround:show()
                end

                -- if the ground disapper from the screen to the left, assign the next ground to the current one and generate a new ground as the next ground
                if (currentGround.x + currentGround.width / 2) < camera.borderLeft then
                    currentGround:delete()
                    currentGround = nextGround
                    nextGround = Ground:new('assets/ground.png', display.contentWidth, 70)
                    nextGround.y = currentGround.y
                    nextGround.x = currentGround.x + currentGround.width
                    nextGround:addToCamera(camera.displayObjects)
                    print('deleted off screen ground and created new one')
                end

                -- update camera position if player have almost reach the end
                if mainPg.sprite.x > camera.borderRight - 80 then
                    camera:moveForward(cameraSpeed)
                elseif mainPg.sprite.x < camera.borderLeft + 80 then
                    camera:moveBackward(cameraSpeed)
                end
            else
                print('game over')
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
